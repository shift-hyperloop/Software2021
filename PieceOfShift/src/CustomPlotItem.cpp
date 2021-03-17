#include "CustomPlotItem.h"
#include "Processing/datamanager.h"
#include <QDebug>
#include <qcolor.h>
#include <qevent.h>
#include <qnamespace.h>
#include <qpalette.h>
#include <qsize.h>
#include <qtconcurrentrun.h>
#include <qtooltip.h>
#include <QtMath>
 
CustomPlotItem::CustomPlotItem( QQuickItem* parent ) : QQuickPaintedItem( parent )   
    , m_CustomPlot( nullptr )
{
    setFlag( QQuickItem::ItemHasContents, true );
    // setRenderTarget(QQuickPaintedItem::FramebufferObject);
    // setAcceptHoverEvents(true);
    setAcceptedMouseButtons( Qt::AllButtons );
 
    connect( this, &QQuickPaintedItem::widthChanged, this, &CustomPlotItem::updateCustomPlotSize );
    connect( this, &QQuickPaintedItem::heightChanged, this, &CustomPlotItem::updateCustomPlotSize );
}
 
CustomPlotItem::~CustomPlotItem()
{
    delete m_CustomPlot;
    m_CustomPlot = nullptr;
}

void CustomPlotItem::addData(QPointF data, int graphNum)
{
    m_CustomPlot->graph(graphNum)->addData(data.x(), data.y());
    m_CustomPlot->xAxis->setRange(data.x(), m_XSize, Qt::AlignRight);
    //m_CustomPlot->yAxis->setRange(data.y(), 1000, Qt::AlignTop);
    m_CustomPlot->replot(); 
}
void CustomPlotItem::setGraphColor(int graphIndex, QColor color)
{
    //function sets graph color, and a lighter highlight color.
    //2 is the width of the pens
    m_CustomPlot->graph(graphIndex)->setPen(QPen(color, 2));
    m_CustomPlot->graph(graphIndex)->selectionDecorator()->setPen( QPen(color.lighter(150), 3) );
}
void CustomPlotItem::legendVisible(bool visible){
    m_CustomPlot->legend->setVisible(visible);
}

void CustomPlotItem::setName(int graphIndex, QString name){
    m_CustomPlot->graph(graphIndex)->setName(name);
    QFont legendFont;
    QSize screenRes = QGuiApplication::primaryScreen()->size();

    int screenFactor = screenRes.width() / 100;
    legendFont.setPointSize(screenFactor >> 1);
    m_CustomPlot->legend->setFont(legendFont);
    m_CustomPlot->legend->setSelectedFont(legendFont);
    m_CustomPlot->legend->setSelectableParts(QCPLegend::spItems); 
    m_CustomPlot->legend->setIconSize(QSize(screenFactor, screenFactor));
    m_CustomPlot->legend->setVisible(true);
    m_CustomPlot->rescaleAxes();
}
void CustomPlotItem::setAxisLabels(QString xAxis, QString yAxis){
    m_CustomPlot->xAxis->setLabel(xAxis);
    m_CustomPlot->yAxis->setLabel(yAxis);
}
void CustomPlotItem::setDataType(QString dataType)
{
    QtConcurrent::run(m_DMAccessor.dataManager(), &DataManager::registerPlot, this, dataType);
}

void CustomPlotItem::setAxisRange(QPoint x, QPoint y)
{
    m_XSize = x.y() - x.x(); 
    m_CustomPlot->xAxis->setRange(x.x(), x.y());
    m_CustomPlot->yAxis->setRange(y.x(), y.y());
}

void CustomPlotItem::setBackgroundColor(QColor color){
    m_CustomPlot->setBackground(color);

}
void CustomPlotItem::setSimpleGraph(){
    m_CustomPlot ->setInteraction(QCP::iRangeDrag, false);
    m_CustomPlot ->setInteraction(QCP::iRangeZoom, false);
    m_CustomPlot ->setInteraction(QCP::iSelectPlottables, false);

}
void CustomPlotItem::initCustomPlot(int numOfGraphs)
{
    m_CustomPlot = new QCustomPlot();
 
    updateCustomPlotSize();
 
    setupGraph(m_CustomPlot, numOfGraphs);
 
    connect( m_CustomPlot, &QCustomPlot::afterReplot, this, &CustomPlotItem::onCustomReplot );
    //connect(m_CustomPlot, &QCustomPlot::mouseMove, this, &CustomPlotItem::mouseMoveEvent);
    connect(m_CustomPlot, &QCustomPlot::plottableClick, this, &CustomPlotItem::graphClicked);

    m_CustomPlot->replot();
}
 
 
void CustomPlotItem::paint( QPainter* painter )
{
    if (m_CustomPlot)
    {
        QPixmap    picture( boundingRect().size().toSize() );
        QCPPainter qcpPainter( &picture );
 
        //m_CustomPlot->replot();
        m_CustomPlot->toPainter( &qcpPainter );
 
        painter->drawPixmap( QPoint(), picture );
    }
}
 
void CustomPlotItem::mousePressEvent( QMouseEvent* event )
{
    routeMouseEvents( event );
}
 
void CustomPlotItem::mouseReleaseEvent( QMouseEvent* event )
{
    routeMouseEvents( event );
}
 
void CustomPlotItem::mouseMoveEvent( QMouseEvent* event )
{    
    routeMouseEvents( event );
}
 
void CustomPlotItem::mouseDoubleClickEvent( QMouseEvent* event )
{
    routeMouseEvents( event );   
}
 
void CustomPlotItem::graphClicked(QCPAbstractPlottable *plottable, int dataIndex, QMouseEvent *event)
{
    int x = m_CustomPlot->xAxis->pixelToCoord(event->pos().x());
    int y = m_CustomPlot->yAxis->pixelToCoord(event->pos().y());

    QPalette toolTipPallete;
    toolTipPallete.setColor(QPalette::ToolTipBase, QColor(68, 68, 68));
    toolTipPallete.setColor(QPalette::ToolTipText, QColor(200, 200, 200));

    QToolTip::showText(event->globalPos(), QString("(%1, %2)").arg(x).arg(y));

    QPalette p = QToolTip::palette();
    p.setColor(QPalette::All, QPalette::ToolTipText, QColor(220, 220, 220));
    p.setColor(QPalette::All, QPalette::ToolTipBase, QColor(68, 68, 68));
    QToolTip::setPalette( p );
}
 
void CustomPlotItem::routeMouseEvents(QMouseEvent* event)
{
    if (m_CustomPlot)
    {
        QMouseEvent* newEvent = new QMouseEvent( event->type(), event->localPos(), event->button(), event->buttons(), event->modifiers() );
        //QCoreApplication::sendEvent( m_CustomPlot, newEvent );
        QCoreApplication::postEvent( m_CustomPlot, newEvent );
    }
}

void CustomPlotItem::routeWheelEvents(QWheelEvent* event)
{
    if (m_CustomPlot)
    {
        QWheelEvent* newEvent = new QWheelEvent( event->pos(), event->delta(), event->buttons(), event->modifiers(), event->orientation() );
        QCoreApplication::postEvent( m_CustomPlot, newEvent );
    }
}
 
void CustomPlotItem::wheelEvent(QWheelEvent *event)
{
    routeWheelEvents( event );
}
 
void CustomPlotItem::updateCustomPlotSize()
{
    if (m_CustomPlot)
    {
        m_CustomPlot->setGeometry(0, 0, (int)width(), (int)height());
        m_CustomPlot->setViewport(QRect(0, 0, (int)width(), (int)height()));
    }
}
 
void CustomPlotItem::onCustomReplot()
{
    update();
}

void CustomPlotItem::remove()
{
    m_DMAccessor.dataManager()->removePlot(this);
}
 
void CustomPlotItem::setupGraph( QCustomPlot* customPlot, int numOfGraphs)
{
    m_CustomPlot->setOpenGl(true, 4);
    for(int i = 0; i < numOfGraphs; i++){
        customPlot->addGraph();
        customPlot->graph(i)->setData(m_X, m_Y);
        m_CustomPlot->graph(i)->setPen(QPen(QColor("#0099ff"), 2));
    }
    // give the axes some labels:
    customPlot->xAxis->setLabel("time");
    customPlot->yAxis->setLabel("value");
    // set axes ranges, so we see all data:
    customPlot->xAxis->setRange(0, 100);
    customPlot->yAxis->setRange(0, 500);

    // Styling
    customPlot->xAxis->setBasePen(QPen(Qt::lightGray, 1));
    customPlot->yAxis->setBasePen(QPen(Qt::lightGray, 1));
    customPlot->xAxis->setTickPen(QPen(Qt::lightGray, 1));
    customPlot->yAxis->setTickPen(QPen(Qt::lightGray, 1));
    customPlot->xAxis->setSubTickPen(QPen(Qt::lightGray, 1));
    customPlot->yAxis->setSubTickPen(QPen(Qt::lightGray, 1));
    customPlot->xAxis->setTickLabelColor(Qt::lightGray);
    customPlot->yAxis->setTickLabelColor(Qt::lightGray);
    customPlot->xAxis->setLabelColor(Qt::lightGray);
    customPlot->yAxis->setLabelColor(Qt::lightGray);
    customPlot->setBackground(QColor(68, 68, 68));
 
    customPlot ->setInteractions( QCP::iRangeDrag | QCP::iRangeZoom | QCP::iSelectPlottables );

}

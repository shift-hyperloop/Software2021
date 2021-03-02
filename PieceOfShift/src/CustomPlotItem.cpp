#include "CustomPlotItem.h"
#include <QDebug>
#include <qcolor.h>
#include <qnamespace.h>
 
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

void CustomPlotItem::addData(QPointF data)
{
    m_CustomPlot->graph(0)->addData(data.x(), data.y());
    m_CustomPlot->xAxis->setRange(data.x(), 20, Qt::AlignRight);
    //m_CustomPlot->yAxis->setRange(data.y(), 1000, Qt::AlignTop);
    m_CustomPlot->replot(); 
}

void CustomPlotItem::setDataType(QString dataType)
{
    m_DMAccessor.dataManager()->registerPlot(this, dataType);
}
 
void CustomPlotItem::initCustomPlot()
{
    m_CustomPlot = new QCustomPlot();
 
    updateCustomPlotSize();
 
    setupQuadraticDemo( m_CustomPlot );
 
    connect( m_CustomPlot, &QCustomPlot::afterReplot, this, &CustomPlotItem::onCustomReplot );

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
 
void CustomPlotItem::graphClicked( QCPAbstractPlottable* plottable )
{
}
 
void CustomPlotItem::routeMouseEvents( QMouseEvent* event )
{
    if (m_CustomPlot)
    {
        QMouseEvent* newEvent = new QMouseEvent( event->type(), event->localPos(), event->button(), event->buttons(), event->modifiers() );
        //QCoreApplication::sendEvent( m_CustomPlot, newEvent );
        QCoreApplication::postEvent( m_CustomPlot, newEvent );
    }
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
 
void CustomPlotItem::setupQuadraticDemo( QCustomPlot* customPlot )
{
    customPlot->addGraph();
    customPlot->graph(0)->setPen( QPen( QColor("#0099ff")) );
    customPlot->graph(0)->selectionDecorator()->setPen( QPen( Qt::blue, 2 ) );
    customPlot->graph(0)->setData( m_X, m_Y );
 
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
    customPlot->setBackground(QColor(55, 55, 55));
 
    customPlot ->setInteractions( QCP::iRangeDrag | QCP::iRangeZoom | QCP::iSelectPlottables );
    connect( customPlot, SIGNAL( plottableClick( QCPAbstractPlottable*, QMouseEvent* ) ), this, SLOT( graphClicked( QCPAbstractPlottable* ) ) );
}
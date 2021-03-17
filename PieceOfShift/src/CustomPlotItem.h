#pragma once
 
#include <QtQuick>
#include <qevent.h>
#include <qobjectdefs.h>
#include <qpoint.h>
#include "include/qcustomplot/qcustomplot.h"
#include "Processing/datamanager.h"

class QCustomPlot;

class CustomPlotItem : public QQuickPaintedItem
{
    Q_OBJECT
 
public:
    CustomPlotItem(QQuickItem* parent = 0);
    virtual ~CustomPlotItem();
 
    void paint( QPainter* painter );
    inline QCustomPlot* getCustomPlot() { return m_CustomPlot; }
 
    Q_INVOKABLE void initCustomPlot(int numOfGraphs);
    Q_INVOKABLE void addData(QPointF data, int graphNum);
    Q_INVOKABLE void setDataType(QString dataType);
    Q_INVOKABLE void setGraphColor(int graphIndex, QColor color);
    Q_INVOKABLE void setName(int graphIndex, QString name);
    Q_INVOKABLE void legendVisible(bool visible);
    Q_INVOKABLE void setAxisLabels(QString xAxis, QString yAxis);
    Q_INVOKABLE void remove();

protected:
    void routeMouseEvents(QMouseEvent* event);
    void routeWheelEvents(QWheelEvent* event);
 
    virtual void mousePressEvent(QMouseEvent* event);
    virtual void mouseReleaseEvent(QMouseEvent* event);
    virtual void mouseMoveEvent(QMouseEvent* event);
    virtual void mouseDoubleClickEvent(QMouseEvent* event);
    virtual void wheelEvent(QWheelEvent* event);
 
    void setupGraph(QCustomPlot* customPlot, int numOfGraphs);
 
private:
    QCustomPlot* m_CustomPlot;
    QVector<double> m_X, m_Y;
    DataManagerAccessor m_DMAccessor;
 
private slots:
    void graphClicked(QCPAbstractPlottable *plottable, int dataIndex, QMouseEvent *event);
    void onCustomReplot();   
    void updateCustomPlotSize();    
    
};

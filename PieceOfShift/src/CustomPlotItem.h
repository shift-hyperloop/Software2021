#pragma once
 
#include <QtQuick>
#include <qobjectdefs.h>
#include <qpoint.h>
#include "include/qcustomplot/qcustomplot.h"
#include "Processing/datamanager.h"

class QCustomPlot;

class CustomPlotItem : public QQuickPaintedItem
{
    Q_OBJECT
 
public:
    CustomPlotItem( QQuickItem* parent = 0 );
    virtual ~CustomPlotItem();
 
    void paint( QPainter* painter );
 
    Q_INVOKABLE void initCustomPlot(); 
    Q_INVOKABLE void addData(QPointF data);
    Q_INVOKABLE void setDataType(QString dataType);
 
protected:
    void routeMouseEvents( QMouseEvent* event );
 
    virtual void mousePressEvent( QMouseEvent* event );
    virtual void mouseReleaseEvent( QMouseEvent* event );
    virtual void mouseMoveEvent( QMouseEvent* event );
    virtual void mouseDoubleClickEvent( QMouseEvent* event );
 
    void setupQuadraticDemo( QCustomPlot* customPlot );
 
private:
    QCustomPlot*         m_CustomPlot;
    QVector<double> m_X, m_Y;
    DataManagerAccessor m_DMAccessor;
 
private slots:
    void graphClicked( QCPAbstractPlottable* plottable );
    void onCustomReplot();   
    void updateCustomPlotSize();
    
};
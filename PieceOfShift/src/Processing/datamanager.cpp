#include "datamanager.h"
#include "velocityprocessingunit.h"
#include "accelerationprocessingunit.h"
#include "accelerationvelocityunit.h"
#include "src/CustomPlotItem.h"
#include <qpoint.h>
#include <qrandom.h>
#include <qthread.h>

DataManager::DataManager()
{
    /* Create and append all processing units here,
     * maybe refactor to separate function
     */
    VelocityProcessingUnit* vpu = new VelocityProcessingUnit();
    processingUnits.append(vpu);
    AccelerationProcessingUnit* apu = new AccelerationProcessingUnit();
    processingUnits.append(apu);
    AccelerationVelocityUnit* avu = new AccelerationVelocityUnit();
    processingUnits.append(avu);

    // Connect newData signal to corresponding DataManager signal
    connect(vpu, &VelocityProcessingUnit::newData,
            this, &DataManager::newVelocity);
    connect(apu, &AccelerationProcessingUnit::newData,
            this, &DataManager::newAcceleration);
    connect(avu, &AccelerationVelocityUnit::newData,
            this, &DataManager::newAccelerationVelocity);


    connect(&canServer, &CANServer::dataReceived,
            &decoder, &Decoder::checkData);

    connect(&decoder, &Decoder::addData,
            this, &DataManager::addData);

    connect(&canServer, &CANServer::connectionEstablished,
            this, &DataManager::podConnectionEstablished);

    connect(&canServer, &CANServer::connectionTerminated,
            this, &DataManager::podConnectionTerminated);


    /* Create Decoder/DataFetcher object here and start it when signal from
     QML has been received */
}

DataManager::~DataManager()
{
    // Delete all processing units on destruction to avoid memory leak
    for (auto processingUnit : processingUnits) {
        delete processingUnit;
    }
}

void DataManager::addData(const QString& name, const DataType &dataType, const QVariant &data)
{
    // Find processing unit with correct data type and add data
    ProcessingUnit* processingUnit =
            *std::find_if(processingUnits.begin(),
                          processingUnits.end(),
                          [&dataType](auto x)
                          { return x->dataType() == dataType; });
    QtConcurrent::run(processingUnit, &ProcessingUnit::addData, name, data);
    //processingUnit->addData(name, data);

    // ADD TO PLOT DATA IF IS PLOT DATA
    // plotData.value(name).first->append(data)
}

void DataManager::connectToPod(QString hostname, QString port)
{
    canServer.connectToPod(hostname, port);
}

void DataManager::sendPodCommand(CANServer::PodCommand messageType)
{
    canServer.sendPodCommand(messageType);
}

void DataManager::registerPlot(CustomPlotItem* plotItem, const QString &name)
{
    if (!plotItems.contains(name)) {
        QList<CustomPlotItem*>* plotItemList = new QList<CustomPlotItem*>();
        plotItemList->append(plotItem);
        plotItems.insert(name, plotItemList);
        if (plotData.hasKey(name)) {
            for (unsigned int i = 0; i < plotItem->getCustomPlot()->graphCount(); i++) 
            {
                plotItem->getCustomPlot()->graph(i)->setData(plotData.getXValues(name, i), plotData.getYValues(name, i));       
            }
        } else {
            plotData.insertEmpty(name);
        }
    } else {
        for (unsigned int i = 0; i < plotItem->getCustomPlot()->graphCount(); i++) 
        {
            plotItem->getCustomPlot()->graph(i)->setData(plotData.getXValues(name, i), plotData.getYValues(name, i));       
        }
        plotItems.value(name)->append(plotItem);
    }
}

void DataManager::removePlot(CustomPlotItem *plotItem)
{
    for (QString name : plotItems.keys()) {
        if (plotItems.value(name)->indexOf(plotItem)) {
            if (plotItems.value(name)->size() == 0) {
                plotItems.remove(name);
                return;
            }
            plotItems.value(name)->removeOne(plotItem);
        }
    }
}

long timeMs = 0;
QRandomGenerator generator(1000224242);
void DataManager::dummyData()
{
    if (timeMs > 1200) {
        return;
    }

    QPointF data1;
    if (timeMs < 1000) {
        data1 = QPointF(timeMs, generator.bounded(5) + exp(timeMs*0.005 ));
    } else if (timeMs < 1100) {
        data1 = QPointF(timeMs, generator.bounded(5) + exp(1/timeMs*0.1 ));
    } else {
        data1 = QPointF(timeMs, 0);
    }
    QPointF data2(timeMs, generator.bounded(10) + 200 + 20*sin(timeMs));
    for (CustomPlotItem* plot : *plotItems.value("Velocity")) 
    {
        plot->addData(data1, 0);
        plot->addData(data2, 1);
        plotData.addData("Velocity", 0, data1);
        plotData.addData("Velocity", 1, data2);
    }
    QPointF vdat1 = QPointF(timeMs, generator.bounded(5) + exp(1/(timeMs + 1)));
    QPointF vdat2 = QPointF(timeMs, generator.bounded(5) + 2*exp(1/(timeMs + 1)));
    QPointF vdat3 = QPointF(timeMs, generator.bounded(5) + 3*exp(1/(timeMs + 1)));
    if (plotItems.value("Voltage")) {
        for (CustomPlotItem* plot : *plotItems.value("Voltage")) 
        { 
            plot->addData(vdat1, 0);
            plot->addData(vdat2, 1);
            plot->addData(vdat3, 2);
        }
    }
    plotData.addData("Voltage", 0, vdat1);
    plotData.addData("Voltage", 1, vdat2);
    plotData.addData("Voltage", 2, vdat3);
    timeMs += 10;
}

void DataManager::init()
{
    QTimer *timer = new QTimer(this);
    timer->moveToThread(this->thread());
    connect(timer, &QTimer::timeout, this, &DataManager::dummyData);
    timer->start(50);
}

DataManager* DataManagerAccessor::_obj = nullptr; // Object accessed by QML, needs to be initialized since static


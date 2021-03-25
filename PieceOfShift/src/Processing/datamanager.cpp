#include "datamanager.h"
#include "velocityprocessingunit.h"
#include "accelerationprocessingunit.h"
#include "accelerationvelocityunit.h"
#include "customplotitem.h"
#include "datastructs.h"
#include <qdebug.h>
#include <qobject.h>
#include <qpoint.h>
#include <qrandom.h>
#include <qthread.h>

DataManager::DataManager()
{
    /* Create and append all processing units here,
     * maybe refactor to separate function
     */
    //    VelocityProcessingUnit* vpu = new VelocityProcessingUnit();
    //    processingUnits.append(vpu);
    //    AccelerationProcessingUnit* apu = new AccelerationProcessingUnit();
    //    processingUnits.append(apu);
    //    AccelerationVelocityUnit* avu = new AccelerationVelocityUnit();
    //    processingUnits.append(avu);

    // Connect newData signal to corresponding DataManager signal
    //    connect(vpu, &VelocityProcessingUnit::newData,
    //            this, &DataManager::newVelocity);
    //    connect(apu, &AccelerationProcessingUnit::newData,
    //            this, &DataManager::newAcceleration);
    //    connect(avu, &AccelerationVelocityUnit::newData,
    //            this, &DataManager::newAccelerationVelocity);

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
    //    for (auto processingUnit : processingUnits) {
    //        delete processingUnit;
    //    }
}

void DataManager::addData(unsigned int timeMs, const QString &name, const DataType &dataType, QByteArray data)
{
    QDataStream dataStream(&data, QIODevice::ReadWrite);

    if (dataType == DataType::INT32)
    {
        DataStructs::Int *dataStruct = new DataStructs::Int();
        dataStream >> *dataStruct;
        float data = dataStruct->value_0;
        addPlotData(name, timeMs, data);
    }
    else if (dataType == DataType::FLOAT)
    {
        // ...
        DataStructs::Float *dataStruct = new DataStructs::Float();
        emit newData(name, *dataStruct); // If not plot data, emit to QML
    }
}

void DataManager::addPlotData(const QString &name, unsigned int timeMs, float data)
{
    // !REMEMBER TO ADD FUNCTIONALITY FOR MULTIPLE GRAPHS (AND ALSO IF WE HAVE A GRAPH WITH CUSTOMIZABLE DATA)
    plotData.addData(name, 0, QPointF(timeMs, data));
    if (plotItems.contains(name))
    {
        for (CustomPlotItem *plot : *plotItems.value(name))
        {
            plot->addData(QPointF(timeMs, data), 0);
        }
    }
}

void DataManager::connectToPod(QString hostname, QString port)
{
    canServer.connectToPod(hostname, port);
}

void DataManager::sendPodCommand(CANServer::PodCommand messageType)
{
    canServer.sendPodCommand(messageType);
}

void DataManager::registerPlot(CustomPlotItem *plotItem, const QString &name)
{
    if (!plotItems.contains(name))
    {
        QList<CustomPlotItem *> *plotItemList = new QList<CustomPlotItem *>();
        plotItemList->append(plotItem);
        plotItems.insert(name, plotItemList);
        if (plotData.hasKey(name))
        {
            for (unsigned int i = 0; i < plotItem->getCustomPlot()->graphCount(); i++)
            {
                plotItem->getCustomPlot()->graph(i)->setData(plotData.getXValues(name, i), plotData.getYValues(name, i));
            }
        }
        else
        {
            plotData.insertEmpty(name);
        }
    }
    else
    {
        for (unsigned int i = 0; i < plotItem->getCustomPlot()->graphCount(); i++)
        {
            plotItem->getCustomPlot()->graph(i)->setData(plotData.getXValues(name, i), plotData.getYValues(name, i));
        }
        plotItems.value(name)->append(plotItem);
    }
}

void DataManager::removePlot(CustomPlotItem *plotItem)
{
    for (QString name : plotItems.keys())
    {
        if (plotItems.value(name)->contains(plotItem))
        {
            if (plotItems.value(name)->size() == 1)
            {
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
    if (timeMs > 1200)
    {
        return;
    }

    int vel;
    if (timeMs < 1000)
    {
        vel = generator.bounded(5) + exp(timeMs * 0.005);
    }
    else if (timeMs < 1100)
    {
        vel = generator.bounded(5) + exp(1 / timeMs * 0.1);
    }
    else
    {
        vel = 0;
    }
    QByteArray data;
    QDataStream stream(&data, QIODevice::ReadWrite);

    stream << vel;
    canServer.dataReceived(timeMs, 0x333, 4, data);
    timeMs += 10;
}

void DataManager::init()
{
    QTimer *timer = new QTimer(this);
    timer->moveToThread(this->thread());
    connect(timer, &QTimer::timeout, this, &DataManager::dummyData);
    timer->start(50);
}

DataManager *DataManagerAccessor::_obj = nullptr; // Object accessed by QML, needs to be initialized since static

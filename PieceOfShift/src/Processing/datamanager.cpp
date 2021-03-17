#include "datamanager.h"
#include "velocityprocessingunit.h"
#include "accelerationprocessingunit.h"
#include "accelerationvelocityunit.h"
#include "CustomPlotItem.h"

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
    } else {
        CustomPlotItem* basePlot = plotItems.value(name)->first();
        for (unsigned int i = 0; i < basePlot->getCustomPlot()->graphCount(); i++) 
        {
            plotItem->getCustomPlot()->graph(i)->setData(basePlot->getCustomPlot()->graph(i)->data());
            plotItems.value(name)->append(plotItem);
        }
    }
}

void DataManager::removePlot(CustomPlotItem *plotItem, const QString &name)
{
    if (plotItems.contains(name)) {
        if (plotItems.value(name)->indexOf(plotItem)) {
            plotItems.value(name)->removeOne(plotItem);
        }
    }
}

DataManager* DataManagerAccessor::_obj = nullptr; // Object accessed by QML, needs to be initialized since static


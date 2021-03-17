#include "datamanager.h"
#include "velocityprocessingunit.h"
#include "accelerationprocessingunit.h"
#include "accelerationvelocityunit.h"
#include <QDebug>
#include <iostream>

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

void DataManager::writeLogFile(QString path){
    QMap<QString, QString> dataCopyMap; 


    fileHandler.writeLogFile(path, dataCopyMap); 
}

void DataManager::readLogFile(QString path){
    fileHandler.readLogFile(path);
}



DataManager* DataManagerAccessor::_obj = nullptr; // Object accessed by QML, needs to be initialized since static


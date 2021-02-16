#include <QtConcurrent/QtConcurrent>
#include <algorithm>
#include "Decoding/cansplitter.h"
#include "Decoding/decoder.h"
#include "datamanager.h"
#include "velocityprocessingunit.h"
#include "accelerationprocessingunit.h"
#include "accelerationvelocityunit.h"

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


    connect(&canSplitter, &CanSplitter::dataReceived,
            &decoder, &Decoder::checkData);

    connect(&decoder, &Decoder::addData,
            this, &DataManager::addData);

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
    //QtConcurrent::run(processingUnit, &ProcessingUnit::addData, name, data);
    processingUnit->addData(name, data);
}

void DataManager::startServer()
{
    canSplitter.start();
}

void DataManager::sendPodCommand(const PodMessageType& messageType)
{
        podDataSender.canMessageConvertor(messageType);
}


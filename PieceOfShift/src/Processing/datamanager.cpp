#include "datamanager.h"
#include "velocityprocessingunit.h"
#include "accelerationprocessingunit.h"
#include "accelerationvelocityunit.h"
#include "datastructs.h"

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

void DataManager::addData(const QString& name, const DataType &dataType, const QVariant &data)
{


    if (dataType == ERROR) {
        QByteArray errorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&errorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* errorStatus = reinterpret_cast<DataStructs::VCUStatus*>(errorData.data());
        stream << errorStatus;
    }

    if (dataType == VCUSTATUS) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == VECTOR3F) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vectorStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vectorStatus;
    }

    if (dataType == PODSTATE) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == VECTOR3I) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == BOOL) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == VECTOR3B) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == CHAR) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == VECTOR2C) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == VECTOR3C) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == VECTOR16C) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == SHORT) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == VECTOR2S) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == INT) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == FLOAT) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }

    if (dataType == VECTOR2F) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }
    if (dataType == VECTOR4F) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }
    if (dataType == VECTOR6F) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }
    if (dataType == VECTOR8F) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
    }
    if (dataType == VECTOR16F) {
        QByteArray vectorData = data.value<QVariantList>().first().value<QPair<uchar, QByteArray>>().second;;
        QDataStream stream(&vectorData, QIODevice::ReadWrite);
        DataStructs::VCUStatus* vcuStatus = reinterpret_cast<DataStructs::VCUStatus*>(vectorData.data());
        stream << vcuStatus;
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

DataManager* DataManagerAccessor::_obj = nullptr; // Object accessed by QML, needs to be initialized since static


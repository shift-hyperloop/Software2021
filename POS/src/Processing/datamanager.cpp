#include "datamanager.h"
#include "customplotitem.h"
#include "datastructs.h"
#include <math.h>
#include <qdebug.h>
#include <qlist.h>
#include <qobject.h>
#include <qpoint.h>
#include <qrandom.h>
#include <qthread.h>
#include <qvariant.h>

DataManager::DataManager() : plotData(new PlotData())
{
    connect(&canServer, &CANServer::dataReceived, &decoder, &Decoder::checkData);

    connect(&decoder, &Decoder::addData, this, &DataManager::addData);

    connect(&canServer,
            &CANServer::connectionEstablished,
            this,
            &DataManager::podConnectionEstablished);

    connect(&canServer,
            &CANServer::connectionTerminated,
            this,
            &DataManager::podConnectionTerminated);
}

DataManager::~DataManager() {}

void DataManager::addData(unsigned int timeMs,
                          const QString &name,
                          const DataType &dataType,
                          QByteArray data)
{
    // Using QDataStream to deserialize data,
    // overloaded functions for >> operator for
    // each data struct can be found in datastructs.h
    QDataStream dataStream(&data, QIODevice::ReadWrite);
    dataStream.setVersion(QDataStream::Qt_5_12);
    dataStream.setByteOrder(QDataStream::LittleEndian);

    QVariantList qmlData; // Data to QML is sent as list of struct values

    // Choose what struct to create based on dataType
    switch (dataType) {
    case DataType::INT32: {
        DataStructs::Int dataStruct;
        dataStream >> dataStruct;
        qmlData.append(dataStruct.value_0);
        addPlotData(name, timeMs, QVariant::fromValue<int>(dataStruct.value_0));
        break;
    }
    case DataType::ERROR_CODE: {
        DataStructs::ErrorCode dataStruct;
        dataStream >> dataStruct;
        qmlData.append(dataStruct.error_code);
        break;
    }
    case DataType::VCU_STATUS: {
        DataStructs::VCUStatus dataStruct;
        dataStream >> dataStruct;
        qmlData.append(dataStruct.BMS_1);
        qmlData.append(dataStruct.BMS_2);
        qmlData.append(dataStruct.Inverter_1);
        qmlData.append(dataStruct.Inverter_2);
        qmlData.append(dataStruct.Telemetry);
        qmlData.append(dataStruct.State_indication);
        qmlData.append(dataStruct.Sensor_suite_1);
        qmlData.append(dataStruct.Sensor_suite_2);
        qmlData.append(dataStruct.latency_CAN_0);
        qmlData.append(dataStruct.latency_CAN_1);
        break;
    }
    case DataType::POD_STATE: {
        DataStructs::PodState dataStruct;
        dataStream >> dataStruct;
        qmlData.append(dataStruct.state);
        break;
    }
    case DataType::VECTOR_3I: {
        DataStructs::Vector3i dataStruct;
        dataStream >> dataStruct;

        DataStructs::Union3i u;
        u.vec = dataStruct;

        for (unsigned int i = 0; i < 3; i++) {
            QString newName = name;
            newName = newName.append("_").append(QString::number(i));
            addPlotData(newName, timeMs, u.arr[i]);
            qmlData.append(u.arr[i]);
        }
        break;
    }
    case DataType::BOOL: {
        DataStructs::Bool dataStruct;
        dataStream >> dataStruct;
        qmlData.append(dataStruct.status_0);
        break;
    }
    case DataType::VECTOR_2B: {
        DataStructs::Vector2b dataStruct;
        dataStream >> dataStruct;
        qmlData.append(dataStruct.status_0);
        qmlData.append(dataStruct.status_1);
        break;
    }
    case DataType::CHAR: {
        DataStructs::Char dataStruct;
        dataStream >> dataStruct;
        qmlData.append(dataStruct.value_0);
        addPlotData(name, timeMs, dataStruct.value_0);
        break;
    }
    case DataType::VECTOR_3C: {
        DataStructs::Vector3c dataStruct;
        dataStream >> dataStruct;

        DataStructs::Union3c u;
        u.vec = dataStruct;

        for (unsigned int i = 0; i < 3; i++) {
            QString newName = name;
            newName = newName.append("_").append(QString::number(i));
            addPlotData(newName, timeMs, u.arr[i]);
            qmlData.append(u.arr[i]);
        }
        break;
    }
    case DataType::SHORT: {
        DataStructs::Short dataStruct;
        dataStream >> dataStruct;
        qmlData.append(dataStruct.value_0);
        addPlotData(name, timeMs, dataStruct.value_0);
        break;
    }
    case DataType::VECTOR_30S: {
        DataStructs::Vector30s dataStruct;
        dataStream >> dataStruct;

        DataStructs::Union30s u;
        u.vec = dataStruct;

        for (unsigned int i = 0; i < 30; i++) {
            QString newName = name;
            newName = newName.append("_").append(QString::number(i));
            addPlotData(newName, timeMs, u.arr[i]);
            qmlData.append(u.arr[i]);
        }
        break;
    }
    case DataType::VECTOR_23S: {
        DataStructs::Vector23s dataStruct;
        dataStream >> dataStruct;

        DataStructs::Union23s u;
        u.vec = dataStruct;

        for (unsigned int i = 0; i < 23; i++) {
            QString newName = name;
            newName = newName.append("_").append(QString::number(i));
            addPlotData(newName, timeMs, u.arr[i]);
            qmlData.append(u.arr[i]);
        }
        break;
    }
    case DataType::FLOAT: {
        DataStructs::Float dataStruct;
        dataStream >> dataStruct;
        qmlData.append(dataStruct.value_0);
        addPlotData(name, timeMs, dataStruct.value_0);
        break;
    }
    case DataType::DOUBLE: {
        DataStructs::Double dataStruct;
        dataStream >> dataStruct;
        qmlData.append(dataStruct.value_0);
        addPlotData(name, timeMs, dataStruct.value_0);
        break;
    }
    case DataType::VECTOR_2F: {
        DataStructs::Vector2f dataStruct;
        dataStream >> dataStruct;

        DataStructs::Union2f u;
        u.vec = dataStruct;

        for (unsigned int i = 0; i < 2; i++) {
            QString newName = name;
            newName = newName.append("_").append(QString::number(i));
            addPlotData(newName, timeMs, u.arr[i]);
            qmlData.append(u.arr[i]);
        }
        break;
    }
    case DataType::VECTOR_3F: {
        DataStructs::Vector3f dataStruct;
        dataStream >> dataStruct;

        DataStructs::Union3f u;
        u.vec = dataStruct;

        for (unsigned int i = 0; i < 3; i++) {
            QString newName = name;
            newName = newName.append("_").append(QString::number(i));
            addPlotData(newName, timeMs, u.arr[i]);
            qmlData.append(u.arr[i]);
        }
        break;
    }
    case DataType::VECTOR_16F: {
        DataStructs::Vector16f dataStruct;
        dataStream >> dataStruct;

        DataStructs::Union16f u;
        u.vec = dataStruct;

        for (unsigned int i = 0; i < 16; i++) {
            QString newName = name;
            newName = newName.append("_").append(QString::number(i));
            addPlotData(newName, timeMs, u.arr[i]);
            qmlData.append(u.arr[i]);
        }
        break;
    }
    default: {
        break;
    }
    }
    emit newData(name, timeMs, qmlData); // Always emit data to be accessed from QML
}

void DataManager::addPlotData(const QString &name, unsigned int timeMs, QVariant data)
{
    plotData->addData(name, timeMs, data); // Store data no matter what
    if (plotItems.contains(name)) {
        // If plot exists which expects this data, add it to the plot
        for (QPair<CustomPlotItem *, int> plot : *plotItems.value(name)) {
            plot.first->addData(QPointF(timeMs, data.value<float>()), plot.second);
        }
    }
}

void DataManager::readLogFile(QString path)
{
    path = path.insert(0, "/");
    plotData = FileHandler::readLogFile(path);
}

void DataManager::writeLogFile(QString path)
{
    // serialzie dataMap
    QString filename = QString::number(QDateTime::currentSecsSinceEpoch()).append(".log");
    path = path.append("/").insert(0, "/");
    path = path.append(filename);
    FileHandler::writeLogFile(path, plotData.get());
}

void DataManager::connectToPod(QString hostname, QString port)
{
    canServer.connectToPod(hostname, port);
}

void DataManager::sendPodCommand(CANServer::PodCommand messageType)
{
    canServer.sendPodCommand(messageType);
}

void DataManager::registerGraph(CustomPlotItem *plotItem, const QString &name, int graphIndex)
{
    if (!plotItems.contains(name)) // Check if new plot
    {
        // Add plot along with graph index to plotItem map
        QPair<CustomPlotItem *, int> item(plotItem, graphIndex);
        QList<QPair<CustomPlotItem *, int>> *list = new QList<QPair<CustomPlotItem *, int>>();
        list->append(item);
        plotItems.insert(name, list);

        if (plotData->hasKey(name)) // If data exists in plotData for this name
        {
            // Copy data to new plot if data exists
            plotItem->getCustomPlot()
                ->graph(graphIndex)
                ->setData(plotData->getXValues(name), plotData->getYDoubleValues(name));
        } else {
            // Create empty plot data
            plotData->insertEmpty(name);
        }
    } else {
        // Copy data for each plot to new plot
        for (unsigned int i = 0; i < plotItem->getCustomPlot()->graphCount(); i++) {
            plotItem->getCustomPlot()
                ->graph(graphIndex)
                ->setData(plotData->getXValues(name), plotData->getYDoubleValues(name));
        }
        // Add new graph to plot item
        plotItems.value(name)->append(QPair<CustomPlotItem *, int>(plotItem, graphIndex));
    }
}

void DataManager::removePlot(CustomPlotItem *plotItem)
{
    // CustomPlotItem is cleaned up by QML, but need to remove it from plotItems
    for (QString name : plotItems.keys()) {
        for (QPair<CustomPlotItem *, int> pair : *plotItems.value(name)) {
            if (pair.first == plotItem) {
                plotItems.value(name)->removeOne(pair);
            }
            if (plotItems.value(name)->size() == 0) {
                plotItems.remove(name);
            }
        }
    }
}

long timeMs = 0;
QRandomGenerator generator(1000224242);
void DataManager::dummyData()
{
    if (timeMs > 2000) {
        return;
    }

    float vel;
    int acc;
    int vol1, vol2, vol3;
    vol1 = 240 * exp(-0.0051 * timeMs);
    vol2 = 235 * exp(-0.0042 * timeMs);
    vol3 = 284 * exp(-0.0052 * timeMs);

    int t1, t2, t3, t4, t5, t6, t7, t8;
    t1 = 440 * exp(-0.00051 * timeMs);
    t2 = 435 * exp(-0.00042 * timeMs);
    t3 = 484 * exp(-0.00052 * timeMs);
    t4 = 522 * exp(-0.00038 * timeMs);
    t5 = 431 * exp(-0.00082 * timeMs);
    t6 = 514 * exp(-0.00042 * timeMs);
    t7 = 446 * exp(-0.00031 * timeMs);
    t8 = 535 * exp(-0.00062 * timeMs);

    vel = timeMs * exp(-0.004 * timeMs);
    acc = 0.2 * timeMs * exp(-0.004 * timeMs);

    QByteArray data;
    QDataStream stream(&data, QIODevice::ReadWrite);
    stream.setByteOrder(QDataStream::LittleEndian);
    stream << vel;

    QByteArray data2;
    QDataStream stream2(&data2, QIODevice::ReadWrite);
    stream2.setByteOrder(QDataStream::LittleEndian);
    stream2 << acc;

    QByteArray data3, data4, data5;
    QDataStream stream3(&data3, QIODevice::ReadWrite);
    QDataStream stream4(&data4, QIODevice::ReadWrite);
    QDataStream stream5(&data5, QIODevice::ReadWrite);
    stream3.setByteOrder(QDataStream::LittleEndian);
    stream4.setByteOrder(QDataStream::LittleEndian);
    stream5.setByteOrder(QDataStream::LittleEndian);

    stream3 << vol1;
    stream4 << vol2;
    stream5 << vol3;

    canServer.dataReceived(timeMs, 0x09D, 4, data);
    canServer.dataReceived(timeMs, 0x334, 4, data2);

    canServer.dataReceived(timeMs, 0x335, 4, data3);
    canServer.dataReceived(timeMs, 0x336, 4, data4);
    canServer.dataReceived(timeMs, 0x337, 4, data5);

    DataStructs::Vector23s test;
    test.value_0 = t1;
    test.value_1 = t2;
    test.value_2 = t3;
    test.value_3 = t4;
    test.value_4 = t5;
    test.value_5 = t6;
    test.value_6 = t7;
    test.value_7 = t8;
    test.value_8 = t1;
    test.value_9 = t2;
    test.value_10 = t1;
    test.value_11 = t2;
    test.value_12 = t3;
    test.value_13 = t4;
    test.value_14 = t5;
    test.value_15 = t6;
    test.value_16 = t7;
    test.value_17 = t8;
    test.value_18 = t1;
    test.value_19 = t2;
    test.value_20 = t3;
    test.value_21 = t4;
    test.value_22 = t5;

    QByteArray data6;
    QDataStream stream6(&data6, QIODevice::ReadWrite);
    stream6.setByteOrder(QDataStream::LittleEndian);
    stream6 << test;

    canServer.dataReceived(timeMs, 0x43B, 23 * sizeof(uint16_t), data6);
    canServer.dataReceived(timeMs, 0x53C, 23 * sizeof(uint16_t), data6);
    canServer.dataReceived(timeMs, 0x528, 23 * sizeof(uint16_t), data6);
    canServer.dataReceived(timeMs, 0x629, 23 * sizeof(uint16_t), data6);

    DataStructs::Vector30s voltages;
    voltages.value_0 = t1;
    voltages.value_1 = t2;
    voltages.value_2 = t3;
    voltages.value_3 = t4;
    voltages.value_4 = t5;
    voltages.value_5 = t6;
    voltages.value_6 = t7;
    voltages.value_7 = t8;
    voltages.value_8 = t1;
    voltages.value_9 = t2;
    voltages.value_10 = t1;
    voltages.value_11 = t2;
    voltages.value_12 = t3;
    voltages.value_13 = t4;
    voltages.value_14 = t5;
    voltages.value_15 = t6;
    voltages.value_16 = t7;
    voltages.value_17 = t8;
    voltages.value_18 = t1;
    voltages.value_19 = t2;
    voltages.value_20 = t3;
    voltages.value_21 = t4;
    voltages.value_22 = t5;
    voltages.value_23 = t7;
    voltages.value_24 = t8;
    voltages.value_25 = t1;
    voltages.value_26 = t2;
    voltages.value_27 = t3;
    voltages.value_28 = t4;
    voltages.value_29 = t5;

    QByteArray data7;
    QDataStream stream7(&data7, QIODevice::ReadWrite);
    stream7.setByteOrder(QDataStream::LittleEndian);
    stream7 << voltages;

    canServer.dataReceived(timeMs, 0x124, 23 * sizeof(uint16_t), data7);
    canServer.dataReceived(timeMs, 0x225, 23 * sizeof(uint16_t), data7);
    canServer.dataReceived(timeMs, 0x326, 23 * sizeof(uint16_t), data7);
    canServer.dataReceived(timeMs, 0x138, 23 * sizeof(uint16_t), data7);

    QByteArray data8;
    QDataStream stream8(&data8, QIODevice::ReadWrite);
    stream8.setByteOrder(QDataStream::LittleEndian);

    float p1, p2, p3;
    p1 = 500 * sin(0.01 * timeMs);
    p2 = 500 * sin(0.01 * timeMs + 209);
    p3 = 500 * sin(0.01 * timeMs + 418);

    DataStructs::Vector3f currents;
    currents.acceleration = p1;
    currents.position = p2;
    currents.speed = p3;

    stream8 << currents;

    // Phase Currents
    canServer.dataReceived(timeMs, 0x275, sizeof(float) * 3, data8);

    // DC-Link and Junction Temp
    canServer.dataReceived(timeMs, 0x676, 4, data);
    canServer.dataReceived(timeMs, 0x677, 4, data);

    timeMs += 10;
}

void DataManager::init()
{
    QTimer *timer = new QTimer(this);
    timer->moveToThread(this->thread());
    connect(timer, &QTimer::timeout, this, &DataManager::dummyData);
    timer->start(50);
}

DataManager *DataManagerAccessor::_obj
    = nullptr; // Object accessed by QML, needs to be initialized since static

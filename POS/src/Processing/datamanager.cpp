#include "datamanager.h"
#include "customplotitem.h"
#include "datastructs.h"
#include <bits/stdint-intn.h>
#include <bits/stdint-uintn.h>
#include <math.h>
#include <qdebug.h>
#include <qlist.h>
#include <qobject.h>
#include <qpoint.h>
#include <qrandom.h>
#include <qthread.h>
#include <qvariant.h>

DataManager::DataManager()
{
    connect(&canServer, &CANServer::dataReceived,
            &decoder, &Decoder::checkData);

    connect(&decoder, &Decoder::addData,
            this, &DataManager::addData);

    connect(&canServer, &CANServer::connectionEstablished,
            this, &DataManager::podConnectionEstablished);

    connect(&canServer, &CANServer::connectionTerminated,
            this, &DataManager::podConnectionTerminated);
}

DataManager::~DataManager()
{
}

void DataManager::addData(unsigned int timeMs, const QString &name, const DataType &dataType, QByteArray data)
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
        case DataType::INT32: 
        {
            DataStructs::Int dataStruct;
            dataStream >> dataStruct;
            qmlData.append(dataStruct.value_0);
            addPlotData(name, timeMs, dataStruct.value_0); 
            break;
        }  
        case DataType::ERROR_CODE: 
        {
            DataStructs::ErrorCode dataStruct;
            dataStream >> dataStruct;
            qmlData.append(dataStruct.error_code);
            break;
        }
        case DataType::VCU_STATUS:
        {
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
        case DataType::POD_STATE:
        {
            DataStructs::PodState dataStruct;
            dataStream >> dataStruct;
            qmlData.append(dataStruct.state);
            break;
        }
        case DataType::VECTOR_3I:
        {
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
        case DataType::BOOL:
        {
            DataStructs::Bool dataStruct;
            dataStream >> dataStruct;
            qmlData.append(dataStruct.status_0);
            break;
        }
        case DataType::VECTOR_2B:
        {
            DataStructs::Vector2b dataStruct;
            dataStream >> dataStruct;
            qmlData.append(dataStruct.status_0);
            qmlData.append(dataStruct.status_1);
            break;
        }
        case DataType::CHAR:
        {
            DataStructs::Char dataStruct;
            dataStream >> dataStruct;
            qmlData.append(dataStruct.value_0);
            addPlotData(name, timeMs, dataStruct.value_0); 
            break;
        }
        case DataType::VECTOR_3C:
        {
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
        case DataType::SHORT:
        {
            DataStructs::Short dataStruct;
            dataStream >> dataStruct;
            qmlData.append(dataStruct.value_0);
            addPlotData(name, timeMs, dataStruct.value_0); 
            break;
        }
        case DataType::VECTOR_30S:
        {
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
        case DataType::FLOAT:
        {
            DataStructs::Float dataStruct;
            dataStream >> dataStruct;
            qmlData.append(dataStruct.value_0);
            addPlotData(name, timeMs, dataStruct.value_0); 
            break;
        }
        case DataType::DOUBLE:
        {
            DataStructs::Double dataStruct;
            dataStream >> dataStruct;
            qmlData.append(dataStruct.value_0);
            addPlotData(name, timeMs, dataStruct.value_0); 
            break;
        }
        case DataType::VECTOR_2F:
        {
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
        case DataType::VECTOR_3F:
        {
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
        case DataType::VECTOR_16F:
        {
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
        default:
        {
            break;
        }
    }
    emit newData(name, timeMs, qmlData); // Always emit data to be accessed from QML
}

void DataManager::addPlotData(const QString &name, unsigned int timeMs, float data)
{
    plotData.addData(name, QPointF(timeMs, data)); // Store data no matter what
    if (plotItems.contains(name))
    {
        // If plot exists which expects this data, add it to the plot
        for (QPair<CustomPlotItem*, int> plot : *plotItems.value(name))
        {
            plot.first->addData(QPointF(timeMs, data), plot.second);
        }
    }
}

void DataManager::readLogFile(QString path) {
    //fileHandler.readLogFile(path); 
}


void DataManager::writeLogFile(QString path) {
    // serialzie dataMap
    fileHandler.writeLogFile(path); 

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
        QPair<CustomPlotItem*, int> item(plotItem, graphIndex);
        QList<QPair<CustomPlotItem*, int>>* list = new QList<QPair<CustomPlotItem*, int>>();
        list->append(item);
        plotItems.insert(name, list);

        if (plotData.hasKey(name)) // If data exists in plotData for this name
        {
            // Copy data to new plot if data exists
            plotItem->getCustomPlot()->graph(graphIndex)->setData(plotData.getXValues(name), plotData.getYValues(name));
        }
        else
        {
            // Create empty plot data
            plotData.insertEmpty(name);
        }
    }
    else
    {
        // Copy data for each plot to new plot
        for (unsigned int i = 0; i < plotItem->getCustomPlot()->graphCount(); i++)
        {
            plotItem->getCustomPlot()->graph(graphIndex)->setData(plotData.getXValues(name), plotData.getYValues(name));
        }
        // Add new graph to plot item
        plotItems.value(name)->append(QPair<CustomPlotItem*, int>(plotItem, graphIndex));
    }
}

void DataManager::removePlot(CustomPlotItem *plotItem)
{
    // CustomPlotItem is cleaned up by QML, but need to remove it from plotItems
    for (QString name : plotItems.keys())
    {
        for (QPair<CustomPlotItem*, int> pair : *plotItems.value(name)) {
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
    if (timeMs > 1500)
    {
        return;
    }

    int vel;
    int acc;
    int vol1, vol2, vol3;
    vol1 = 240*exp(-0.0051*timeMs);
    vol2 = 235*exp(-0.0042*timeMs);
    vol3 = 284*exp(-0.0052*timeMs);

    vel = timeMs * exp(-0.004*timeMs);
    acc = 0.2 * timeMs * exp(-0.004*timeMs);

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

    canServer.dataReceived(timeMs, 0x333, 4, data);
    canServer.dataReceived(timeMs, 0x334, 4, data2);

    canServer.dataReceived(timeMs, 0x335, 4, data3);
    canServer.dataReceived(timeMs, 0x336, 4, data4);
    canServer.dataReceived(timeMs, 0x337, 4, data5);

    DataStructs::Vector30s test;
    test.value_0 = vol1;
    test.value_1 = vol2;
    test.value_2 = vol3;
    test.value_3 = vol1;
    test.value_4 = vol1;
    test.value_5 = vol1;
    test.value_6 = vol2;
    test.value_7 = vol3;
    test.value_8 = vol1;
    test.value_9 = vol1;
    test.value_10 = vol1;
    test.value_11 = vol2;
    test.value_12 = vol3;
    test.value_13 = vol1;
    test.value_14 = vol1;
    test.value_15 = vol1;
    test.value_16 = vol1;
    test.value_17 = vol2;
    test.value_18 = vol3;
    test.value_19 = vol1;
    test.value_20 = vol1;
    test.value_21 = vol1;
    test.value_22 = vol2;
    test.value_23 = vol3;
    test.value_24 = vol1;
    test.value_25 = vol1;
    test.value_26 = vol1;
    test.value_27 = vol2;
    test.value_28 = vol3;
    test.value_29 = vol1;

    QByteArray data6;
    QDataStream stream6(&data6, QIODevice::ReadWrite);
    stream6.setByteOrder(QDataStream::LittleEndian);
    stream6 << test;

    canServer.dataReceived(timeMs, 0x338, 30*sizeof(uint16_t), data6);

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

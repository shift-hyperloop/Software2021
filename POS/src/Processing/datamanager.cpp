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

    bool bNewName = false; // Some structs emit data with several names

    QVariantList qmlData;

    // Choose what struct to create based on dataType
    switch (dataType) {
        case DataType::INT32: 
        {
            DataStructs::Int dataStruct;
            dataStream >> dataStruct;
            float data = dataStruct.value_0;
            addPlotData(name, timeMs, data); // Plot data is two floats for CustomPlotItem
            qmlData.append(data);
            emit newData(name, timeMs, qmlData); // Always emit data to be accessed from QML
            break;
        }  
        case DataType::ERROR_CODE: 
        {
            DataStructs::ErrorCode dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::VCU_STATUS:
        {
            DataStructs::VCUStatus dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::VECTOR_3F:
        {
            DataStructs::Vector3f dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::POD_STATE:
        {
            DataStructs::PodState dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::VECTOR_3I:
        {
            DataStructs::Vector3i dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::BOOL:
        {
            DataStructs::Bool dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::VECTOR_3B:
        {
            DataStructs::Vector3b dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::CHAR:
        {
            DataStructs::Char dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::VECTOR_2C:
        {
            DataStructs::Vector2c dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::VECTOR_3C:
        {
            DataStructs::Vector3c dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::VECTOR_16C:
        {
            DataStructs::Vector16c dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::SHORT:
        {
            DataStructs::Short dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::VECTOR_2S:
        {
            DataStructs::Vector2s dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::FLOAT:
        {
            DataStructs::Float dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::DOUBLE:
        {
            DataStructs::Double dataStruct; 
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::VECTOR_2F:
        {
            DataStructs::Vector2f dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::VECTOR_4F:
        {
            DataStructs::Vector4f dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::VECTOR_6F:
        {
            DataStructs::Vector6f dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
            break;
        }
        case DataType::VECTOR_8F:
        {
            DataStructs::Vector8f dataStruct;
            dataStream >> dataStruct;
            emit newData(name, timeMs, qmlData);
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
                if (!plotData.hasKey(newName)) emit newDataName(newName);
            }
            emit newData(name, timeMs, qmlData);
            bNewName = true;
            break;
        }
    }
    if (!plotData.hasKey(name) && !bNewName) emit newDataName(name);
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
    if (!plotData.hasKey(name)) emit newDataName(name);

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

    DataStructs::Vector16f test;
    test.value_0 = vol1;
    test.value_1 = vol2;
    test.value_2 = vol3;
    test.value_3 = vol1;
    test.value_4 = vol1;
    test.value_15 = vol1;

    QByteArray data6;
    QDataStream stream6(&data6, QIODevice::ReadWrite);
    stream6.setByteOrder(QDataStream::LittleEndian);
    stream6 << test;

    canServer.dataReceived(timeMs, 0x338, 16*sizeof(float), data6);

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

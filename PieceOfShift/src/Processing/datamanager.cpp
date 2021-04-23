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
    /* Create and append all processing units here,
     * maybe refactor to separate function
     */

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
    if (!plotData.hasKey(name)) emit newDataName(name);
    QDataStream dataStream(&data, QIODevice::ReadWrite);
    dataStream.setByteOrder(QDataStream::LittleEndian);

    if (dataType == DataType::INT32)
    {
        DataStructs::Int *dataStruct = new DataStructs::Int();
        dataStream >> *dataStruct;
        float data = dataStruct->value_0;
        addPlotData(name, timeMs, data);
    }
    else if (dataType == DataType::ERROR_CODE)
    {
        DataStructs::ErrorCode *dataStruct = new DataStructs::ErrorCode();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VCU_STATUS)
    {
        DataStructs::VCUStatus *dataStruct = new DataStructs::VCUStatus();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VECTOR_3F)
    {
        DataStructs::Vector3f *dataStruct = new DataStructs::Vector3f();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::POD_STATE)
    {
        DataStructs::PodState *dataStruct = new DataStructs::PodState();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VECTOR_3I)
    {
        DataStructs::Vector3i *dataStruct = new DataStructs::Vector3i();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::BOOL)
    {
        DataStructs::Bool *dataStruct = new DataStructs::Bool();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VECTOR_3B)
    {
        DataStructs::Vector3b *dataStruct = new DataStructs::Vector3b();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::CHAR)
    {
        DataStructs::Char *dataStruct = new DataStructs::Char();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VECTOR_2C)
    {
        DataStructs::Vector2c *dataStruct = new DataStructs::Vector2c();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VECTOR_3C)
    {
        DataStructs::Vector3c *dataStruct = new DataStructs::Vector3c();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VECTOR_16C)
    {
        DataStructs::Vector16c *dataStruct = new DataStructs::Vector16c();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::SHORT)
    {
        DataStructs::Short *dataStruct = new DataStructs::Short();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VECTOR_2S)
    {
        DataStructs::Vector2s *dataStruct = new DataStructs::Vector2s();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::FLOAT)
    {
        DataStructs::Float *dataStruct = new DataStructs::Float();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::DOUBLE)
    {
        DataStructs::Double *dataStruct = new DataStructs::Double();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VECTOR_2F)
    {
        DataStructs::Vector2f *dataStruct = new DataStructs::Vector2f();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VECTOR_4F)
    {
        DataStructs::Vector2f *dataStruct = new DataStructs::Vector2f();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VECTOR_6F)
    {
        DataStructs::Vector2f *dataStruct = new DataStructs::Vector2f();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VECTOR_8F)
    {
        DataStructs::Vector2f *dataStruct = new DataStructs::Vector2f();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
    else if (dataType == DataType::VECTOR_16F)
    {
        DataStructs::Vector2f *dataStruct = new DataStructs::Vector2f();
        dataStream >> *dataStruct;
        emit newData(name, *dataStruct);
    }
}

void DataManager::addPlotData(const QString &name, unsigned int timeMs, float data)
{
    plotData.addData(name, QPointF(timeMs, data));
    if (plotItems.contains(name))
    {
        for (QPair<CustomPlotItem*, int> plot : *plotItems.value(name))
        {
            plot.first->addData(QPointF(timeMs, data), plot.second);
        }
    }
}

void DataManager::readLogFile(QString path) {
    fileHandler.readLogFile(path); 
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

    if (!plotItems.contains(name))
    {
        QPair<CustomPlotItem*, int> item(plotItem, graphIndex);
        QList<QPair<CustomPlotItem*, int>>* list = new QList<QPair<CustomPlotItem*, int>>();
        list->append(item);
        plotItems.insert(name, list);

        if (plotData.hasKey(name))
        {
            plotItem->getCustomPlot()->graph(graphIndex)->setData(plotData.getXValues(name), plotData.getYValues(name));
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
            plotItem->getCustomPlot()->graph(graphIndex)->setData(plotData.getXValues(name), plotData.getYValues(name));
        }
        plotItems.value(name)->append(QPair<CustomPlotItem*, int>(plotItem, graphIndex));
    }
}

void DataManager::removePlot(CustomPlotItem *plotItem)
{
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
    stream << vel;

    QByteArray data2;
    QDataStream stream2(&data2, QIODevice::ReadWrite);
    stream2 << acc;

    QByteArray data3, data4, data5;
    QDataStream stream3(&data3, QIODevice::ReadWrite);
    QDataStream stream4(&data4, QIODevice::ReadWrite);
    QDataStream stream5(&data5, QIODevice::ReadWrite);

    stream3 << vol1;
    stream4 << vol2;
    stream5 << vol3;

    canServer.dataReceived(timeMs, 0x333, 4, data);
    canServer.dataReceived(timeMs, 0x334, 4, data2);

    canServer.dataReceived(timeMs, 0x335, 4, data3);
    canServer.dataReceived(timeMs, 0x336, 4, data4);
    canServer.dataReceived(timeMs, 0x337, 4, data5);

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

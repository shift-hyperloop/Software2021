#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QVector>
#include <QtConcurrent/QtConcurrent>
#include "Processing/datastructs.h"
#include "src/Decoding/canserver.h"
#include "src/Decoding/decoder.h"
#include "src/Decoding/filehandler.h"
#include "Processing/plotdata.h"

class CustomPlotItem;


class CustomPlotItem;

class DataManager : public QObject
{
    Q_OBJECT

public:
    DataManager();
    ~DataManager();

public slots:

    void dummyData();

    void init();

    // Have Decoder send signal to add data
    void addData(unsigned int timeMs, const QString &name, const DataType &dataType, QByteArray data);

    // Start recieving messages
    void connectToPod(QString hostname, QString port);

    // This should use a Decoder slot to send command to pod
    void sendPodCommand(CANServer::PodCommand command);

    void registerGraph(CustomPlotItem *plotItem, const QString &name, int graphIndex);
    void removePlot(CustomPlotItem *plotItem);

    // Write current data to log file

    inline QList<QString> getAllDataNames() { return plotData.names(); }
    void writeLogFile(QString path); // TODO: Implement

    // Read log file and send through pipeline
    void readLogFile(QString path);// TODO: Implement


signals:
    // TODO: Add signals for each CAN message
    // TODO: Add signals for each data type
    void newVelocity(const QString &name, const QVariant &velocity);
    void newAcceleration(const QVariant &a);
    void newAccelerationVelocity(const QVariant &av);

    void podConnectionEstablished();
    void podConnectionTerminated();

    void newData(const QString &name, const DataStructs::DataStruct &value);
    void newDataName(const QString& name);

private:
    void addPlotData(const QString &name, unsigned int timeMs, float data);

    QMap<QString, QList<QPair<CustomPlotItem*, int>>*> plotItems;

    PlotData plotData;

    Decoder decoder;
    CANServer canServer;
    FileHandler fileHandler;
};

class DataManagerAccessor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(DataManager *dataManager READ dataManager)

private:
    static DataManager *_obj; // Initialized in .cpp

public:
    DataManagerAccessor(QObject *parent = 0) : QObject(parent) {}
    DataManager *dataManager() { return _obj; }
    static void setDataManager(DataManager *manager) { _obj = manager; }
};

#endif // DATAMANAGER_H

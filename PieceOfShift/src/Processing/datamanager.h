#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QVector>
#include <QtConcurrent/QtConcurrent>
#include "processingunit.h"
#include "src/Decoding/canserver.h"
#include "src/Decoding/decoder.h"

class CustomPlotItem;

class DataManager : public QObject
{
    Q_OBJECT
public:
    DataManager();
    ~DataManager();

public slots:

    // Have Decoder send signal to add data
    void addData(const QString& name, const DataType &dataType, const QVariant &data);

    // Start recieving messages
    void connectToPod(QString hostname, QString port);

    // This should use a Decoder slot to send command to pod
    void sendPodCommand(CANServer::PodCommand command);

    void registerPlot(CustomPlotItem* plotItem, const QString& name);
    void removePlot(CustomPlotItem* plotItem, const QString& name);

    // Write current data to log file
    void writeLogFile(QString path) { } // TODO: Implement

    // Read log file and send through pipeline
    void readLogFile(QString path) { } // TODO: Implement

signals:
    // TODO: Add signals for each CAN message
    // TODO: Add signals for each data type
    void newVelocity(const QString &name, const QVariant &velocity);
    void newAcceleration(const QVariant &a);
    void newAccelerationVelocity(const QVariant &av);

    void podConnectionEstablished();
    void podConnectionTerminated();

private:
    QVector<ProcessingUnit*> processingUnits;
    QMap<QString, QList<CustomPlotItem*>*> plotItems;

    Decoder decoder;
    CANServer canServer;
};

class DataManagerAccessor : public QObject {
    Q_OBJECT
    Q_PROPERTY(DataManager* dataManager READ dataManager)

private:
    static DataManager * _obj; // Initialized in .cpp

public:
    DataManagerAccessor(QObject * parent = 0) : QObject(parent) {}
    DataManager * dataManager() { return _obj; }
    static void setDataManager(DataManager* manager) { _obj = manager; }

    
};

#endif // DATAMANAGER_H

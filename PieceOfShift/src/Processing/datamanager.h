#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QVector>
#include <QtConcurrent/QtConcurrent>
#include <qobject.h>
#include <qobjectdefs.h>
#include "processingunit.h"
#include "Decoding/canserver.h"
#include "Decoding/decoder.h"

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
    void startServer();

    // This should use a Decoder slot to send command to pod
    void sendPodCommand(const PodCommand& command);

    // Write current data to log file
    //void writeLogFile(const QString& path);

    // Read log file and send through pipeline
    //void readLogFile(const QString& path);

signals:
    // TODO: Add signals for each CAN message
    // TODO: Add signals for each data type
    void newVelocity(const QString &name, const QVariant &velocity);
    void newAcceleration(const QVariant &a);
    void newAccelerationVelocity(const QVariant &av);

private:
    QVector<ProcessingUnit*> processingUnits;

    Decoder decoder;
    CANServer canServer;
};

class DataManagerAccessor : public QObject {
    Q_OBJECT
    Q_PROPERTY(DataManager* dataManager READ dataManager)

private:
    static DataManager * _obj; // remember to init in the cpp file

public:
    DataManagerAccessor(QObject * parent = 0) : QObject(parent) {}
    DataManager * dataManager() { return _obj; }
    static void setDataManager(DataManager* manager) { _obj = manager; }

    
};

#endif // DATAMANAGER_H

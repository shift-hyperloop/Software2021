#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QVector>
#include <QtConcurrent/QtConcurrent>
#include "processingunit.h"
#include "src/Decoding/filehandler.h"

class DataManager : public QObject
{
    Q_OBJECT
public:
    DataManager();
    ~DataManager();
public slots:

    // MHave Decoder send signal to add data
    void addData(const QString& name, const DataType &dataType, const QVariant &data);

    // REMOVE THIS
    void dummyData();

    void writeLogFile(QString filePath);
    void readLogFile(QString filePath);

    // This should use a Decoder slot to send command to pod
    // void sendPodCommand(PodCommand command);

signals:
    // TODO: Add signals for each CAN message
    // TODO: Add signals for each data type
    void newVelocity(const QString &name, const QVariant &velocity);
    void newAcceleration(const QVariant &a);
    void newAccelerationVelocity(const QVariant &av);

private:
    QVector<ProcessingUnit*> processingUnits;
    FileHandler fileHandler;

};

#endif // DATAMANAGER_H

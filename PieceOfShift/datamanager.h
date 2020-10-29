#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QVector>
#include <QtConcurrent/QtConcurrent>

#include "processingunit.h"

class DataManager : public QObject
{
    Q_OBJECT
public:
    DataManager();
    ~DataManager();

    // Move this to slots and have Decoder send signal to add data
    void addData(const DataType &dataType, const QVariant &data);

public slots:
    // This should use a Decoder slot to send command to pod
    // void sendPodCommand(PodCommand command);

signals:
    // TODO: Add signals for each CAN message
    void newVelocity(const QVariant &v);

private:
    QVector<ProcessingUnit*> processingUnits;
};

#endif // DATAMANAGER_H

#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QThread>
#include <QVector>
#include <QMutex>
#include <QWaitCondition>

#include "processingunit.h"

class DataManager : public QThread
{
    Q_OBJECT
    Q_PROPERTY(VelocityStruct velocity READ velocity NOTIFY newVelocity)
public:
    DataManager();
    ~DataManager();

    virtual void run() override;

    VelocityStruct velocity() {
        return {10};
    }

signals:
    void newVelocity();

private:
    QVector<ProcessingUnit*> processingUnits;

    VelocityStruct m_velocity;

    QMutex mutex;
    QWaitCondition condition;

    bool restart = false;
};

#endif // DATAMANAGER_H

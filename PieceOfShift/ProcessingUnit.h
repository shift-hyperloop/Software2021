#ifndef PROCESSINGUNIT_H
#define PROCESSINGUNIT_H

#include <QThread>
#include <QVariant>
#include <QQueue>
#include <QMutex>
#include <QWaitCondition>
#include <qqml.h>

class ProcessingUnit : public QThread
{

public:
    //virtual void run();

    void process();

public slots:
    //void addData(QVariant &data);

signals:
    /*
     *   Use this to be able to use QVariant with custom struct 
     */
    //virtual void newData(const QVariant &data);

protected:
    QQueue<QVariant> dataQueue;
    QMutex mutex;
    QThread::Priority priority;
    QWaitCondition waitCondition;

    bool restart = false;
    bool abort = false;
};

#endif // PROCESSINGUNIT_H

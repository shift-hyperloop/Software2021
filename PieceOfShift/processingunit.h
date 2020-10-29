#ifndef PROCESSINGUNIT_H
#define PROCESSINGUNIT_H

#include <QVariant>
#include <QQueue>
#include <qqml.h>


typedef struct velocityStruct {
    double velocity;
} VelocityStruct;

// TODO: Move to other file
Q_DECLARE_METATYPE(VelocityStruct);

enum DataType {
    VELOCITY,
    ACCELERATION
};

class ProcessingUnit : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariant data READ data WRITE addData NOTIFY newData)
public:

    virtual void process() = 0;
    QVariant data() {
        if (!dataQueue.empty())
            return dataQueue.back();
        else
            return QVariant::fromValue(10);
    }

    DataType dataType() { return m_dataType; }

public slots:
    void addData(const QVariant &data)
    {
        dataQueue.enqueue(data);
        process();
    }

signals:
    /*
     *   Use this to be able to use QVariant with custom struct 
     */
    void newData(const QVariant &data);

protected:
    QQueue<QVariant> dataQueue;

    DataType m_dataType;
};

#endif // PROCESSINGUNIT_H

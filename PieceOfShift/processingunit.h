#ifndef PROCESSINGUNIT_H
#define PROCESSINGUNIT_H

#include <QVariant>
#include <QQueue>


// The data structs should be in Decoder, but here for demonstration purposes
typedef struct velocityStruct {
    double velocity;
} VelocityStruct;

// Might move to Decoder?
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

    // This shouldn't really be called, use data from signal instead
    QVariant data() {
        if (!dataQueue.empty())
            return dataQueue.back();
        else
            return 0;
    }

    DataType dataType() { return m_dataType; }

public slots:
    // Add data to queue and start processing
    void addData(const QVariant &data)
    {
        dataQueue.enqueue(data);
        process();
    }

signals:
    // This signal is emitted when new data is available
    void newData(const QVariant &data);

protected:
    QQueue<QVariant> dataQueue;

    DataType m_dataType;
};

#endif // PROCESSINGUNIT_H

#ifndef PROCESSINGUNIT_H
#define PROCESSINGUNIT_H

#include <QVariant>
#include <QQueue>
#include <QMap>
#include <QThread>

// The data structs should be in Decoder, but here for demonstration purposes
struct VelocityStruct {
    int timeMs;
    double velocity;
};

Q_DECLARE_METATYPE(VelocityStruct)

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

    ProcessingUnit();
    ~ProcessingUnit();

    virtual void process(const QString& name) = 0;

    // This shouldn't really be called, use data from signal instead
    QVariant data() {
        return 0;
    }

    DataType dataType() { return m_dataType; }

public slots:
    // Add data to queue and start processing
    void addData(const QPair<QString, QVariant> &data);

signals:
    // This signal is emitted when new data is available
    void newData(const QVariant &data);

protected:
    QMap<QString, QQueue<QVariant>*> dataMap;

    DataType m_dataType;
};

#endif // PROCESSINGUNIT_H

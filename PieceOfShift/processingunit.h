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
    //Q_PROPERTY(QPair<QString, QVariant> data READ data WRITE addData NOTIFY newData)

public:

    ~ProcessingUnit();

    virtual void process(const QString& name) = 0;

    // This shouldn't really be called, use data from signal instead
    /*QPair<QString, QVariant> data() {
        return QPair<QString, QVariant>(0, 0);
    }*/

    DataType dataType() { return m_dataType; }

public slots:
    // Add data to queue and start processing
    void addData(const QString &name, const QVariant &data);

signals:
    // This signal is emitted when new data is available
    void newData(const QString &name, const QVariant &data);

protected:
    QMap<QString, QQueue<QVariant>*> dataMap;

    DataType m_dataType;
};

#endif // PROCESSINGUNIT_H

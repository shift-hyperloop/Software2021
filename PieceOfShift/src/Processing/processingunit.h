#ifndef PROCESSINGUNIT_H
#define PROCESSINGUNIT_H

#include <QVariant>
#include <QQueue>
#include <QMap>
#include <QThread>
#include <qvector.h>

struct VelocityStruct
{
    double velocity;
    int timeMs;
};

struct AccelerationStruct
{
    double acceleration;
    int timeMs;
};

struct AccelerationVelocityStruct
{
    double acceleration;
    double velocity;
    int timeMs;
};

Q_DECLARE_METATYPE(VelocityStruct);
Q_DECLARE_METATYPE(AccelerationStruct);
Q_DECLARE_METATYPE(AccelerationVelocityStruct);

enum class DataType
{
    ERROR_CODE,
    VCU_STATUS,
    POD_STATE,
    BOOL,
    UINT8,
    INT8,
    UINT16,
    INT16,
    UINT32,
    INT32,
    FLOAT,
    DOUBLE,
    VECTOR_3I,
    VECTOR_3F,
    VECTOR_3B,
    CHAR,
    VECTOR_2C,
    VECTOR_3C,
    VECTOR_16C,
    SHORT,
    VECTOR_2S,
    VECTOR_2F,
    VECTOR_4F,
    VECTOR_6F,
    VECTOR_8F,
    VECTOR_16F


};

class ProcessingUnit : public QObject
{
    Q_OBJECT

public:
    ~ProcessingUnit();

    virtual void process(const QString &name) = 0;

    DataType dataType() { return m_dataType; }

public slots:
    // Add data to queue and start processing
    void addData(const QString &name, const QVariant &data);

signals:
    void newData(const QString &name, const QVariant &data);

protected:
    QMap<QString, QQueue<QVariant> *> dataMap;
    DataType m_dataType;
};

#endif //PROCESSINGUNIT_H

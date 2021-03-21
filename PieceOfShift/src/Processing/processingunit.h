#ifndef PROCESSINGUNIT_H
#define PROCESSINGUNIT_H

#include <QVariant>
#include <QQueue>
#include <QMap>
#include <QThread>

struct VelocityStruct {
    double velocity;
    int timeMs;
};

struct AccelerationStruct {
    double acceleration;
    int timeMs;
};

struct AccelerationVelocityStruct {
    double acceleration;
    double velocity;
    int timeMs;
};

Q_DECLARE_METATYPE(VelocityStruct);
Q_DECLARE_METATYPE(AccelerationStruct);
Q_DECLARE_METATYPE(AccelerationVelocityStruct);


enum DataType {
    VELOCITY,
    ACCELERATION,
    ACCELERATIONVELOCITY,
    ERROR,
    VCUSTATUS,
    VECTOR3F,
    PODSTATE,
    VECTOR3I,
    BOOL,
    VECTOR3B,
    CHAR,
    VECTOR2C,
    VECTOR3C,
    VECTOR16C,
    SHORT,
    VECTOR2S,
    INT,
    FLOAT,
    VECTOR2F,
    VECTOR4F,
    VECTOR6F,
    VECTOR8F,
    VECTOR16F
};

class ProcessingUnit : public QObject {
    Q_OBJECT

public:
    ~ProcessingUnit();

    virtual void process(const QString& name) = 0;

    DataType dataType() { return m_dataType; }

public slots:
    // Add data to queue and start processing
    void addData(const QString &name, const QVariant &data);
  
signals:
    void newData(const QString &name, const QVariant &data);

protected:
    QMap<QString, QQueue<QVariant>*> dataMap;
    DataType m_dataType;
};

#endif //PROCESSINGUNIT_H

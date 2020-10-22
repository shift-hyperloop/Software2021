#ifndef ACCELERATIONVELOCITYUNIT_H
#define ACCELERATIONVELOCITYUNIT_H

#include <QMetaType>
#include "processingunit.h"
#include "velocityprocessingunit.h"
#include "accelerationprocessingunit.h"



class AccelerationVelocityUnit : public ProcessingUnit
{
    Q_PROPERTY(QVariant data WRITE addData NOTIFY newData)
    QML_ELEMENT

public:
    AccelerationVelocityUnit();
    ~AccelerationVelocityUnit();

    virtual void run() override;

public slots:
    void addData(AccelerationStruct &data, VelocityStruct &velo);

signals:
    void newData(const QVariant &data, const QVariant &velo);
};

#endif // ACCELERATIONVELOCITYUNIT_H

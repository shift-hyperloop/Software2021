#ifndef ACCELERATIONPROCESSINGUNIT_H
#define ACCELERATIONPROCESSINGUNIT_H

#include <QMetaType>
#include "ProcessingUnit.h"

typedef struct accelerationStruct
{
    double acceleration;
} AccelerationStruct;

Q_DECLARE_METATYPE(AccelerationStruct);

class AccelerationProcessingUnit : public ProcessingUnit
{
    Q_PROPERTY(QVariant data WRITE addData NOTIFY newData)
    QML_ELEMENT

public:
    AccelerationProcessingUnit();
    ~AccelerationProcessingUnit();

    virtual void run() override;

public slots:
    void addData(AccelerationStruct &data);

signals:
    void newData(const QVariant &data);
};

#endif // ACCELERATIONPROCESSINGUNIT_H

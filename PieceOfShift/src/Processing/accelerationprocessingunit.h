#ifndef ACCELERATIONPROCESSINGUNIT_H
#define ACCELERATIONPROCESSINGUNIT_H

#include <QMetaType>
#include "processingunit.h"

/*typedef struct accelerationStruct
{
    double acceleration;
} AccelerationStruct;

Q_DECLARE_METATYPE(AccelerationStruct);*/

class AccelerationProcessingUnit : public ProcessingUnit
{

public:
    AccelerationProcessingUnit();
    ~AccelerationProcessingUnit();

    virtual void process(const QString& name) override;
};

#endif // ACCELERATIONPROCESSINGUNIT_H

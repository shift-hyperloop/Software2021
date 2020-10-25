#ifndef ACCELERATIONVELOCITYUNIT_H
#define ACCELERATIONVELOCITYUNIT_H

#include <QMetaType>
#include "processingunit.h"
#include "velocityprocessingunit.h"
#include "accelerationprocessingunit.h"

class AccelerationVelocityUnit : public ProcessingUnit
{

public:
    AccelerationVelocityUnit();
    ~AccelerationVelocityUnit();

    virtual void process() override;

};

#endif // ACCELERATIONVELOCITYUNIT_H

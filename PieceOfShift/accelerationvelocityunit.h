#ifndef ACCELERATIONVELOCITYUNIT_H
#define ACCELERATIONVELOCITYUNIT_H

#include "processingunit.h"

class AccelerationVelocityUnit: public ProcessingUnit
{
public:
    AccelerationVelocityUnit();
    ~AccelerationVelocityUnit();

    virtual void process(const QString &name) override;

private:
};

#endif //ACCELERATIONVELOCITYUNIT_H

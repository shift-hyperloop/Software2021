#ifndef VELOCITYPROCESSINGUNIT_H
#define VELOCITYPROCESSINGUNIT_H

#include "processingunit.h"

class VelocityProcessingUnit : public ProcessingUnit
{
public:
    VelocityProcessingUnit();
    ~VelocityProcessingUnit();

    virtual void process() override;

private:
};

#endif // VELOCITYPROCESSINGUNIT_H





#ifndef VELOCITYPROCESSINGUNIT_H
#define VELOCITYPROCESSINGUNIT_H

#include <QMetaType>
#include "processingunit.h"

class VelocityProcessingUnit : public ProcessingUnit
{
public:
    VelocityProcessingUnit();
    ~VelocityProcessingUnit();

    virtual void process() override;
};

#endif // VELOCITYPROCESSINGUNIT_H





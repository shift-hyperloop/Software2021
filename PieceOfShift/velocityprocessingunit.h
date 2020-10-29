#ifndef VELOCITYPROCESSINGUNIT_H
#define VELOCITYPROCESSINGUNIT_H

#include <QElapsedTimer>
#include "processingunit.h"

class VelocityProcessingUnit : public ProcessingUnit
{
public:
    VelocityProcessingUnit();
    ~VelocityProcessingUnit();

    virtual void process() override;

private:
    QElapsedTimer myTimer; // REMOVE THIS
};

#endif // VELOCITYPROCESSINGUNIT_H





#include "velocityprocessingunit.h"
#include <QMutexLocker>
#include <QDebug>

VelocityProcessingUnit::VelocityProcessingUnit()
{
    
}

VelocityProcessingUnit::~VelocityProcessingUnit()
{

}

void VelocityProcessingUnit::process()
{
    if(dataQueue.empty()) {
        emit newData(QVariant::fromValue(0)); // REMOVE THIS
        return;
    }
    VelocityStruct result = dataQueue.dequeue().value<VelocityStruct>();
    for (unsigned int i = 0; i < 1000000000; i++) {
        if (i % 2) {
            result.velocity *= 2;
        } else if (i % 3) {
            result.velocity *= 4;
        }
    }
    emit newData(QVariant::fromValue(result));
}

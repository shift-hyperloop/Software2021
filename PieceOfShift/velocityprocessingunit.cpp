#include "velocityprocessingunit.h"

VelocityProcessingUnit::VelocityProcessingUnit()
{
    m_dataType = VELOCITY;
}

VelocityProcessingUnit::~VelocityProcessingUnit()
{

}

void VelocityProcessingUnit::process()
{
    if(dataQueue.empty()) {
        return;
    }
    VelocityStruct result = dataQueue.back().value<VelocityStruct>();
    /*
     *  Do calculations on result here
     */
    emit newData(QPointF(0.0, 0.0)); // Use result and time to create point
}

#include "velocityprocessingunit.h"

VelocityProcessingUnit::VelocityProcessingUnit()
{
    m_dataType = VELOCITY;
}

VelocityProcessingUnit::~VelocityProcessingUnit()
{

}

void VelocityProcessingUnit::process(const QString& name)
{
    if(dataMap.value(name)->empty()) {
        return;
    }
    VelocityStruct result = dataMap.value(name)->back().value<VelocityStruct>();
    /*
     *  Do calculations on result here
     */
    emit newData(QPointF(0.0, 0.0)); // Use result and time to create point
}

#include "velocityprocessingunit.h"
#include <QPointF>

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
    emit newData(name, QPointF(result.timeMs, result.velocity)); // Use result and time to create point
}

#include "velocityprocessingunit.h"
#include <QPointF>
#include <QDebug>

VelocityProcessingUnit::VelocityProcessingUnit()
{
    m_dataType = INT32;
}

VelocityProcessingUnit::~VelocityProcessingUnit()
{

}

void VelocityProcessingUnit::process(const QString& name)
{
    if(dataMap.value(name)->empty()) {
        return;
    }

    VelocityStruct result;// = dataMap.value(name)->back().value<VelocityStruct>();
    /*
     *  Do calculations on result here
     */
    emit newData(name, QPointF(result.timeMs, result.velocity)); // Use result and time to create point
}

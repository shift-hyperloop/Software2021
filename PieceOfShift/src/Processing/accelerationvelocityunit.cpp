#include "accelerationvelocityunit.h"
#include "Processing/processingunit.h"
#include <QDebug>
#include <QPointF>


AccelerationVelocityUnit::AccelerationVelocityUnit()
{
    m_dataType = INT32;
}

AccelerationVelocityUnit::~AccelerationVelocityUnit() {

}


void AccelerationVelocityUnit::process(const QString& name)
{
    if(dataMap.value(name)->empty()) {
        return;
    }
    AccelerationVelocityStruct result = dataMap.value(name)->back().value<AccelerationVelocityStruct>();


    double accelerationVelocity = result.acceleration * result.velocity;
    emit newData(name, QPointF(result.timeMs, accelerationVelocity)); // Use result and time to create point

}

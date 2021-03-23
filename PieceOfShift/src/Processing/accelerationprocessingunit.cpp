#include "accelerationprocessingunit.h"
#include "Processing/processingunit.h"
#include <QPointF>



AccelerationProcessingUnit::AccelerationProcessingUnit()
{
    m_dataType = INT32;
}

AccelerationProcessingUnit::~AccelerationProcessingUnit()
{

}

void AccelerationProcessingUnit::process(const QString& name)
{
    if(dataMap.value(name)->empty()) {
        return;
    }
    AccelerationStruct result = dataMap.value(name)->back().value<AccelerationStruct>();

    /*
     *  Do calculations on result here
     */
    emit newData(name, QPointF(result.timeMs, result.acceleration)); // Use result and time to create point

}

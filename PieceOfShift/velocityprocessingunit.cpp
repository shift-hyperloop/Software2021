#include "velocityprocessingunit.h"
#include <QRandomGenerator>
#include <QDebug>

VelocityProcessingUnit::VelocityProcessingUnit()
{
    m_dataType = VELOCITY;

    myTimer.start(); // REMOVE THIS
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
    for (unsigned int i = 0; i < 100000000; i++) {
        if (i % 2) {
            result.velocity += 0.00001;
        } else if (i % 3) {
            result.velocity += 0.00004;
        }
    }
    int nMs = myTimer.elapsed();
    QRandomGenerator random(nMs);
    double vel = random.generate() % 40000;
    emit newData(QPointF(nMs, vel));
}

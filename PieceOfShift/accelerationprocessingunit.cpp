#include "accelerationprocessingunit.h"
#include <QMutexLocker>
#include <QDebug>
#include <QtMath>
#include <QElapsedTimer>



AccelerationProcessingUnit::AccelerationProcessingUnit()
{

}

AccelerationProcessingUnit::~AccelerationProcessingUnit()
{

}

void AccelerationProcessingUnit::process() {
    /*QElapsedTimer timer;
    timer.start();
    while(!dataQueue.empty()) {
        AccelerationStruct acceleration = dataQueue.dequeue().value<AccelerationStruct>();
        acceleration.acceleration = acceleration.acceleration * 30;
        int time = timer.elapsed();
        qInfo() << "Time a: " << time * pow(10, -3) << " seconds" << "Value a: " << acceleration.acceleration;

    }*/
}

#include "accelerationvelocityunit.h"
#include <QMutexLocker>
#include <QDebug>
#include <QtMath>
#include <QElapsedTimer>



AccelerationVelocityUnit::AccelerationVelocityUnit()
{

}

AccelerationVelocityUnit::~AccelerationVelocityUnit() {

}


void AccelerationVelocityUnit::process() {
    /*QElapsedTimer timer;
    timer.start();
    bool accelerationdata = true;
    AccelerationStruct acceleration;
    VelocityStruct velocity;
    while(!dataQueue.empty()) {
        if(accelerationdata)  {
            acceleration = dataQueue.dequeue().value<AccelerationStruct>();
            accelerationdata = false;
        }
        if(!accelerationdata) {
            velocity = dataQueue.dequeue().value<VelocityStruct>();
            accelerationdata = true;
            acceleration.acceleration = acceleration.acceleration * velocity.velocity;
            int time = timer.elapsed();
            qInfo() << "Time av: " << time * pow(10, -3) << " seconds" << "Value av: " << acceleration.acceleration;

        }
    }*/
}

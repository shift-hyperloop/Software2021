#include "accelerationvelocityunit.h"
#include <QMutexLocker>
#include <QDebug>
#include <QtMath>
#include <QElapsedTimer>



AccelerationVelocityUnit::AccelerationVelocityUnit()
{

}

AccelerationVelocityUnit::~AccelerationVelocityUnit() {
    mutex.lock();
    abort = true;
    waitCondition.wakeOne();
    mutex.unlock();

    wait();
}

void AccelerationVelocityUnit::addData(AccelerationStruct &data, VelocityStruct &velo)
{
    QVariant copiedData = QVariant::fromValue(data);
    QVariant copiedData2 = QVariant::fromValue(velo);
    dataQueue.enqueue(copiedData);
    dataQueue.enqueue(copiedData2);
}

void AccelerationVelocityUnit::run() {
    QElapsedTimer timer;
    timer.start();
    bool accelerationdata = true;
    AccelerationStruct acceleration;
    VelocityStruct velocity;
    while(!dataQueue.empty()) {
        if (restart)
            break;
        if (abort)
            return;
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



    }
}

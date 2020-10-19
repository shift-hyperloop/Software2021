#include "accelerationprocessingunit.h"
#include <QMutexLocker>
#include <QDebug>
#include <QtMath>
#include <QElapsedTimer>



AccelerationProcessingUnit::AccelerationProcessingUnit()
{

}

AccelerationProcessingUnit::~AccelerationProcessingUnit() {
    mutex.lock();
    abort = true;
    waitCondition.wakeOne();
    mutex.unlock();

    wait();
}

void AccelerationProcessingUnit::addData(AccelerationStruct &data)
{
    QVariant copiedData = QVariant::fromValue(data);
    dataQueue.enqueue(copiedData);
}

void AccelerationProcessingUnit::run() {
    QElapsedTimer timer;
    timer.start();
    while(!dataQueue.empty()) {
        AccelerationStruct acceleration = dataQueue.dequeue().value<AccelerationStruct>();
        if (restart)
            break;
        if (abort)
            return;
        acceleration.acceleration = acceleration.acceleration * 30;
        int time = timer.elapsed();
        qInfo() << "Time a: " << time * pow(10, -3) << " seconds" << "Value a: " << acceleration.acceleration;

    }
}

#include "velocityprocessingunit.h"
#include <QMutexLocker>
#include <QDebug>

VelocityProcessingUnit::VelocityProcessingUnit()
{
    
}

VelocityProcessingUnit::~VelocityProcessingUnit()
{
    mutex.lock();
    abort = true;
    waitCondition.wakeOne();
    mutex.unlock();

    wait();
}

void VelocityProcessingUnit::addData(VelocityStruct &data) {
    QVariant copiedData = QVariant::fromValue(data);
    dataQueue.enqueue(copiedData);
}  

void VelocityProcessingUnit::run()
{
    while (!dataQueue.empty()) {
        VelocityStruct result = dataQueue.dequeue().value<VelocityStruct>();
        for (unsigned int i = 0; i < 1000000000; i++) {
            if (restart)
                break;
            if (abort)
                return;
            if (i % 2) {
                result.velocity *= 2;
            } else if (i % 3) {
                result.velocity *= 4;
            }
        }

        qInfo("result.velocity");
        //emit newData(QVariant::fromValue(result));

        mutex.lock();
        if (!restart)
            waitCondition.wait(&mutex);
        restart = false;
        mutex.unlock();
    }
}

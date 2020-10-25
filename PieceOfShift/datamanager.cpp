#include "datamanager.h"
#include "velocityprocessingunit.h"

DataManager::DataManager()
{
    VelocityProcessingUnit* vpu = new VelocityProcessingUnit();
    processingUnits.append(vpu);

    connect(vpu, &VelocityProcessingUnit::newData,
            this, &DataManager::newVelocity);
}

DataManager::~DataManager()
{
    for (auto processingUnit : processingUnits) {
        delete processingUnit;
    }

    mutex.lock();
    abort = true;
    condition.wakeOne();
    mutex.unlock();

    wait();
}

void DataManager::run()
{
    while(!restart) {
        for (auto processingUnit : processingUnits) {
            processingUnit->process();
        }
    }
}


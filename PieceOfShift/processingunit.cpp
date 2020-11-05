#include "processingunit.h"

ProcessingUnit::~ProcessingUnit()
{
    for (QQueue<QVariant>* queue : dataMap.values())
    {
        delete queue;
    }
}

void ProcessingUnit::addData(const QPair<QString, QVariant> &data)
{
    if (dataMap.contains(data.first)) {
        dataMap.value(data.first)->enqueue(data.second);
    } else {
        QQueue<QVariant> *dataQueue = new QQueue<QVariant>();
        dataQueue->enqueue(data.second);
        dataMap.insert(data.first, dataQueue);
    }
    process(data.first);
}


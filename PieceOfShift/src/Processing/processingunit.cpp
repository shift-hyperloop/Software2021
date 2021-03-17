#include "processingunit.h"
#include <QDebug>

ProcessingUnit::~ProcessingUnit()
{
    for (QQueue<QVariant>* queue : dataMap.values())
    {
        delete queue;
    }
}

void ProcessingUnit::addData(const QString &name, const QVariant &data)
{
    if (dataMap.contains(name)) {
        dataMap.value(name)->enqueue(data);
    } else {
        QQueue<QVariant> *dataQueue = new QQueue<QVariant>();
        dataQueue->enqueue(data);
        dataMap.insert(name, dataQueue);
    }
    process(name);
}

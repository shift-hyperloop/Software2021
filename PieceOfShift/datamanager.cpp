#include <QtConcurrent/QtConcurrent>
#include <algorithm>

#include "datamanager.h"
#include "velocityprocessingunit.h"

DataManager::DataManager()
{
    VelocityProcessingUnit* vpu = new VelocityProcessingUnit();
    processingUnits.append(vpu);

    connect(vpu, &VelocityProcessingUnit::newData,
            this, &DataManager::newVelocity);

    /* Create Decoder/DataFetcher object here and start it when signal from
     QML has been received */
}

DataManager::~DataManager()
{
    // Delete all processing units on destruction to avoid memory leak
    for (auto processingUnit : processingUnits) {
        delete processingUnit;
    }
}

void DataManager::addData(const DataType &dataType, const QVariant &data)
{
    // Find processing unit with correct data type and add data
    ProcessingUnit* processingUnit =
            *std::find_if(processingUnits.begin(),
                          processingUnits.end(),
                          [&dataType](auto x)
                          { return x->dataType() == dataType; });
    processingUnit->addData(data);
}


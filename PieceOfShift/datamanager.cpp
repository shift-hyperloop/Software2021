#include <QtConcurrent/QtConcurrent>
#include <algorithm>

#include "datamanager.h"
#include "velocityprocessingunit.h"

DataManager::DataManager()
{
    /* Create and append all processing units here,
     * maybe refactor to separate function
     */
    VelocityProcessingUnit* vpu = new VelocityProcessingUnit();
    processingUnits.append(vpu);

    // Connect newData signal to corresponding DataManager signal
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

void DataManager::addData(const QString& name, const DataType &dataType, const QVariant &data)
{
    // Find processing unit with correct data type and add data
    ProcessingUnit* processingUnit =
            *std::find_if(processingUnits.begin(),
                          processingUnits.end(),
                          [&dataType](auto x)
                          { return x->dataType() == dataType; });
    QtConcurrent::run(processingUnit, &ProcessingUnit::addData, name, data);
}


/* The follwing code is just used for testing, and
 * should be removed before production
 */
int t = 0;
float v = 2;

void DataManager::dummyData()
{
    v =  0.01 *((float) t * log(t));
    VelocityStruct vs;
    t += 1;
    vs.timeMs = t;
    vs.velocity = v;
    addData("Velocity", DataType::VELOCITY, QVariant::fromValue(vs));
}


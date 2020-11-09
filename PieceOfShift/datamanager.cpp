#include <QtConcurrent/QtConcurrent>
#include <algorithm>

#include "datamanager.h"
#include "velocityprocessingunit.h"
#include "accelerationprocessingunit.h"
#include "accelerationvelocityunit.h"

DataManager::DataManager()
{
    /* Create and append all processing units here,
     * maybe refactor to separate function
     */
    VelocityProcessingUnit* vpu = new VelocityProcessingUnit();
    processingUnits.append(vpu);
    AccelerationProcessingUnit* apu = new AccelerationProcessingUnit();
    processingUnits.append(apu);
    AccelerationVelocityUnit* avu = new AccelerationVelocityUnit();
    processingUnits.append(avu);

    // Connect newData signal to corresponding DataManager signal
    connect(vpu, &VelocityProcessingUnit::newData,
            this, &DataManager::newVelocity);
    connect(apu, &AccelerationProcessingUnit::newData,
            this, &DataManager::newAcceleration);
    connect(avu, &AccelerationVelocityUnit::newData,
            this, &DataManager::newAccelerationVelocity);

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
float a = 3;

void DataManager::dummyData()
{
    v =  0.01 *((float) t * log(t));
    VelocityStruct vs;
    t += 1;
    vs.timeMs = t;
    vs.velocity = v;
    addData("Velocity", DataType::VELOCITY, QVariant::fromValue(vs));
    a =  0.03 *((float) t * log(t));
    AccelerationStruct as;
    AccelerationVelocityStruct avs;
    as.timeMs = t;
    avs.timeMs = t;
    vs.velocity = v;
    as.acceleration = a;
    avs.acceleration = a;
    avs.velocity = v;
    addData("Velocity", DataType::VELOCITY, QVariant::fromValue(vs));
    addData("Acceleration", DataType::ACCELERATION, QVariant::fromValue(vs));
    addData("AccelerationVelocity", DataType::ACCELERATIONVELOCITY, QVariant::fromValue(vs));
}


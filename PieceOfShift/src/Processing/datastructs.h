#pragma once

#include <stdint.h>
#include <QDataStream>
#include <QVariant>

/*
+---+ How to use +--+

    // WRITE
    QByteArray ba;
    QDataStream stream(&ba, QIODevice::ReadWrite);
    DataStructs::VCUStatus vcuStatus = {true, true, true, true, true, true, true, true, true, 10.0f, 10.0f};
    stream << vcuStatus;

    // READ
    QDataStream stream2(&ba, QIODevice::ReadOnly);
    DataStructs::VCUStatus vcuStatus2;
    stream2 >> vcuStatus2;
*/

namespace DataStructs 
{
    class DataStruct : public QObject
    {
        protected:
            DataStruct() {}
        friend QDataStream& operator<<(QDataStream& dataStream, const DataStruct& object)
        {
            for(int i=0; i< object.metaObject()->propertyCount(); ++i) {
                if(object.metaObject()->property(i).isStored(&object)) {
                    dataStream << object.metaObject()->property(i).read(&object);
                }
            }
            return dataStream;
        }

        friend QDataStream & operator>>(QDataStream& dataStream, DataStruct& object) {
            QVariant var;
            for(int i=0; i < object.metaObject()->propertyCount(); ++i) {
                if(object.metaObject()->property(i).isStored(&object)) {
                    dataStream >> var;
                    object.metaObject()->property(i).write(&object, var);
                }
            }
            return dataStream;
        }
    };

    struct ErrorCode
    {
        public:
            ErrorCode() {}
        uint8_t error_code;
    };

    struct VCUStatus
    {
        bool BMS_1;
        bool BMS_2;
        bool Inverter_1;
        bool Inverter_2;
        bool Telemetry;
        bool State_indication;
        bool Sensor_suite_1;
        bool Sensor_suite_2;
        bool VCU;
        
        float latency_CAN_0;
        float latency_CAN_1;

        // NOTE: Overload here as well so data from telemetry can be directly converted to struct and vice versa (for all structs really)
        friend QDataStream& operator<<(QDataStream& dataStream, const VCUStatus& object)
        {
            // NOTE: Change if stream we receive is not continuous
            dataStream << object.BMS_1
                       << object.BMS_2
                       << object.Inverter_1
                       << object.Inverter_2
                       << object.Telemetry
                       << object.State_indication
                       << object.Sensor_suite_1
                       << object.Sensor_suite_2
                       << object.VCU
                       << object.latency_CAN_0
                       << object.latency_CAN_1;

            return dataStream;
        }

        friend QDataStream & operator>>(QDataStream& dataStream, VCUStatus& object) 
        {
            dataStream >> object.BMS_1
                       >> object.BMS_2
                       >> object.Inverter_1
                       >> object.Inverter_2
                       >> object.Telemetry
                       >> object.State_indication
                       >> object.Sensor_suite_1
                       >> object.Sensor_suite_2
                       >> object.VCU

                       >> object.latency_CAN_0
                       >> object.latency_CAN_1;

            return dataStream;
        }

    };

    struct Vector3f 
    {
        float position;			
        float speed;				
        float acceleration;			
    };

    struct PodState 
    {
        uint8_t state;
    };


    struct Vector3i 
    {
        uint32_t pitch;
        uint32_t yaw;
        uint32_t roll;
    } ;

    struct Bool 
    {
        bool status_0;
    };

    struct Vector3b 
    {
        bool status_0;
        bool status_1;
    };


    struct Char 
    {
        uint8_t value_0;	
    } ;

    struct Vector2c 
    {
        uint8_t value_0;
        uint8_t value_1;
    };

    struct Vector3c 
    {
        uint8_t value_0;
        uint8_t value_1;
        uint8_t value_2;
    };

    struct Vector16c 
    {
        uint8_t value_0;
        uint8_t value_1;
        uint8_t value_2;
        uint8_t value_3;
        uint8_t value_4;
        uint8_t value_5;
        uint8_t value_6;
        uint8_t value_7;
        uint8_t value_8;
        uint8_t value_9;
        uint8_t value_10;
        uint8_t value_11;
        uint8_t value_12;
        uint8_t value_13;
        uint8_t value_14;
        uint8_t value_15;	
    };

    struct Short 
    {
        uint16_t value_0;
    };

    struct Vector2s 
    {
        uint16_t value_0;
        uint16_t value_1;
    };

    struct Int 
    {
        uint32_t value_0;
    };

    struct Float 
    {
        float value_0;
    };

    struct Vector2f 
    {
        float value_0;
        float value_1;
    } ;

    struct Vector4f 
    {
        float value_0;
        float value_1;
        float value_2;
        float value_3;
    };

    struct Vector6f 
    {
        float value_0;
        float value_1;
        float value_2;
        float value_3;
        float value_4;
        float value_5;
    };

    struct Vector8f 
    {
        float value_0;
        float value_1;
        float value_2;
        float value_3;
        float value_4;
        float value_5;
        float value_6;
        float value_7;
    };

    struct Vector16f 
    {
        float value_0;
        float value_1;
        float value_2;
        float value_3;
        float value_4;
        float value_5;
        float value_6;
        float value_7;
        float value_8;
        float value_9;
        float value_10;
        float value_11;
        float value_12;
        float value_13;
        float value_14;
        float value_15;
    };

}

Q_DECLARE_METATYPE(DataStructs::ErrorCode)
Q_DECLARE_METATYPE(DataStructs::Float)
Q_DECLARE_METATYPE(DataStructs::Int)
Q_DECLARE_METATYPE(DataStructs::PodState)
Q_DECLARE_METATYPE(DataStructs::Short)
Q_DECLARE_METATYPE(DataStructs::VCUStatus)
Q_DECLARE_METATYPE(DataStructs::Vector16c)
Q_DECLARE_METATYPE(DataStructs::Vector16f)
Q_DECLARE_METATYPE(DataStructs::Vector2c)
Q_DECLARE_METATYPE(DataStructs::Vector2f)
Q_DECLARE_METATYPE(DataStructs::Vector2s)
Q_DECLARE_METATYPE(DataStructs::Vector3b)
Q_DECLARE_METATYPE(DataStructs::Vector3c)
Q_DECLARE_METATYPE(DataStructs::Vector3f)
Q_DECLARE_METATYPE(DataStructs::Vector3i)
Q_DECLARE_METATYPE(DataStructs::Vector4f)
Q_DECLARE_METATYPE(DataStructs::Vector6f)
Q_DECLARE_METATYPE(DataStructs::Vector8f)




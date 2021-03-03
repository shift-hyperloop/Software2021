#pragma once

#include <stdint.h>
#include <QDataStream>
#include <QVariant>

namespace DataStructs 
{
    class DataStruct : public QObject
    {
        friend QDataStream& operator<<(QDataStream& dataStream, const DataStruct& object)
        {
            for(int i=0; i< object.metaObject()->propertyCount(); ++i) {
                if(object.metaObject()->property(i).isStored(&object)) {
                    dataStream << object.metaObject()->property(i).read(&object);
                }
            }
            return dataStream;
        }

        friend QDataStream & operator>>(QDataStream& dataStream, const DataStruct& object) {
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

    struct ErrorCode : public DataStruct
    {
        uint8_t error_code;
    };

    struct VCUStatus : public DataStruct
    {
        bool BMS_1;
        bool BMS_2;
        bool Inverter_1;
        bool Inverter_2;
        bool Telemetry;
        bool State_indication;
        bool Sensor_suit_1;
        bool Sensor_suit_2;
        bool VCU;
        
        float latency_CAN_0;
        float latency_CAN_1;

        // NOTE: Overload here as well so data from telemetry can be directly converted to struct and vice versa (for all structs really)
    };

    struct Vector3f : public DataStruct
    {
        float position;			
        float speed;				
        float acceleration;			
    };

    struct PodState : public DataStruct
    {
        uint8_t state;
    };


    struct Vector3i : public DataStruct
    {
        uint32_t pitch;
        uint32_t yaw;
        uint32_t roll;
    } ;

    struct Bool : public DataStruct
    {
        bool status_0;
    };

    struct Vector3b : public DataStruct
    {
        bool status_0;
        bool status_1;
    };


    struct Char : public DataStruct
    {
        uint8_t value_0;	
    } ;

    struct Vector2c : public DataStruct
    {
        uint8_t value_0;
        uint8_t value_1;
    };

    struct Vector3c : public DataStruct
    {
        uint8_t value_0;
        uint8_t value_1;
        uint8_t value_2;
    };

    struct Vector16c : public DataStruct
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

    struct Short : public DataStruct
    {
        uint16_t value_0;
    };

    struct Vector2s : public DataStruct
    {
        uint16_t value_0;
        uint16_t value_1;
    };

    struct Int : public DataStruct
    {
        uint32_t value_0;
    };

    struct Float : public DataStruct
    {
        float value_0;
    };

    struct Vector2f : public DataStruct
    {
        float value_0;
        float value_1;
    } ;

    struct Vector4f : public DataStruct
    {
        float value_0;
        float value_1;
        float value_2;
        float value_3;
    };

    struct Vector6f : public DataStruct
    {
        float value_0;
        float value_1;
        float value_2;
        float value_3;
        float value_4;
        float value_5;
    };

    struct Vector8f : public DataStruct
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

    struct Vector16f : public DataStruct
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


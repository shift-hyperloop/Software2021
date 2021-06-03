#pragma once

#include <stdint.h>
#include <QDataStream>
#include <QVariant>
#include <qobject.h>
#include <qobjectdefs.h>

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

enum class DataType {
    ERROR_CODE,
    VCU_STATUS,
    BOOL,
    UINT8,
    INT8,
    UINT16,
    INT16,
    UINT32,
    INT32,
    FLOAT,
    DOUBLE,
    VECTOR_3I,
    VECTOR_3F,
    VECTOR_2B,
    VECTOR_2B_1S,
    CHAR,
    VECTOR_2C,
    VECTOR_3C,
    VECTOR_16C,
    SHORT,
    VECTOR_2S,
    VECTOR_30S,
    VECTOR_23S,
    VECTOR_2F,
    VECTOR_4F,
    VECTOR_6F,
    VECTOR_8F,
    VECTOR_16F,
    VECTOR_2C_2D,
    VECTOR_6D,
    VECTOR_3D_4F,
    VECTOR_4D_4F,
};

namespace DataStructs {

struct ErrorCode
{
    uint8_t error_code;

    friend QDataStream &operator<<(QDataStream &dataStream, const ErrorCode &object)
    {
        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, ErrorCode &object)
    {
        return dataStream;
    }
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
    friend QDataStream &operator<<(QDataStream &dataStream, const VCUStatus &object)
    {
        // NOTE: Change if stream we receive is not continuous
        dataStream << object.BMS_1 << object.BMS_2 << object.Inverter_1 << object.Inverter_2
                   << object.Telemetry << object.State_indication << object.Sensor_suite_1
                   << object.Sensor_suite_2 << object.VCU << object.latency_CAN_0
                   << object.latency_CAN_1;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, VCUStatus &object)
    {
        dataStream >> object.BMS_1 >> object.BMS_2 >> object.Inverter_1 >> object.Inverter_2
            >> object.Telemetry >> object.State_indication >> object.Sensor_suite_1
            >> object.Sensor_suite_2 >> object.VCU

            >> object.latency_CAN_0 >> object.latency_CAN_1;

        return dataStream;
    }
};

struct Vector3f
{
    float position;
    float speed;
    float acceleration;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector3f &object)
    {
        dataStream << object.position << object.speed << object.acceleration;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector3f &object)
    {
        dataStream >> object.position >> object.speed >> object.acceleration;

        return dataStream;
    }
};

struct Vector3i
{
    uint32_t pitch;
    uint32_t yaw;
    uint32_t roll;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector3i &object)
    {
        dataStream << object.pitch << object.yaw << object.roll;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector3i &object)
    {
        dataStream >> object.pitch >> object.yaw >> object.roll;

        return dataStream;
    }
};

struct Bool
{
    bool status_0;

    friend QDataStream &operator<<(QDataStream &dataStream, const Bool &object)
    {
        dataStream << object.status_0;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Bool &object)
    {
        dataStream >> object.status_0;

        return dataStream;
    }
};

struct Vector2b
{
    bool status_0;
    bool status_1;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector2b &object)
    {
        dataStream << object.status_0 << object.status_1;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector2b &object)
    {
        dataStream >> object.status_0 >> object.status_1;

        return dataStream;
    }
};

struct Vector2b1s
{
    bool bool_0;
    bool bool_1;

    uint16_t short_0;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector2b1s &object)
    {
        dataStream << object.bool_0 << object.bool_1 << object.short_0;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector2b1s &object)
    {
        dataStream >> object.bool_0 >> object.bool_1 << object.short_0;

        return dataStream;
    }
};

struct Char
{
    uint8_t value_0;

    friend QDataStream &operator<<(QDataStream &dataStream, const Char &object)
    {
        dataStream << object.value_0;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Char &object)
    {
        dataStream >> object.value_0;

        return dataStream;
    }
};

struct Vector2c
{
    uint8_t value_0;
    uint8_t value_1;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector2c &object)
    {
        dataStream << object.value_0 << object.value_1;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector2c &object)
    {
        dataStream >> object.value_0 >> object.value_1;

        return dataStream;
    }
};

struct Vector3c
{
    uint8_t value_0;
    uint8_t value_1;
    uint8_t value_2;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector3c &object)
    {
        dataStream << object.value_0 << object.value_1 << object.value_2;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector3c &object)
    {
        dataStream >> object.value_0 >> object.value_1 >> object.value_2;

        return dataStream;
    }
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

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector16c &object)
    {
        dataStream << object.value_0 << object.value_1 << object.value_2 << object.value_3
                   << object.value_4 << object.value_5 << object.value_6 << object.value_7
                   << object.value_8 << object.value_9 << object.value_10 << object.value_11
                   << object.value_12 << object.value_13 << object.value_14 << object.value_15;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector16c &object)
    {
        dataStream >> object.value_0 >> object.value_1 >> object.value_2 >> object.value_3
            >> object.value_4 >> object.value_5 >> object.value_6 >> object.value_7
            >> object.value_8 >> object.value_9 >> object.value_10 >> object.value_11
            >> object.value_12 >> object.value_13 >> object.value_14 >> object.value_15;

        return dataStream;
    }
};

struct Short
{
    uint16_t value_0;

    friend QDataStream &operator<<(QDataStream &dataStream, const Short &object)
    {
        dataStream << object.value_0;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Short &object)
    {
        dataStream >> object.value_0;

        return dataStream;
    }
};

struct Vector2s
{
    uint16_t value_0;
    uint16_t value_1;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector2s &object)
    {
        dataStream << object.value_0 << object.value_1;
        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector2s &object)
    {
        dataStream >> object.value_0 >> object.value_1;

        return dataStream;
    }
};

struct Vector30s
{
    uint16_t value_0;
    uint16_t value_1;
    uint16_t value_2;
    uint16_t value_3;
    uint16_t value_4;
    uint16_t value_5;
    uint16_t value_6;
    uint16_t value_7;
    uint16_t value_8;
    uint16_t value_9;
    uint16_t value_10;
    uint16_t value_11;
    uint16_t value_12;
    uint16_t value_13;
    uint16_t value_14;
    uint16_t value_15;
    uint16_t value_16;
    uint16_t value_17;
    uint16_t value_18;
    uint16_t value_19;
    uint16_t value_20;
    uint16_t value_21;
    uint16_t value_22;
    uint16_t value_23;
    uint16_t value_24;
    uint16_t value_25;
    uint16_t value_26;
    uint16_t value_27;
    uint16_t value_28;
    uint16_t value_29;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector30s &object)
    {
        dataStream << object.value_0 << object.value_1 << object.value_2 << object.value_3
                   << object.value_4 << object.value_5 << object.value_6 << object.value_7
                   << object.value_8 << object.value_9 << object.value_10 << object.value_11
                   << object.value_12 << object.value_13 << object.value_14 << object.value_15
                   << object.value_16 << object.value_17 << object.value_18 << object.value_19
                   << object.value_20 << object.value_21 << object.value_22 << object.value_23
                   << object.value_24 << object.value_25 << object.value_26 << object.value_27
                   << object.value_28 << object.value_29;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector30s &object)
    {
        dataStream >> object.value_0 >> object.value_1 >> object.value_2 >> object.value_3
            >> object.value_4 >> object.value_5 >> object.value_6 >> object.value_7
            >> object.value_8 >> object.value_9 >> object.value_10 >> object.value_11
            >> object.value_12 >> object.value_13 >> object.value_14 >> object.value_15
            >> object.value_16 >> object.value_17 >> object.value_18 >> object.value_19
            >> object.value_20 >> object.value_21 >> object.value_22 >> object.value_23
            >> object.value_24 >> object.value_25 >> object.value_26 >> object.value_27
            >> object.value_28 >> object.value_29;

        return dataStream;
    }
};

struct Vector23s
{
    uint16_t value_0;
    uint16_t value_1;
    uint16_t value_2;
    uint16_t value_3;
    uint16_t value_4;
    uint16_t value_5;
    uint16_t value_6;
    uint16_t value_7;
    uint16_t value_8;
    uint16_t value_9;
    uint16_t value_10;
    uint16_t value_11;
    uint16_t value_12;
    uint16_t value_13;
    uint16_t value_14;
    uint16_t value_15;
    uint16_t value_16;
    uint16_t value_17;
    uint16_t value_18;
    uint16_t value_19;
    uint16_t value_20;
    uint16_t value_21;
    uint16_t value_22;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector23s &object)
    {
        dataStream << object.value_0 << object.value_1 << object.value_2 << object.value_3
                   << object.value_4 << object.value_5 << object.value_6 << object.value_7
                   << object.value_8 << object.value_9 << object.value_10 << object.value_11
                   << object.value_12 << object.value_13 << object.value_14 << object.value_15
                   << object.value_16 << object.value_17 << object.value_18 << object.value_19
                   << object.value_20 << object.value_21 << object.value_22;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector23s &object)
    {
        dataStream >> object.value_0 >> object.value_1 >> object.value_2 >> object.value_3
            >> object.value_4 >> object.value_5 >> object.value_6 >> object.value_7
            >> object.value_8 >> object.value_9 >> object.value_10 >> object.value_11
            >> object.value_12 >> object.value_13 >> object.value_14 >> object.value_15
            >> object.value_16 >> object.value_17 >> object.value_18 >> object.value_19
            >> object.value_20 >> object.value_21 >> object.value_22;

        return dataStream;
    }
};

struct Int
{
    int32_t value_0;

    friend QDataStream &operator<<(QDataStream &dataStream, const Int &object)
    {
        // NOTE: Change if stream we receive is not continuous
        dataStream << object.value_0;
        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Int &object)
    {
        dataStream >> object.value_0;

        return dataStream;
    }
};

struct Float
{
    float value_0;

    friend QDataStream &operator<<(QDataStream &dataStream, const Float &object)
    {
        dataStream << object.value_0;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Float &object)
    {
        dataStream >> object.value_0;

        return dataStream;
    }
};

struct Double
{
    double value_0;

    friend QDataStream &operator<<(QDataStream &dataStream, const Double &object)
    {
        dataStream << object.value_0;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Double &object)
    {
        dataStream >> object.value_0;

        return dataStream;
    }
};

struct Vector2f
{
    float value_0;
    float value_1;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector2f &object)
    {
        dataStream << object.value_0 << object.value_1;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector2f &object)
    {
        dataStream >> object.value_0 >> object.value_1;

        return dataStream;
    }
};

struct Vector4f
{
    float value_0;
    float value_1;
    float value_2;
    float value_3;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector4f &object)
    {
        dataStream << object.value_0 << object.value_1 << object.value_2 << object.value_3;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector4f &object)
    {
        dataStream >> object.value_0 >> object.value_1 >> object.value_2 >> object.value_3;

        return dataStream;
    }
};

struct Vector6f
{
    float value_0;
    float value_1;
    float value_2;
    float value_3;
    float value_4;
    float value_5;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector6f &object)
    {
        dataStream << object.value_0 << object.value_1 << object.value_2 << object.value_3
                   << object.value_4 << object.value_5;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector6f &object)
    {
        dataStream >> object.value_0 >> object.value_1 >> object.value_2 >> object.value_3
            >> object.value_4 >> object.value_5;

        return dataStream;
    }
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

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector8f &object)
    {
        dataStream << object.value_0 << object.value_1 << object.value_2 << object.value_3
                   << object.value_4 << object.value_5 << object.value_6 << object.value_7;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector8f &object)
    {
        dataStream >> object.value_0 >> object.value_1 >> object.value_2 >> object.value_3
            >> object.value_4 >> object.value_5 >> object.value_6 >> object.value_7;

        return dataStream;
    }
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

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector16f &object)
    {
        // NOTE: Change if stream we receive is not continuous
        dataStream << object.value_0 << object.value_1 << object.value_2 << object.value_3
                   << object.value_4 << object.value_5 << object.value_6 << object.value_7
                   << object.value_8 << object.value_9 << object.value_10 << object.value_11
                   << object.value_12 << object.value_13 << object.value_14 << object.value_15;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector16f &object)
    {
        dataStream >> object.value_0 >> object.value_1 >> object.value_2 >> object.value_3
            >> object.value_4 >> object.value_5 >> object.value_6 >> object.value_7
            >> object.value_8 >> object.value_9 >> object.value_10 >> object.value_11
            >> object.value_12 >> object.value_13 >> object.value_14 >> object.value_15;

        return dataStream;
    }
};

struct Vector2c2d
{
    uint8_t value_0;
    uint8_t value_1;

    double value_2;
    double value_3;

    friend QDataStream &operator<<(QDataStream &dataStream, const Vector2c2d &object)
    {
        // NOTE: Change if stream we receive is not continuous
        dataStream << object.value_0 << object.value_1 << object.value_2 << object.value_3;

        return dataStream;
    }

    friend QDataStream &operator>>(QDataStream &dataStream, Vector2c2d &object)
    {
        dataStream >> object.value_0 >> object.value_1 >> object.value_2 >> object.value_3;

        return dataStream;
    }
};

struct Vector2c2i
{
        uint8_t value_0;
        uint8_t value_1;
        uint32_t value_2;
        uint32_t value_3;

        friend QDataStream& operator<<(QDataStream& dataStream, const Vector2c2i& object)
        {
                dataStream << object.value_0
                           << object.value_1
                           << object.value_2
                           << object.value_3;

                return dataStream;
        }

        friend QDataStream& operator>>(QDataStream& dataStream, Vector2c2i& object)
        {
                dataStream >> object.value_0
                           >> object.value_1
                           >> object.value_2
                           >> object.value_3;

                return dataStream;
        }
};

struct Vector6d
{
        double value_0;
        double value_1;
        double value_2;
        double value_3;
        double value_4;
        double value_5;

        friend QDataStream& operator<<(QDataStream& dataStream, const Vector6d& object)
        {
                dataStream << object.value_0
                           << object.value_1
                           << object.value_2
                           << object.value_3
                           << object.value_4
                           << object.value_5;

                return dataStream;
        }

        friend QDataStream& operator>>(QDataStream& dataStream, Vector6d& object)
        {
                dataStream >> object.value_0
                           >> object.value_1
                           >> object.value_2
                           >> object.value_3
                           >> object.value_4
                           >> object.value_5;

                return dataStream;
        }
};

struct Vector3d4f
{
        double value_0;
        double value_1;
        double value_2;
        float value_3;
        float value_4;
        float value_5;
        float value_6;

        friend QDataStream& operator<<(QDataStream& dataStream, const Vector3d4f& object)
        {
                dataStream << object.value_0
                           << object.value_1
                           << object.value_2
                           << object.value_3
                           << object.value_4
                           << object.value_5
                           << object.value_6;

                return dataStream;
        }

        friend QDataStream& operator>>(QDataStream& dataStream, Vector3d4f& object)
        {
                dataStream >> object.value_0
                           >> object.value_1
                           >> object.value_2
                           >> object.value_3
                           >> object.value_4
                           >> object.value_5
                           >> object.value_6;

                return dataStream;
        }
};

struct Vector4d4f
{
        double value_0;
        double value_1;
        double value_2;
        double value_3;
        float value_4;
        float value_5;
        float value_6;
        float value_7;

        friend QDataStream& operator<<(QDataStream& dataStream, const Vector4d4f& object)
        {
                dataStream << object.value_0
                           << object.value_1
                           << object.value_2
                           << object.value_3
                           << object.value_4
                           << object.value_5
                           << object.value_6
                           << object.value_7;

                return dataStream;
        }

        friend QDataStream& operator>>(QDataStream& dataStream, Vector4d4f& object)
        {
                dataStream >> object.value_0
                           >> object.value_1
                           >> object.value_2
                           >> object.value_3
                           >> object.value_4
                           >> object.value_5
                           >> object.value_6
                           >> object.value_7;

                return dataStream;
        }
};

typedef union {
    Vector16f vec;
    float arr[16];
} Union16f;

typedef union {
    Vector8f vec;
    float arr[8];
} Union8f;

typedef union {
    Vector4f vec;
    float arr[6];
} Union6f;

typedef union {
    Vector4f vec;
    float arr[4];
} Union4f;

typedef union {
    Vector3f vec;
    float arr[3];
} Union3f;

typedef union {
    Vector2f vec;
    float arr[2];
} Union2f;

typedef union {
    Vector3i vec;
    uint32_t arr[3];
} Union3i;

typedef union {
    Vector3c vec;
    uint8_t arr[3];
} Union3c;

typedef union {
    Vector23s vec;
    uint16_t arr[23];
} Union23s;

typedef union {
    Vector30s vec;
    uint16_t arr[30];
} Union30s;

typedef union {
    Vector6d vec;
    double arr[6];
} Union6d;

} // namespace DataStructs
Q_DECLARE_METATYPE(DataStructs::ErrorCode)
Q_DECLARE_METATYPE(DataStructs::Float)
Q_DECLARE_METATYPE(DataStructs::Int)
Q_DECLARE_METATYPE(DataStructs::Double)
Q_DECLARE_METATYPE(DataStructs::Char)
Q_DECLARE_METATYPE(DataStructs::Bool)
Q_DECLARE_METATYPE(DataStructs::Short)
Q_DECLARE_METATYPE(DataStructs::VCUStatus)
Q_DECLARE_METATYPE(DataStructs::Vector16c)
Q_DECLARE_METATYPE(DataStructs::Vector16f)
Q_DECLARE_METATYPE(DataStructs::Vector2c)
Q_DECLARE_METATYPE(DataStructs::Vector2f)
Q_DECLARE_METATYPE(DataStructs::Vector2s)
Q_DECLARE_METATYPE(DataStructs::Vector30s)
Q_DECLARE_METATYPE(DataStructs::Vector2b)
Q_DECLARE_METATYPE(DataStructs::Vector3c)
Q_DECLARE_METATYPE(DataStructs::Vector3f)
Q_DECLARE_METATYPE(DataStructs::Vector3i)
Q_DECLARE_METATYPE(DataStructs::Vector4f)
Q_DECLARE_METATYPE(DataStructs::Vector6f)
Q_DECLARE_METATYPE(DataStructs::Vector8f)


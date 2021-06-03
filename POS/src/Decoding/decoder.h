#ifndef MANAGEDATATYPE_H
#define MANAGEDATATYPE_H

#include "Processing/datastructs.h"
#include <QByteArray>
#include <QMap>
#include <QObject>

static const QMap<quint16, QString> idToName = {
    {0x001, "Speed"},
    {0x002, "Emergency Brake"},
    {0x333, "Velocity"},
    {0x334, "Acceleration"},
    {0x335, "Voltage1"},
    {0x336, "Voltage2"},
    {0x337, "Voltage3"},

    // REAL SECTION:
    {0x124, "Voltages_P1[0-29]"},
    {0x225, "Voltages_P1[30-59]"},
    {0x326, "Voltages_P1[60-89]"},
    {0x427, "Current"},
    {0x528, "Temp_P1[0-22]"},
    {0x629, "Temp_P1[23-44]"},
    {0x72A, "Status"},
    {0x02B, "BMS Safety"},
    {0x138, "Voltages_P2[0-29]"},
    {0x239, "Voltages_P2[30-59]"},
    {0x33A, "Voltages_P2[60-89]"},
    {0x43B, "Temp_P2[0-22]"},
    {0x53C, "Temp_P2[23-44]"},
    {0x63D, "Status"},
    {0x03E, "BMS Safety"},
    {0x074, "Level shifters disabled"},
    {0x275, "Current measurements"},
    {0x09D, "Velocity"},
    {0x676, "Junction Temperature"},
    {0x677, "DC-link measurement"},
    /* ... */
};

static const QMap<quint16, DataType> idToType = {
    {0x001, DataType::INT32},
    {0x002, DataType::UINT32},
    {0x333, DataType::INT32},
    {0x334, DataType::INT32},
    {0x335, DataType::INT32},
    {0x336, DataType::INT32},
    {0x337, DataType::INT32},
    {0x338, DataType::VECTOR_30S},

    // REAL SECTION:
    {0x124, DataType::VECTOR_30S},
    {0x225, DataType::VECTOR_30S},
    {0x326, DataType::VECTOR_30S},
    {0x427, DataType::FLOAT},
    {0x528, DataType::VECTOR_23S},
    {0x629, DataType::VECTOR_23S},
    {0x72A, DataType::BMS_STATUS},
    {0x02B, DataType::BMS_SAFETY},
    {0x138, DataType::VECTOR_30S},
    {0x239, DataType::VECTOR_30S},
    {0x33A, DataType::VECTOR_30S},
    {0x43B, DataType::VECTOR_23S},
    {0x53C, DataType::VECTOR_23S},
    {0x63D, DataType::BMS_STATUS},
    {0x03E, DataType::BMS_SAFETY},
    {0x074, DataType::ERROR_CODE},
    {0x275, DataType::VECTOR_3F},
    {0x09D, DataType::FLOAT},
    {0x676, DataType::FLOAT},
    {0x677, DataType::FLOAT},
    /* ... */
};

class Decoder : public QObject
{
    Q_OBJECT
public:
    Decoder();
    ~Decoder();

public slots:
    void checkData(unsigned int timeMs, unsigned short id, unsigned char dataSize, QByteArray data);

signals:
    void addData(unsigned int timeMs, const QString name, const DataType dataType, QByteArray data);
};

#endif // MANAGEDATATYPE_H

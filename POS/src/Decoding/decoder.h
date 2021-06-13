#ifndef MANAGEDATATYPE_H
#define MANAGEDATATYPE_H

#include "Processing/datastructs.h"
#include <QByteArray>
#include <QMap>
#include <QObject>

static const QMap<quint16, QString> idToName = {
    { 0x124 , "Voltages_P1[0-29]" },
    { 0x225 , "Voltages_P1[30-59]" },
    { 0x326 , "Voltages_P1[60-89]" },
    { 0x427 , "Current" },
    { 0x72A , "BMS_Status_P1"},
    { 0x02B , "BMS_Safety_P1"},
    { 0x528 , "Temp_P1[0-22]" },
    { 0x629 , "Temp_P1[23-44]" },
    { 0x138 , "Voltages_P2[0-29]" },
    { 0x239 , "Voltages_P2[30-59]" },
    { 0x33A , "Voltages_P2[60-89]" },
    { 0x43B , "Temp_P2[0-22]" },
    { 0x53C , "Temp_P2[23-44]" },
    { 0x63D , "BMS_Status_P2"},
    { 0x03E , "BMS_Safety_P2"},
    { 0x074 , "Level shifters disabled" },
    { 0x275 , "Current measurements" },
    { 0x676 , "Junction Temperature" },
    { 0x677 , "DC-link measurement" },

    // !NOTE: THESE NEED PRIORIOTY IN ID
    { 0x9C  , "Temperature" },	
    { 0x9D  , "Velocity" },	
    { 0x9E  , "Temp" },	
    { 0xA0  , "Suite XS Front" },
    { 0xA1  , "Suite XS Front Pos" },
    { 0xB0  , "IMU_PSA"	},
    { 0xB1  , "IMU_YPR"	},
    { 0xB2  , "PE S&P esti." },
    { 0xB3  , "Suite XS Rear" },
    { 0xB4  , "Suite XS Rear Pos" },
    { 0xB5  , "Dist, temp, pres" },		
    { 0x5C4  , "VCU Checklist" },
};

static const QMap<quint16, DataType> idToType = {
    { 0x124 , DataType::VECTOR_30S},
    { 0x225 , DataType::VECTOR_30S},
    { 0x326 , DataType::VECTOR_30S},
    { 0x427 , DataType::FLOAT},
    { 0x72A , DataType::VECTOR_2S},
    { 0x02B , DataType::VECTOR_2B_1S},
    { 0x528 , DataType::VECTOR_23S},
    { 0x629 , DataType::VECTOR_23S},
    { 0x138 , DataType::VECTOR_30S},
    { 0x239 , DataType::VECTOR_30S},
    { 0x33A , DataType::VECTOR_30S},
    { 0x43B , DataType::VECTOR_23S},
    { 0x53C , DataType::VECTOR_23S},
    { 0x63D , DataType::VECTOR_2S},
    { 0x03E , DataType::VECTOR_2B_1S},
    { 0x074 , DataType::ERROR_CODE},
    { 0x275 , DataType::VECTOR_3F},
    { 0x676 , DataType::FLOAT},
    { 0x677 , DataType::FLOAT},

    // !NOTE: THESE NEED PRIORIOTY IN ID
    { 0x9C  , DataType::VECTOR_4D_4F },	
    { 0x9D  , DataType::FLOAT },	
    { 0x9E  , DataType::VECTOR_3C },	
    { 0xA0  , DataType::VECTOR_2C_2D },
    { 0xA1  , DataType::VECTOR_6D },
    { 0xB0	, DataType::VECTOR_3F },  
    { 0xB1	, DataType::VECTOR_3F },
    { 0xB2	, DataType::VECTOR_2F },   
    { 0xB3	, DataType::VECTOR_2C_2D },
    { 0xB4	, DataType::VECTOR_6D },
    { 0xB5	, DataType::VECTOR_3D_4F },
    { 0x5C4  , DataType::VCU_STATUS},

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

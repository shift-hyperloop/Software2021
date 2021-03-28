#ifndef MANAGEDATATYPE_H
#define MANAGEDATATYPE_H

#include <QObject>
#include <QByteArray>
#include <QMap>
#include "Processing/datastructs.h"


static const QMap<quint16, QString> idToName = {
  {0x001, "Speed"},
  {0x002, "Emergency Brake"},
  {0x333, "Velocity"},
  {0x334, "Acceleration"},
  {0x335, "Voltage1"},
  {0x336, "Voltage2"},
  {0x337, "Voltage3"},
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

#ifndef MANAGEDATATYPE_H
#define MANAGEDATATYPE_H

#include <QObject>
#include <QByteArray>
#include <QMap>

#include "cansplitter.h"
#include "../Processing/processingunit.h"

static const QMap<quint16, QString> idToName = {
  {0x001, "Speed"},
  {0x002, "Emergency Brake"},
  /* ... */
};

static const QMap<quint16, DataType> idToType = {
  {0x001, VELOCITY},
  {0x002, ACCELERATION},
  /* ... */
};


class Decoder : public QObject
{
    Q_OBJECT
public:
    Decoder();
    ~Decoder();

public slots:
    void checkData(unsigned short id, unsigned char dataSize, QByteArray data);

signals:
    void addData(const QString name, const DataType dataType, const QVariant data);
};



#endif // MANAGEDATATYPE_H

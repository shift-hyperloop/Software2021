#ifndef MANAGEDATATYPE_H
#define MANAGEDATATYPE_H

#include <QObject>
#include <QMap>
#include <QByteArray>

#include "cansplitter.h"

//all tables and the DataType enum will have to be extended as the library of sensors expand
enum DataTypeDecoder {
    VELOCITY,
    ACCELERATION,
    ACCELERATIONVELOCITY
};


static const QLatin1String ValueNames[]={
    QLatin1String("Speed"),
  //names of all the different id meassurements
};
static const ushort IDTable[] = {
    0x001,
    //list of possible ID's
};
static const QVariant DataTypeTable[] = {
    VELOCITY,
    //Set the datatype in here to convert ids in set order to correct datatype
};

class Decoder : public QObject
{
    Q_OBJECT
public:
    Decoder();
    ~Decoder();

    int dataType;
    QString name;


public slots:
    void checkData(quint16 &id , quint8 &dataSize, QByteArray &data);

signals:
    void addData(const QString name, const DataTypeDecoder dataType, const QVariant data);

};



#endif // MANAGEDATATYPE_H

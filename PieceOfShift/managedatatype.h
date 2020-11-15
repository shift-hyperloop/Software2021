#ifndef MANAGEDATATYPE_H
#define MANAGEDATATYPE_H

#include <QObject>
#include <QMap>
#include <QByteArray>

//#include "canSplitter.h"



static const QLatin1String ValueNames[]={
  //names of all the different id meassurements
};
static const ushort IDTable[] = {
    //list of possible ID's
};
static const qulonglong DataTypeTable[] = {
    //Set the datatype in here to convert ids in set order to correct datatype
};

class Decoder : public QObject
{
    Q_OBJECT
public:
    Decoder();
    ~Decoder();


public slots:
    void newData(quint16, quint8, QByteArray);

private:
    void mapGivenIDandData();
};



#endif // MANAGEDATATYPE_H

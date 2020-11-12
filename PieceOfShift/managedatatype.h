#ifndef FINDDATATYPE_H
#define FINDDATATYPE_H

#include <QObject>
#include <QMap>
#include <QByteArray>

//#include "canSplitter.h"

struct velocityStruct{
    double velocity;
    int time;
};


enum Datatype{
    VELOCITY,
    ACCELERATION,
    ACCELERATIONVELOCITY
};

class ManageDatatype : public QObject
{
    Q_OBJECT
public:
    ManageDatatype();
    ~ManageDatatype();

    void mapGivenIDandData();
public slots:
    void newData(quint16, quint8, QByteArray);
};



#endif // FINDDATATYPE_H
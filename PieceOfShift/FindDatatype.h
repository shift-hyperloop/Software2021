#ifndef FINDDATATYPE_H
#define FINDDATATYPE_H

#include <QObject>
#include <QMap>
//#include "canframes.h"

struct velocityStruct{
    double velocity
    int time
};


enum Datatype{
    VELOCITY,
    ACCELERATION,
    ACCELERATIONVELOCITY
};

class FindDatatype : public QObject
{
    Q_OBJECT
public:
    FindDatatype();
    ~FindDatatype();

    void mapGivenIDandData();
public slots:
    void findData(/*canframes::processReceivedData &frame canframesFrame*/);
};



#endif // FINDDATATYPE_H

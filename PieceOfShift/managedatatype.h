#ifndef MANAGEDATATYPE_H
#define MANAGEDATATYPE_H

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

public slots:
    void newData(quint16, quint8, QByteArray);

private:
    void mapGivenIDandData();
};



#endif // MANAGEDATATYPE_H

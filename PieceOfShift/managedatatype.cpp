#include <QtAlgorithms>
#include <QPair>
#include <QMap>

#include "managedatatype.h"
#include "cansplitter.h"

Decoder::Decoder(){
    newData();
}
Decoder::~Decoder(){
}

void Decoder::newData(){
    ulong Data = CanSplitter::newData::&data;
    connect(ID, &CanSplitter::newData::id, this, Decoder::mapGivenIDandData());
}
void Decoder::mapGivenIDandData(){
    int N = sizeof(IDTable)/sizeof (IDTable[0]);

    const ushort *ID = qBinaryFind(IDTable, IDTable + N,
                                   ID);

    int index = ID-IDTable;
    (DataTypeTable[index])Data;



}

#include <QtAlgorithms>
#include <QPair>
#include <QMap>

#include "managedatatype.h"
#include "cansplitter.h"

// NOTE: This was commented so the project would build
Decoder::Decoder()
{
}
Decoder::~Decoder()
{
}

void Decoder::newData(quint16 &id,quint8 &dataSize, QByteArray &data)
{
    //ulong Data = CanSplitter::newData::&data;
    //int N = sizeof(IDTable)/sizeof (IDTable[0]);

   // const ushort *ID = qBinaryFind(IDTable, IDTable + N,
   //                               id);

   // int index = ID-IDTable;
   // dataType = DataTypeTable[index];
}

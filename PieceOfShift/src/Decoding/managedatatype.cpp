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

void Decoder::checkData(quint16 &id,quint8 &dataSize, QByteArray &data)
{
    //ulong Data = CanSplitter::newData::&data;
    int N = sizeof(IDTable)/sizeof (IDTable[0]);

    const ushort *ID = qBinaryFind(IDTable, IDTable + N,
                                  id);
    //setup name, and find right datatype
    //also resize the data and set it to qvariant
    quint16 index = ID-IDTable;
    name = ValueNames[index];
    DataType dataType = DataType(index);
    data.resize(dataSize);


    //send data onwards to the processor
    emit addData(name, dataType, data);
}

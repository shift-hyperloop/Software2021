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
    //use binary find algorithm to match the id recieved with a named id
    const ushort *ID = qBinaryFind(IDTable, IDTable + N, id);
    //setup name, and find right datatype
    //also resize the data and set it to qvariant
    quint16 index = ID-IDTable;
    //use the identified index to find the linking name
    name = ValueNames[index];
    //cast a datatype based on index
    DataType dataType = DataType(index);
    //resize data, even though this is done in the cansplitter
    //its implimented to make the Qvariant as small as possible
    data.resize(dataSize);


    //send data onwards to the processor
    emit addData(name, dataType, data);
}

#include <QtAlgorithms>
#include <QPair>
#include <QMap>
#include <qdebug.h>

#include "decoder.h"
#include "cansplitter.h"

// NOTE: This was commented so the project would build
Decoder::Decoder()
{
}
Decoder::~Decoder()
{
}

void Decoder::checkData(unsigned short id, unsigned char dataSize, QByteArray data)
{
    DataType dataType = idToType.value(id);
    QString name = idToName.value(id);

    data.resize(dataSize);

    QPair<quint8, QByteArray> dataAndSize(dataSize, data);


    // Send data onwards to the processor
    emit addData(name, dataType, QVariant::fromValue(dataAndSize));
}

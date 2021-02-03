#include <QtAlgorithms>
#include <QPair>
#include <QMap>

#include "decoder.h"
#include "cansplitter.h"

// NOTE: This was commented so the project would build
Decoder::Decoder()
{
}
Decoder::~Decoder()
{
}

void Decoder::checkData(quint16 &id, quint8 &dataSize, QByteArray &data)
{
    DataType dataType = idToType.value(id);
    QString name = idToName.value(id);

    data.resize(dataSize);

    qDebug() << dataType;
    qDebug() << name;

    QPair<quint8, QByteArray> dataAndSize(dataSize, data);


    //send data onwards to the processor
    emit addData(name, dataType, QVariant::fromValue(dataAndSize));
}

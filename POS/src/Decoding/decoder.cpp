#include <QtAlgorithms>
#include <QPair>
#include <QMap>
#include <qdebug.h>
#include "Processing/datastructs.h"
#include "decoder.h"
// NOTE: This was commented so the project would build
Decoder::Decoder()
{
}
Decoder::~Decoder()
{
}

void Decoder::checkData(unsigned int timeMs, unsigned short id, unsigned char dataSize, QByteArray data)
{
    if (!idToType.contains(id)) {
        return;
    }
    DataType dataType = idToType.value(id);
    QString name = idToName.value(id);

    // Send data onwards to the processor
    emit addData(timeMs, name, dataType, data);
}

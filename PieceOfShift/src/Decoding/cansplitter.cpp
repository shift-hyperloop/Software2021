#include <QUdpSocket>
#include <QObject>
#include <QDataStream>
#include <iostream>
#include <qdebug.h>
#include "cansplitter.h"

CanSplitter::CanSplitter()
{
    
}
CanSplitter::~CanSplitter()
{
    delete udpSocket;
}
//function to split data to id datasize and data
void CanSplitter::start()
{
    // Create socket
    udpSocket = new QUdpSocket(this);

    // Connect socket to port and address
    udpSocket->bind(/* NOTE: REPLACE */1234, QUdpSocket::ShareAddress);
    
    // Handle datagram read in handleDatagram function
    connect(udpSocket, &QUdpSocket::readyRead, this, &CanSplitter::handleDatagram);
}

void CanSplitter::handleDatagram()
{
    QByteArray datagram;
    // Loop if multiple datagrams
    while(udpSocket->hasPendingDatagrams()){
        // Resize byte array to fit datagram size
        datagram.resize(int(udpSocket->pendingDatagramSize()));
        // Push received data into datagram
        udpSocket->readDatagram(datagram.data(), datagram.size());

        splitData(datagram);
    }
}

void CanSplitter::splitData(const QByteArray& datagram)
{
    bool ok;
    // Define area of datagram as id, datasize and data
    quint16 id = qFromBigEndian<quint16>(datagram.mid(CAN_ID_OFFSET, CAN_ID_SIZE).toHex().toInt(&ok, 16));
    quint8 dataSize = qFromBigEndian<quint8>(datagram.mid(CAN_DATA_SIZE_OFFSET, CAN_DATA_SIZE_SIZE).toHex().toInt(&ok, 16));
    QByteArray data = datagram.mid(CAN_DATA_OFFSET, CAN_DATA_SIZE_SIZE);

    // Send id, datasize and data as signal onward
    emit dataReceived(id, dataSize, data);
}


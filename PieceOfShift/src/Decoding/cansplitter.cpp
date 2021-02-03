#include <QUdpSocket>
#include <QObject>
#include <QDataStream>
#include <iostream>

#include "cansplitter.h"
//define canSplitter start
//class start function
CanSplitter::CanSplitter()
{
    //create udpsocket
    udpSocket = new QUdpSocket(this);
    //connect socket to port and address
    udpSocket->bind(/*find given port from embedded*/1234, QUdpSocket::ShareAddress);

    //send current, if connection achieved, to new function
    connect(udpSocket, &QUdpSocket::readyRead, this, &CanSplitter::splitDataToMessages);
}
CanSplitter::~CanSplitter()
{
}
//function to split data to id datasize and data
void CanSplitter::splitDataToMessages()
{
    //create datagram
    QByteArray datagram;
    //on pending data update datagram
    while(udpSocket->hasPendingDatagrams()){
        //resize byte array to fit datagram size
        datagram.resize(int(udpSocket->pendingDatagramSize()));
        //push received data into datagram
        udpSocket->readDatagram(datagram.data(), datagram.size());
        bool ok;
        //define area of datagram as id, datasize and data
        quint16 id = qFromBigEndian<quint16>(datagram.mid(CAN_ID_OFFSET, CAN_ID_SIZE).toHex().toInt(&ok, 16));
        quint8 dataSize = qFromBigEndian<quint8>(datagram.mid(CAN_DATA_SIZE_OFFSET, CAN_DATA_SIZE_SIZE).toHex().toInt(&ok, 16));
        QByteArray data = datagram.mid(CAN_DATA_OFFSET, CAN_DATA_SIZE_SIZE);

        //send id, datasize and data as signal onward
        emit checkData(id, dataSize, data);


    }
}


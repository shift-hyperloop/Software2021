#include "canserver.h"
#include <qtcpsocket.h>

CANServer::CANServer()
{

}

CANServer::~CANServer()
{
    delete udpSocket;
}

void CANServer::start()
{
    // Create socket
    udpSocket = new QUdpSocket(this);

    // Connect socket to port and address
    udpSocket->bind(/* NOTE: REPLACE */1234, QUdpSocket::ShareAddress);

    // Handle datagram read in handleDatagram function
    connect(udpSocket, &QUdpSocket::readyRead, this, &CANServer::handleIncoming);
}

void CANServer::handleIncoming()
{
    QByteArray datagram;
    // Loop if multiple datagrams
    while(udpSocket->hasPendingDatagrams()){
        // Resize byte array to fit datagram size
        datagram.resize(int(udpSocket->pendingDatagramSize()));
        // Push received data into datagram
        udpSocket->readDatagram(datagram.data(), datagram.size());

        bool ok;

        // Define area of datagram as id, datasize and data
        quint16 id = qFromBigEndian<quint16>(datagram.mid(CAN_ID_OFFSET, CAN_ID_SIZE).toHex().toInt(&ok, 16));
        quint8 dataSize = qFromBigEndian<quint8>(datagram.mid(CAN_DATA_SIZE_OFFSET, CAN_DATA_SIZE_SIZE).toHex().toInt(&ok, 16));
        QByteArray data = datagram.mid(CAN_DATA_OFFSET, CAN_DATA_SIZE_SIZE);

        // Send id, datasize and data as signal onward
        emit dataReceived(id, dataSize, data);
    }
}

void CANServer::sendPodCommand(const PodCommand& type){
    QByteArray frameID;
    // Call from visualizer for a messageID (int)
    // Using dummy data in switch case
    // TODO change this
    switch(type){
    // MessageID determines which signal to send to the pod
    case PodCommand::EMERGENCY_BRAKE: // emergencyBrake (AA3) -> 2723
        frameID= QByteArray::number(0x2723);
        break;
    case PodCommand::START: // start braking (DA1) -> 3489
        frameID= QByteArray::number(0x3489);
        break;
    case PodCommand::STOP: //  regular braking (DA2) --> 3490
        frameID= QByteArray::number(0x3490);
        break;
    }
    udpSocket->writeDatagram(frameID, QHostAddress::Broadcast, 45454);
}

#include "poddatasender.h"
#include <QtNetwork>
#include <QObject>
#include <QtNetwork>
#include <QtCore>
#include <QUdpSocket>
#include <QDebug>

PodDataSender::PodDataSender()
{
    udpSocket = new QUdpSocket();
}

void PodDataSender::canMessageConvertor(const PodMessageType& type){
    QByteArray frameID;
    // Call from visualizer for a messageID (int)
    // Using dummy data in switch case
    // TODO change this
    switch(type){
    // MessageID determines which signal to send to the pod
    case PodMessageType::EMERGENCY_BRAKE: // emergencyBrake (AA3) -> 2723
        frameID= QByteArray::number(0x2723);
        break;
    case PodMessageType::START: // start braking (DA1) -> 3489
        frameID= QByteArray::number(0x3489);
        break;
    case PodMessageType::STOP: //  regular braking (DA2) --> 3490
        frameID= QByteArray::number(0x3490);
        break;
    }
    udpSocket->writeDatagram(frameID, QHostAddress::Broadcast, 45454);
}

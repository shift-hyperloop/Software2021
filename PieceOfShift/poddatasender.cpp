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
    canMessageConvertor();
}

void PodDataSender::canMessageConvertor(){
    QByteArray frameID;
    // Call from visualizer for a messageID (int)
    // Using dummy data in switch case
    // TODO change this
    switch(1){
    // MessageID determines which signal to send to the pod
    case 1: // emergencyBrake (AA3) -> 2723
        frameID= QByteArray::number(0x2723);
        break;
    case 2: // start braking (DA1) -> 3489
        frameID= QByteArray::number(0x3489);
        break;
    case 3: //  regular braking (DA2) --> 3490
        frameID= QByteArray::number(0x3490);
        break;
    }
    udpSocket->writeDatagram(frameID, QHostAddress::Broadcast, 45454);
}

#include "canserver.h"
#include <QDataStream>
#include <qabstractsocket.h>
#include <qdebug.h>


CANServer::CANServer()
{

}

CANServer::~CANServer()
{
    delete m_TcpSocket;
}

void CANServer::connectToPod(const QString& hostname, const QString& port)
{
    // Create socket if not exists
    if (!m_TcpSocket) {
        m_TcpSocket = new QTcpSocket(this);
        m_TcpSocket->setSocketOption(QAbstractSocket::KeepAliveOption, 1); // Keep socket alive
    }

    connect(m_TcpSocket, SIGNAL(readyRead()), SLOT(handleIncoming()), Qt::UniqueConnection);
    connect(m_TcpSocket, SIGNAL(error(QAbstractSocket::SocketError)), SLOT(connectionError(QAbstractSocket::SocketError)), Qt::UniqueConnection);
    connect(m_TcpSocket, SIGNAL(stateChanged(QAbstractSocket::SocketState)), SLOT(socketStateChanged(QAbstractSocket::SocketState)), Qt::UniqueConnection);
    connect(m_TcpSocket, SIGNAL(disconnected()), SIGNAL(connectionTerminated()), Qt::UniqueConnection);
    connect(m_TcpSocket, SIGNAL(connected()), SIGNAL(connectionEstablished()), Qt::UniqueConnection);

    // Connect socket to port and address if not connected
    if(m_TcpSocket->state() != QAbstractSocket::ConnectedState) {
        m_TcpSocket->connectToHost(hostname, port.toInt(), QIODevice::ReadWrite);
    }

}

void CANServer::handleIncoming()
{
    QByteArray datagram;

    // Loop if multiple datagrams
    while(m_TcpSocket->bytesAvailable()) {

        datagram = m_TcpSocket->readAll();

        bool ok;
        // Define area of datagram as id, datasize and data
        quint16 id = qFromBigEndian<quint16>(datagram.mid(CAN_ID_OFFSET, CAN_ID_SIZE).toHex().toInt(&ok, 16));
        quint8 dataSize = qFromBigEndian<quint8>(datagram.mid(CAN_DATA_SIZE_OFFSET, CAN_DATA_SIZE_SIZE).toHex().toInt(&ok, 16));
        QByteArray data = datagram.mid(CAN_DATA_OFFSET, CAN_DATA_SIZE_SIZE);


        // Send id, datasize and data as signal onward
        emit dataReceived(id, dataSize, data);
    }
}

void CANServer::sendPodCommand(const PodCommand& type)
{
    if (!m_TcpSocket) return;
    
    if (m_TcpSocket->state() != QAbstractSocket::ConnectedState) {
        // NOTE: DO SOMETHING HERE
        return;
    }
    QByteArray frameID;
    // Call from visualizer for a messageID (int)
    // Using dummy data in switch case
    // TODO change this

    switch(type){
    // MessageID determines which signal to send to the pod
    case PodCommand::EMERGENCY_BRAKE: // emergencyBrake (AA3) -> 2723
        frameID= QByteArray::number(0x3C1);
        qDebug("emergency brake pressed");
        break;
    case PodCommand::START: // start braking (DA1) -> 3489
        frameID= QByteArray::number(0x3C2);
        qDebug("start pressed");
        break;
    case PodCommand::STOP: //  regular braking (DA2) --> 3490
        frameID= QByteArray::number(0x0C3);
        break;
    case PodCommand::HIGH_VOLTAGE:
        frameID= QByteArray::number(0x3C3);
        break;
    }
    m_TcpSocket->write(frameID, frameID.length());
}

void CANServer::connectionError(const QAbstractSocket::SocketError& error)
{
    qDebug() << "Error connecting to pod";
    qDebug() << error;
}

void CANServer::socketStateChanged(const QAbstractSocket::SocketState& state)
{
    qDebug() << "Socket state changed!";
    qDebug() << state;
}

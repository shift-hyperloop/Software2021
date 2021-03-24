#ifndef CAN_SERVER_H
#define CAN_SERVER_H

#include <QObject>
#include <QVector>
#include <QtEndian>
#include <QTcpSocket>
#include <qobjectdefs.h>

#define CAN_ID_OFFSET 0
#define CAN_ID_SIZE 2
#define CAN_DATA_SIZE_OFFSET 8
#define CAN_DATA_SIZE_SIZE 1
#define CAN_DATA_OFFSET 12

class CANServer : public QObject
{
    Q_OBJECT

public:
    CANServer();
    ~CANServer();

    void connectToPod(const QString& hostname, const QString& port);

    enum class PodCommand
    {
        EMERGENCY_BRAKE,
        START,
        STOP,
        HIGH_VOLTAGE
    };
    Q_ENUMS(PodCommand)

public slots:
    void handleIncoming();
    void sendPodCommand(const PodCommand& command);

private slots:
    void connectionError(const QAbstractSocket::SocketError& error);
    void socketStateChanged(const QAbstractSocket::SocketState& state);

signals:
    void dataReceived(unsigned short id, unsigned char dataSize, QByteArray data);
    void connectionEstablished();
    void connectionTerminated();

private:
    QTcpSocket* m_TcpSocket = nullptr;

    const QString hostname = "0.0.0.0";
    const int port = 3000;
};
Q_DECLARE_METATYPE(CANServer::PodCommand)

#endif

#ifndef CAN_SERVER_H
#define CAN_SERVER_H

#include <QObject>
#include <QVector>
#include <QtEndian>
#include <QUdpSocket>

#define CAN_ID_OFFSET 0
#define CAN_ID_SIZE 2
#define CAN_DATA_SIZE_OFFSET 8
#define CAN_DATA_SIZE_SIZE 1
#define CAN_DATA_OFFSET 12

enum class PodCommand
{
    EMERGENCY_BRAKE,
    START,
    STOP
};

class CANServer : public QObject
{
    Q_OBJECT
public:
    CANServer();
    ~CANServer();

    void start();

public slots:
    void handleIncoming();
    void sendPodCommand(const PodCommand& command);

signals:
    void dataReceived(unsigned short id, unsigned char dataSize, QByteArray data);

private:
    QUdpSocket *udpSocket = nullptr;
};

#endif
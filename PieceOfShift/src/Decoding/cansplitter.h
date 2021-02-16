#ifndef CANSPLITTER_H
#define CANSPLITTER_H
#include <QObject>
#include <QVector>
#include <QtEndian>
#include <QUdpSocket>

#define CAN_ID_OFFSET 0
#define CAN_ID_SIZE 2
#define CAN_DATA_SIZE_OFFSET 8
#define CAN_DATA_SIZE_SIZE 1
#define CAN_DATA_OFFSET 12


class CanSplitter : public QObject
{
    Q_OBJECT
public:
    CanSplitter();
    ~CanSplitter();


    void start();
    void splitData(const QByteArray& datagram);

//set given slots
public slots:
    void handleDatagram();

signals:
    void dataReceived(unsigned short id, unsigned char dataSize, QByteArray data);

private:

    QUdpSocket *udpSocket = nullptr;
};

#endif // CANSPLITTER_H

#ifndef PODDATASENDER_H
#define PODDATASENDER_H

#include <QObject>
#include <QTimer>
#include <QUdpSocket>

enum class PodMessageType
{
    EMERGENCY_BRAKE,
    START,
    STOP
};

class PodDataSender : public QObject
{
    Q_OBJECT

public:
    PodDataSender();

public slots:
    void canMessageConvertor(const PodMessageType& type);

private:
     QUdpSocket *udpSocket = nullptr;
};


#endif // PODDATASENDER_H

#ifndef PODDATASENDER_H
#define PODDATASENDER_H

#include <QObject>
#include <QTimer>
#include <QUdpSocket>

class PodDataSender : public QObject
{
    Q_OBJECT

public:
    PodDataSender();

public slots:
    void canMessageConvertor();

private:
     QUdpSocket *udpSocket = nullptr;
};


#endif // PODDATASENDER_H

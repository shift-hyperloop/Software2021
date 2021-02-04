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



//create class
class CanSplitter : public QObject
{
    Q_OBJECT
public:
    CanSplitter();
    ~CanSplitter();

    QUdpSocket *udpSocket = nullptr;

    QString frame;

//set given slots
public slots:
    void splitDataToMessages();
signals:
    void checkData(quint16, quint8, QByteArray);

};

#endif // CANSPLITTER_H

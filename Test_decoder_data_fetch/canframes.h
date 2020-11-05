#ifndef CANFRAMES_H
#define CANFRAMES_H

#include <QCanBusDevice>
#include <QCanBus>

class ConnectDialog;

QT_BEGIN_NAMESPACE
class QCanBusFrame;
class QLabel;
class QTimer;
class canframes;
QT_END_NAMESPACE

class canframes
{
public slots:


    void processReceivedFrames();
    void sendFrame(const QCanBusFrame &frame) const;
    void processErrors(QCanBusDevice::CanBusError) const;
    void connectDevice();
    void busStatus();
    void processFramesWritten(qint64);
    void initActionConnections();
    void canFDMessageConvertor(int messageID);
public:
    qint64 c_numberFramesWritten = 0;

    QLabel *c_written=nullptr;
    ConnectDialog *c_connectDialog=nullptr;
    QScopedArrayPointer<QCanBusDevice> c_canDevice;
    QTimer *c_busTimer=nullptr;
    QVector<QString> CanFrameFinished;

};

#endif // CANFRAMES_H

#ifndef CANFRAMES_H
#define CANFRAMES_H

#include <QCanBusDevice>
#include <QCanBus>
#include <QObject>

class ConnectDialog;

QT_BEGIN_NAMESPACE
class QCanBusFrame;
class QLabel;
class QTimer;
class canframes;
QT_END_NAMESPACE

class canframes: public QObject
{
    Q_OBJECT
public:
    canframes();
    ~canframes();
public slots:


    void processReceivedFrames();
    void sendFrame(const QCanBusFrame &frame) const;
    void processErrors(QCanBusDevice::CanBusError) const;
    void connectDevice();
    void busStatus();
public:

    QLabel *c_written=nullptr;
    ConnectDialog *c_connectDialog=nullptr;
    QScopedArrayPointer<QCanBusDevice> c_canDevice;
    QTimer *c_busTimer=nullptr;
    QVector<QString> CanFrameFinished;

};

#endif // CANFRAMES_H

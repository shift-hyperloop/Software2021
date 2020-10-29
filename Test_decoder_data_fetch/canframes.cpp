#include "canframes.h"
#include "connection.h"

#include <QTimer>
#include <QCanBus>
#include <QCanBusDevice>
#include <QDesktopServices>
#include <QCloseEvent>
#include <QtDebug>
#include <QObject>
#include <QVector>

void canframes::processErrors(QCanBusDevice::CanBusError error) const
{
    QString c_status;
    switch (error) {
    case QCanBusDevice::ReadError:
    case QCanBusDevice::WriteError:
    case QCanBusDevice::ConnectionError:
    case QCanBusDevice::ConfigurationError:
    case QCanBusDevice::UnknownError:
        c_status=error;
        qInfo() << c_status;
        break;
    default:
        qInfo() << "Ran";
        break;
    }
}

void canframes::connectDevice()
{
    QString Error_string;

    c_numberFramesWritten = 0;


        if(QCanBus::instance()->plugins().contains(QStringLiteral("systeccan"))){
            QCanBusDevice *device = QCanBus::instance()->createDevice(QStringLiteral("systeccan"), QStringLiteral("can0.0"));
            device->connectDevice();
        }

        else if(!c_canDevice){
            qInfo() << "Sum tin wong";
            c_canDevice.reset();
        }
        else{
            const QVariant bitRate = c_canDevice->configurationParameter(QCanBusDevice::BitRateKey);
            if (bitRate.isValid()) {
                const bool isCanFd =
                        c_canDevice->configurationParameter(QCanBusDevice::CanFdKey).toBool();
                const QVariant dataBitRate =
                        c_canDevice->configurationParameter(QCanBusDevice::DataBitRateKey);
                if (isCanFd && dataBitRate.isValid()) {
                    qInfo() << "Connected";
                } else {
                    qInfo() << "Plugin: connected at unknown kBit/s";
                }
            }
            else {
                qInfo() << "yes. connected";
            }
            if (c_canDevice->hasBusStatus())
                c_busTimer->start(2000);
            else
                qInfo() << "No CAN bus status available.";


        }
 qInfo() << "code has run";
}

static QString frameFlags(const QCanBusFrame &frame)
{
    QString results = QLatin1String("---");

    if(frame.hasBitrateSwitch())
    {
        results[1] = QLatin1Char('B');
    }
    if(frame.hasErrorStateIndicator())
    {
        results[2] = QLatin1Char('E');
    }
    if(frame.hasLocalEcho())
    {
        results[3] = QLatin1Char('L');
    }
    return results;
}

void canframes::processReceivedFrames()
{
    if(!c_canDevice)
    {
        qInfo() << "at least it runs";
        return;
    }
    while(c_canDevice->framesAvailable())
    {
        const QCanBusFrame frame = c_canDevice->readFrame();

        QString frame_strings;
        if (frame.frameType() == QCanBusFrame::ErrorFrame)
        {
         frame_strings = c_canDevice->interpretErrorFrame(frame);
        }
        else
        {
            frame_strings = frame.toString();
        }
        const QString time = QString::fromLatin1("%1.%2 ")
                .arg(frame.timeStamp().seconds(), 10, 10, QLatin1Char(' '))
                .arg(frame.timeStamp().microSeconds() /100, 4, 10, QLatin1Char(0));

        const QString flags = frameFlags(frame);

        CanFrameFinished += time + ',' + flags + ',' + frame_strings + ';';

    }

}

void canframes::busStatus()
{
    if(!c_canDevice || !c_canDevice->hasBusStatus())
    {
        qInfo() << "No Can Bus status available";
        c_busTimer->stop();
        return;
    }
    switch (c_canDevice->busStatus()) {
    case QCanBusDevice::CanBusStatus::Good:
        qInfo() << "Can ok";
        break;
    case QCanBusDevice::CanBusStatus::BusOff:
        qInfo() << "No bus man thing";
        break;
    case QCanBusDevice::CanBusStatus::Error:
        qInfo() << "sum thin wong man";
        break;
    case QCanBusDevice::CanBusStatus::Warning:
        qInfo() << "SQUEEL";
        break;
    default:
        qInfo() << "ran code with 0 errors";
    }
}

nclude "canframes.h"

#include <QTimer>
#include <QCanBus>
#include <QCanBusDevice>
#include <QCanBusDeviceInfo>
#include <QCanBusFrame>
#include <QDebug>

//given function to reconnect when program starts
canframes::canframes(){
    connectDevice();
}
//function to check for the programs error handling
//checks if the program cleanly recieves messages
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
        //c_status can be logged to error messaging
        break;
    default:
        break;
    }
}
//connects the computer/program to the available canbus, should be able to interpret
//canframes as other signals reveiced on the computer
void canframes::connectDevice()
{
    QString Error_string;
    c_canDevice.reset(QCanBus::instance()->createDevice(QStringLiteral("virtualcan"), QStringLiteral("can0"), 0));
    c_canDevice->setConfigurationParameter(QCanBusDevice::CanFdKey, QCanBusFrame::FrameType(QCanBusFrame::DataFrame));

//redirects dataflow to other functions in the class based on the entry data
    connect(c_canDevice.get(), &QCanBusDevice::errorOccurred,
            this, &canframes::processErrors);
    connect(c_canDevice.get(), &QCanBusDevice::framesReceived,
            this, &canframes::processReceivedFrames);


        if(!c_canDevice){
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
                    //her kan bitrate vises
                }
            }
            else {
                processReceivedFrames();
            }


        }
}

//function that reads frames the program has received and writes them as single frame format
//instead of an entire CanBus object
void canframes::processReceivedFrames()
{
    if(!c_canDevice)
    {
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


        CanFrameFinished += time + ',' + frame_strings + ';';

    }
    //sends code struct to next functionality to check for faults with the canbuses frames
    busStatus();

}
//function that gives feedback to what the canBus status is
void canframes::busStatus()
{
    if(!c_canDevice || !c_canDevice->hasBusStatus())
    {
        //insert what to happen if there is no available CanBus
        //This code, inclusive the entire function might not be necessary
        return;
    }
    switch (c_canDevice->busStatus()) {
    case QCanBusDevice::CanBusStatus::Good:
        //nothing has to be done, message about nice data is not needed
        break;
    case QCanBusDevice::CanBusStatus::BusOff:
        //Might be a necessity to give a logged feedback to this case
        //including the rest of the cases with the same logging possibilities
        break;
    case QCanBusDevice::CanBusStatus::Error:
        break;
    case QCanBusDevice::CanBusStatus::Warning:
        break;
    default:
        //probabliy also error messages if code proceedes past good status
        break;
    }
}
//function to send message in canFrame back to pod
//
void canframes::sendFrame(const QCanBusFrame &frame) const{
    if(!c_canDevice){
        return;
    }
    //writes back to self as a debug function
    c_canDevice->writeFrame(frame);
    emit sendFrame(frame);
}

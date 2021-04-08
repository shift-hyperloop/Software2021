import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
Page{

    id: stateIndicationPage
    Button{
        text: "Go back"
        x: window.width * 0.01
        y: 0.05 * window.height
        height: window.height * 0.07
        width: window.width * 0.07
        font.pixelSize: window.height * 0.02
        onClicked: {
           stackView.pop(null);
        }
    }
    property var names : ["Engage High Voltage", "Other Startup Protocol","Start" ]

    Button{
        id:highVoltageButton
        text: "Engage High Voltage"
        height: window.height * 0.11
        width: window.width * 0.35
        font.pixelSize: window.height * 0.05
        x: window.width / 5
        y: window.height / 15 * 3
        onClicked: {
            if(highVoltageStatus.status == 0){
                highVoltageMessage.open()
            }
        }
    }
    MessageDialog {
        id: highVoltageMessage
        title: "High Voltage"
        icon: StandardIcon.Warning
        text: "Are you sure you want to engage high voltage ?"
        standardButtons: StandardButton.Yes | StandardButton.Abort
        onYes: {
            // code for sending command to pod
            highVoltageStatus.status = 2;
        }
    }

    Rectangle{
        id:highVoltageStatus
        height: window.height*0.1
        width: height
        radius: height
        property int status: 0
        color: {
            if(status === 0){
               "red"
            }
            else if(status === 1 ){
               "yellow"
            }
            else{
                "green"
            }

        }

        x: highVoltageButton.x + window.width * 0.35 + window.width * 0.1
        anchors.verticalCenter: highVoltageButton.verticalCenter

        border.width: window.height*0.005

    }
    Text{
        id:highVoltageStatusText
        x: highVoltageStatus.x+ window.width * 0.1
        anchors.verticalCenter: highVoltageStatus.verticalCenter
        text: {
            if(highVoltageStatus.status === 0){
               "Disengaged"
            }
            else if(highVoltageStatus.status === 1 ){
               "Pending response"
            }
            else{
                "Engaged"
            }
        }
        font.pixelSize: window.height * 0.02
        color: "white"
    }

    Button{
        id:startUpProtocolButton
        text: "Other Startup Protocol"
        height: window.height * 0.11
        width: window.width * 0.35
        font.pixelSize: window.height * 0.05
        x: window.width / 5
        y: window.height / 15 * 6
        onClicked: {
            if(startupProtocolStatus.status == 0){
                startUpProtocolMessage.open()
            }
        }
    }
    MessageDialog {
        id: startUpProtocolMessage
        title: "Other Startup Protocol"
        icon: StandardIcon.Warning
        text: "Are you sure you want to do the other statup protocol ?"
        standardButtons: StandardButton.Yes | StandardButton.Abort
        onYes: {
            // code for sending command to pod
            startupProtocolStatus.status = 2;
        }
    }

    Rectangle{
        id:startupProtocolStatus
        height: window.height*0.1
        width: height
        radius: height
        property int status: 0
        color: {
            if(status === 0){
               "red"
            }
            else if(status === 1 ){
               "yellow"
            }
            else{
                "green"
            }

        }
        anchors.horizontalCenter: highVoltageStatus.horizontalCenter
        anchors.verticalCenter: startUpProtocolButton.verticalCenter

        border.width: window.height*0.005

    }


    Text{
        id:startupProtocolStatusText
        anchors.horizontalCenter: highVoltageStatusText.horizontalCenter
        anchors.verticalCenter: startUpProtocolButton.verticalCenter
        text: {
            if(startupProtocolStatus.status === 0){
               "Disengaged"
            }
            else if(startupProtocolStatus.status === 1 ){
               "Pending response"
            }
            else{
                "Engaged"
            }
        }
        font.pixelSize: window.height * 0.02
        color: "white"
    }
    Button{
        id:startButton
        text: "Start"
        height: window.height * 0.11
        width: window.width * 0.35
        font.pixelSize: window.height * 0.05
        x: window.width / 5
        y: window.height / 15 * 9
        onClicked: {
            if(startStatus.status == 0){
                startMessage.open()
            }
        }
    }
    MessageDialog {
        id: startMessage
        title: "Start"
        icon: StandardIcon.Warning
        text: "Are you sure you want to start the pod ?"
        standardButtons: StandardButton.Yes | StandardButton.Abort
        onYes: {
            // code for sending command to pod
            startStatus.status = 2;
        }
    }

    Rectangle{
        id:startStatus
        height: window.height*0.1
        width: height
        radius: height
        property int status: 0
        color: {
            if(status === 0){
               "red"
            }
            else if(status === 1 ){
               "yellow"
            }
            else{
                "green"
            }

        }
        anchors.horizontalCenter: highVoltageStatus.horizontalCenter
        anchors.verticalCenter: startButton.verticalCenter

        border.width: window.height*0.005

    }

    Text{
        id:startStatusText
        anchors.horizontalCenter: highVoltageStatusText.horizontalCenter
        anchors.verticalCenter: startStatus.verticalCenter
        text: {
            if(startStatus.status === 0){
               "Disengaged"
            }
            else if(startStatus.status === 1 ){
               "Pending response"
            }
            else{
                "Engaged"
            }
        }
        font.pixelSize: window.height * 0.02
        color: "white"
    }

}

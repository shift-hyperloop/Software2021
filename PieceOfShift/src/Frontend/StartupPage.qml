import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
Page{
    id: stateIndicationPage
    property var passwordAccepted: false
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
            if(highVoltageStatus.status == 0 && passwordAccepted){
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
            // also need some backend verification, so that you cant press start before engage high voltage
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
            if(startupProtocolStatus.status == 0 && passwordAccepted){
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
            if(startStatus.status == 0 && passwordAccepted){
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

    Rectangle{
        color: "lightgray"
        id: authorization
        width: passwordInput.width
        height: passwordInput.height
        border.width: 1

        anchors.left: passwordLabel.right
        anchors.top: startButton.bottom
        anchors.topMargin: height
        TextInput {
            id: passwordInput
            padding: 5
            bottomPadding: 0
            selectByMouse : true
            height: window.height / 25
            width: window.width / 7
            font.pixelSize: window.height / 30
            echoMode: TextInput.Password
        }
        MouseArea{
            cursorShape: authorization.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor;
            enabled: false
            anchors.fill: parent
        }
    }
    Text{
        id: passwordLabel
        text: "Password for authorizating button use: "
        color: "white"
        anchors.left: startButton.left
        anchors.top: authorization.top
        font.pixelSize: passwordInput.font.pixelSize
    }
    Button{
        anchors.left: authorization.right
        anchors.leftMargin: window.width * 0.01
        anchors.verticalCenter: passwordLabel.verticalCenter
        text: "validate"
        font.pixelSize: window.height / 30
        onClicked: {
            if(passwordInput.text == "ElonMusk"){ //replace with better password validation
                passwordAccepted = true;
                passwordAcceptedText.visible = true
                passwordAcceptedText.text = "Password Accepted"
                passwordAcceptedText.color = "green"

            }
            else{
                passwordAcceptedText.visible = true
                passwordAcceptedText.text = "Incorrect password"
                passwordAcceptedText.color = "red"
            }

          passwordInput.clear()
        }
    }
    Text {
        id: passwordAcceptedText
        visible: false
        anchors.left: passwordLabel.left
        anchors.top: passwordLabel.bottom
    }

}

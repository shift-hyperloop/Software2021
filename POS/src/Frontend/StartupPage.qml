import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import shift.datamanagement 1.0

Page{ 
    DataManagerAccessor {
        id: dataManager
    }
    
    //Password for activating buttons is "ElonMusk"
    //if the user has written the correct password, the buttons can be pressed. the buttons opens a MessageDialog that makes you confirm your choice.
    //code for sending information to the pod should therefore be written in the onYes{} function of the buttons corresponding MessageDialog
    id: stateIndicationPage
    property var passwordAccepted: false // this should be stored somewhere else since now it resets when the page is opened
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

    Button{ //there is probably a more efficient way to do this with a repeater, but this way it is simpler to give the buttons and MessageDialogs their onclicked functions
        id:highVoltageButton
        text: "Engage High Voltage"
        height: window.height * 0.08
        width: window.width * 0.23
        font.pixelSize: window.height * 0.03
        x: window.width / 10
        y: window.height / 15 * 3
        onClicked: {
            if (highVoltageStatus.status == 0 && passwordAccepted){
                highVoltageMessage.open();
            }
            else {
                requirePasswordMessage.open();
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
            // code for sending command to pod should go here
            // also need some backend verification, so that you cant press "start" before "engage high voltage"
            dataManager.dataManager.sendPodCommand(PodCommand.HIGH_VOLTAGE);
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

        x: highVoltageButton.x + highVoltageButton.width + window.width * 0.05
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
        height: highVoltageButton.height
        width: highVoltageButton.width
        font.pixelSize: highVoltageButton.font.pixelSize
        x: highVoltageButton.x
        y: window.height / 15 * 6
        onClicked: {
            if(startupProtocolStatus.status == 0 && passwordAccepted){
                startUpProtocolMessage.open();
            }
            else {
                requirePasswordMessage.open();
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
            // code for sending command to pod should go here
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
        height: highVoltageButton.height
        width: highVoltageButton.width
        font.pixelSize: highVoltageButton.font.pixelSize
        x: highVoltageButton.x
        y: window.height / 15 * 9
        onClicked: {
            if(startStatus.status == 0 && passwordAccepted){
                startMessage.open();
            }
            else {
                requirePasswordMessage.open();
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
            // code for sending command to pod should go here
            dataManager.dataManager.sendPodCommand(PodCommand.START);
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

    MessageDialog {
        id: requirePasswordMessage
        title: "Unauthorized Access"
        icon: StandardIcon.Warning
        text: "Enter password to unlock startup"
        standardButtons: StandardButton.Ok
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
        font.pixelSize: window.height / 40
        onClicked: {
            if(passwordInput.text == "ElonMusk"){ //replace with better password validation ?
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
    ValueTable{
        id: valueTable
        names: ["Voltage 1","Voltage 2", "Voltage 3", "Voltage 4", "Temperature 1", "Temperature 2", "Current 1", "Current 2"] // names for the values in the table
        values: [0,0,0,0,0,0,0,0] // values for the table
        anchors {                                   // indexes in names[] and values[] are corresponding
            top: highVoltageButton.top
            //topMargin: 0.09 * window.height
            right: parent.right
            rightMargin: 0.03*window.width
        }
        width: window.width / 3.5
        height: width * 4/5
    }
}

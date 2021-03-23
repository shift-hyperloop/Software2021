import QtQuick 2.0
import shift.datamanagement 1.0
import QtQuick.Controls 2.15

Item {
    id: networkinfo
    property bool connected: true
    property int ping: 0
    property int connectionStrength: 0 //number between 0 and 4 that shows how many bars in SignalSymbol are filled
    width: 300
    height: window.height * 0.05
    Component.onCompleted: {
        connected = false;
    }

    DataManagerAccessor {
        id: dm

        dataManager.onPodConnectionEstablished: {
            connected = true;
            connectedDialog.open();
        }

        dataManager.onPodConnectionTerminated: {
            connected = false;
            terminatedDialog.open();
        }
    }

    Dialog {
        id: connectedDialog
        title: "Connection Established"
        x: -800
        y: 500
        standardButtons: Dialog.Ok
    }

    Dialog {
        id: terminatedDialog
        title: "Connection was terminated!"
        x: -800
        y: 500
        standardButtons: Dialog.Ok
    }

    Text {
        id: networktext
        height: parent.height
        text: connected ? qsTr("Connected")  : qsTr("Not connected")
        color: connected ? "#3feb67" : "#f54838"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        font.pixelSize: window.width/110
        anchors.right: signalSymbol.left
        anchors.rightMargin: 10
    }

    SignalSymbol{
        id: signalSymbol
        height: networkinfo.height - 10
        width: height
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        z : 2
        connection: connectionStrength // 0 - 4
    }
}

import QtQuick 2.0

Item {
    id: networkinfo
    property bool connected: true
    property int ping: 0
    width: 300
    height: networktext.font.pixelSize + 10
    Component.onCompleted: {
        connected = false;
    }

    Text {
        id: networktext
        height: parent.height
        text: connected ? qsTr("Connected") + " Ping:" + ping  : qsTr("Not connected")
        color: connected ? "#3feb67" : "#f54838"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        font.pixelSize: 16
        anchors.right: parent.right
        anchors.rightMargin: 10
    }
}

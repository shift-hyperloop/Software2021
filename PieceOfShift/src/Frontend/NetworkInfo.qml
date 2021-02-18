import QtQuick 2.0

Item {
    property bool connected: false
    width: 300
    height: networktext.font.pixelSize + 10
    Text {
        id: networktext
        height: parent.height
        text: connected ? qsTr("Connected") : qsTr("Not connected")
        color: connected ? "#3feb67" : "#f54838"
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 16
    }
}

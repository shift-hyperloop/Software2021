import QtQuick 2.0
import shift.datamanagement 1.0
import QtQuick.Controls 2.15

Item {
    id: podstate
    property variant allStates: ["Standby", "Engaged", "Braking", "Emergency Brake", "Startup Error"]
    property int currentState: 0
    width: 200
    height: window.height * 0.05

    Text {
        id: stateText
        height: parent.height
        text: qsTr("Pod: ") + allStates[currentState]
        color: "#3feb67"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: window.width / 100
        anchors.top: parent.top
        anchors.topMargin: 2
    }
}

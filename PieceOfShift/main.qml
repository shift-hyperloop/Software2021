import QtQuick 2.12
import QtQuick.Controls 2.5
import shift.datamanagement 1.0

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("PieceOfShift")

    DataManager {
        id: manager
        onVelocityChanged: {

        }
    }

    Text {
        id: labelText
    }

    Button {
        text: "Start"
        onClicked: {
            manager.start()
        }
    }

    Timer {
        id: timer
        interval: 500; running: true; repeat: true
        onTriggered: {
        }
    }
}

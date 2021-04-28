import QtQuick 2.0
import QtQuick.Controls 2.15

Item {

    property alias x_choord: rect1.x
    property alias y_choord: rect1.y
    property alias rightAnchor: rect1.right
    property alias width_: rect1.width
    property alias height_: rect1.height

    Rectangle {
        id: rect1
        width: time.width + 5
        height: time.height
        opacity: 0.8
        color: window.color
        border.color: "#2CFFF4"

        MouseArea {
            anchors.fill: parent
            onClicked: stackView.push("PreviewPage.qml")
            hoverEnabled: true
            onHoveredChanged: containsMouse ? rect1.opacity = 1.0 : rect1.opacity = 0.8;
            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
        }

        Label {
            id: label1
            anchors.centerIn: parent
            Timer {
                interval: 500; running: true; repeat: true
                onTriggered: time.text = Date().toString()
            }

            Text {
                id: time
                anchors.centerIn: parent
                color: "white"
                text: ""
            }
        }
    }
}


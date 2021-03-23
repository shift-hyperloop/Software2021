import QtQuick 2.14
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.2

Item {
    id: item1
    opacity: 1

    property alias minValue: thermometer.minimumValue
    property alias maxValue: thermometer.maximumValue
    property alias value: thermometer.value
    property alias style: thermometer.style



    Rectangle {
        id: rectangle1
        y: parent.height * 0.87
        width: thermometer.width / 2.5
        height: width
        color: "#cacaca"
        radius: 100
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.1
    }

    Gauge {
        MouseArea{
            id: chartMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
            onClicked: {
                stackView.push("DetailedBatteryPage.qml")
            }
        }
        id: thermometer
        x: 0
        y: 0
        font.pixelSize: 0.04 * thermometer.height
        value: 30
        height: parent.height * 0.95
        width: parent.width
        tickmarkStepSize: thermometer.maximumValue / 10
        style: GaugeStyle {
            valueBar: Rectangle {
                implicitWidth: thermometer.width / 4
                radius: thermometer.width / 8
                //change color of bar with value B)
                //change to #c11c1c if color changing is removed
                color: Qt.rgba((thermometer.value / thermometer.maximumValue) * 0.5 + 0.5, 0, (0.5 - (thermometer.value / thermometer.maximumValue) * 0.5), 1)
            }
            background: Rectangle {
                radius: thermometer.width / 8
            }
            foreground: null
            tickmark: Item {
                implicitWidth: parent.width / 15
                implicitHeight: implicitWidth / 5

                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "#ededed"
                }
            }
        }
        Behavior on value {
            NumberAnimation{
                duration: 100
            }
        }
    }
    //the circle at the bottom
    Rectangle {
        id: rectangle
        width: rectangle1.width * 0.8
        height: rectangle1.height * 0.8
        color: Qt.rgba((thermometer.value / thermometer.maximumValue) * 0.5 + 0.5, 0, (0.5 - (thermometer.value / thermometer.maximumValue) * 0.5), 1)
        radius: 100
        anchors.verticalCenter: rectangle1.verticalCenter
        anchors.horizontalCenter: rectangle1.horizontalCenter
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:6}
}
##^##*/

import QtQuick 2.14
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.2

Item {
    width: 55
    height: 310
    opacity: 1

    property alias minValue: thermometer.minimumValue
    property alias maxValue: thermometer.maximumValue
    property alias value: thermometer.value
    property alias style: thermometer.style



    Rectangle {
        id: rectangle1
        x: 20
        y: 279
        width: 30
        height: 30
        color: "#cacaca"
        radius: 100

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
        font.pixelSize: 12
        value: 30

        height: 300
        width: 48
        tickmarkStepSize: thermometer.maximumValue / 10
        style: GaugeStyle {
            valueBar: Rectangle {
                implicitWidth: 16
                radius: 8
                //change color of bar with value B)
                //change to #c11c1c if color changing is removed
                color: Qt.rgba((thermometer.value / thermometer.maximumValue) * 0.5 + 0.5, 0, (0.5 - (thermometer.value / thermometer.maximumValue) * 0.5), 1)
            }
            background: Rectangle {
                implicitWidth: 16
                radius: 8
            }
            foreground: null
            tickmarkLabel: Text
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
    D{i:0;formeditorZoom:2}
}
##^##*/

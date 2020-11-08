import QtQuick 2.14
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.2

Item {
    width: 55
    height: 195

    property alias minValue: thermometer.minimumValue
    property alias maxValue: thermometer.maximumValue
    property alias value: thermometer.value
    property alias style: thermometer.style

    Rectangle {
        id: rectangle1
        x: thermometer.width / 2
        y: 161
        width: 26
        height: 26
        color: "#cacaca"
        radius: 100
    }

    Gauge {
        value: 30
        id: thermometer
        tickmarkStepSize: thermometer.maximumValue / 10
        style: GaugeStyle {
            valueBar: Rectangle {
                implicitWidth: 12
                radius: 6
                //change color of bar with value B)
                //change to #c11c1c if color changing is removed
                color: Qt.rgba((thermometer.value / thermometer.maximumValue) * 0.5 + 0.5, 0, (0.5 - (thermometer.value / thermometer.maximumValue) * 0.5), 1)
            }
            background: Rectangle {
                implicitWidth: 12
                radius: 6
            }
        }
        Behavior on value {
            NumberAnimation{
                duration: 100
            }
        }
    }
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
    D{i:0;formeditorZoom:10}
}
##^##*/

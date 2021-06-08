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
    property var measuredTemp: "0"

    //Rectangle {
    //    id: rectangle1
    //    y: parent.height * 0.88
    //    width: thermometer.width / 2.5
    //    height: width
    //    color: "#cacaca"
    //    radius: 100
    //    anchors.right: parent.right
    //    anchors.rightMargin: thermometer.width * 0.41 - thermometer.width * (maxValue / 950)
    //}

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
        font.pixelSize: 0.04 * thermometer.height
        value: 0
        height: parent.height * 0.95
        width: parent.width
        tickmarkStepSize: thermometer.maximumValue / 10
        style: GaugeStyle {
            valueBar: Rectangle {
                implicitWidth: thermometer.width / 4
                radius: thermometer.width / 8
                //change color of bar with value B)
                //change to #c11c1c if color changing is removed
                color: Qt.rgba((thermometer.value / thermometer.maximumValue) + 0.15, 0, (0.5 - (thermometer.value / thermometer.maximumValue) * 0.5), 1)

                //following code changes gradient to be more akin to infrared cameras.
                //property var r: (thermometer.value) / (thermometer.maximumValue)
                //color: Qt.rgba(r,  0.8 - ((Math.abs(r - 0.5) / 0.5)), 1 - r)
            }
            background: Rectangle {
                radius: thermometer.width / 8
            }
            foreground: null
        }
        Behavior on value {
            NumberAnimation{
                duration: 100
            }
        }
    }
    //the circle at the bottom
    //Rectangle {
    //    id: rectangle
    //    width: rectangle1.width * 0.8
    //    height: rectangle1.height * 0.8
    //    color: Qt.rgba((thermometer.value / thermometer.maximumValue) + 0.15, 0, (0.5 - (thermometer.value / thermometer.maximumValue) * 0.5), 1)
    //    radius: 100
    //    anchors.verticalCenter: rectangle1.verticalCenter
    //    anchors.horizontalCenter: rectangle1.horizontalCenter
//
    //}

    Text {
        id: tempNumber
        color: "#ededed"
        text: qsTr(Math.round(thermometer.value) + "°C")
        horizontalAlignment: Text.AlignHCenter
        anchors {
            horizontalCenter: thermometer.horizontalCenter
            top: parent.bottom
        }
        styleColor: "#ededed"
        font.pixelSize: window.width / 90
        font.bold: true
    }
    Text {
        id: tempName
        color: "#ededed"
        text: measuredTemp
        horizontalAlignment: Text.AlignHCenter
        anchors {
            bottom: parent.top
            right: parent.right
            rightMargin: thermometer.width * 0.5
        }
        styleColor: "#ededed"
        font.pixelSize: window.width / 110
        font.bold: true
    }

}



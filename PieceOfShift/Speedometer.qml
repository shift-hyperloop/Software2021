import QtQuick 2.0
import QtQuick.Extras 1.4
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
Item {
    id: speedometer

    property alias minValue: circulargauge.minimumValue
    property alias maxValue: circulargauge.maximumValue
    property alias value: circulargauge.value
    property alias style: circulargauge.style
    property alias speedometerWidth: circulargauge.width
    property alias speedometerHeight: circulargauge.height


    width: 208
    height: 290
    x: 0
    y: 0

    CircularGauge{
        id: circulargauge
        x: 0
        y: 0
        minimumValue: 0
        maximumValue: 500
        stepSize: 1
        style: CircularGaugeStyle {

            labelStepSize: 100
            tickmarkStepSize: 50
            needle: Rectangle {
                width: outerRadius * 0.03
                height: outerRadius * 0.9
                antialiasing: false
                color: "#0099ff"
            }
            foreground: Rectangle {
                width: outerRadius * 0.1
                height: width
                radius: width / 2
                color: "#ededed"
                anchors.centerIn: parent
            }
            //change the color and style of text, plus make it red at high values
            tickmarkLabel: Text {
                font.pixelSize: outerRadius * 0.13
                text: styleData.value
                color: styleData.value >= (Math.round(circulargauge.maximumValue * 0.008) * 100) ? "#e34c22" : "#ededed"
                antialiasing: false
            }
            tickmark: Rectangle {
                width: outerRadius * 0.02
                height: outerRadius * 0.06
                color: styleData.value >= (Math.round(circulargauge.maximumValue * 0.008) * 100) ? "#e34c22" : "#ededed"
                antialiasing: false
            }
            minorTickmark: Rectangle {
                width: outerRadius * 0.01
                height: outerRadius * 0.03
                color: styleData.value >= (Math.round(circulargauge.maximumValue * 0.008) * 100) ? "#e34c22" : "#ededed"
                antialiasing: false
            }
        }

        Behavior on value {
            NumberAnimation {
                duration: 200
            }
        }

    }

    Text {
        id: speedometerValueText
        x: circulargauge.scale * circulargauge.x + 126
        y: circulargauge.scale * circulargauge.y + 249
        color: "#ededed"
        text: qsTr(circulargauge.value + "km/h")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 18
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenterOffset: 99
        anchors.horizontalCenterOffset: 1
        anchors.horizontalCenter: circulargauge.horizontalCenter
        styleColor: "#ededed"
        minimumPointSize: 18
        minimumPixelSize: 18
        font.family: "Arial"
    }
}

import QtQuick 2.0
import QtQuick.Extras 1.4
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
Item {
    id: speedometer

    property alias minValue: circulargauge.minimumValue
    property alias maxValue: circulargauge.maximumValue
    property alias value: circulargauge.value
    property var accentColor: "#0099ff"
    property var redirect: ""
    property var primaryUnit: " km/h"
    property var secondaryUnit: " m/s"
    property var secondaryTextVisible: true

    CircularGauge{
        id: circulargauge
        minimumValue: 0
        maximumValue: 600
        stepSize: 1
        anchors.fill: parent
        style: CircularGaugeStyle {
            property var labelStep: 10**Math.floor(Math.log(circulargauge.maximumValue - 10) / Math.log(10))
            labelStepSize: labelStep
            tickmarkStepSize: labelStep / 2
            needle: Rectangle {
                implicitWidth: outerRadius * 0.03
                implicitHeight: outerRadius * 0.9
                antialiasing: true
                color: accentColor
            }
            foreground: Rectangle {
                width: circulargauge.width * 0.1
                height: width
                radius: Math.round(width / 2)
                //circle sometimes fills entire component, to be fixed. TODO: find out why it happens. For now, the circle in the middle is invisible
                color: "#00ededed"
                anchors.centerIn: parent
            }
            //change the color and style of text, plus make it red at high values
            tickmarkLabel: Text {
                font.pixelSize: outerRadius * 0.13
                text: styleData.value
                color: styleData.value >= (Math.ceil(circulargauge.maximumValue * 0.8 / labelStep) * labelStep) ? "#e34c22" : "#ededed"
                antialiasing: true
            }
            tickmark: Rectangle {
                implicitWidth: outerRadius * 0.02
                antialiasing: true
                implicitHeight: outerRadius * 0.06
                color: styleData.value >= (Math.ceil(circulargauge.maximumValue * 0.8 / labelStep) * labelStep) ? "#e34c22" : "#ededed"
            }
            minorTickmark: Rectangle {
                implicitWidth: outerRadius * 0.01
                antialiasing: true
                implicitHeight: outerRadius * 0.03
                color: styleData.value >= (Math.ceil(circulargauge.maximumValue * 0.8 / labelStep) * labelStep) ? "#e34c22" : "#ededed"
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
        text: qsTr(circulargauge.value + primaryUnit)
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenterOffset: 90
        anchors.horizontalCenter: circulargauge.horizontalCenter
        styleColor: "#ededed"
        font.pixelSize: window.width / 90
        font.bold: true
    }
    Text {
        opacity: secondaryTextVisible ? 1 : 0
        id: speedometerValueTextSecondary
        x: circulargauge.scale * circulargauge.x + 126
        y: circulargauge.scale * circulargauge.y + 249
        color: "#ededed"
        text: qsTr(Math.round(circulargauge.value / 3.6) + secondaryUnit)
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenterOffset: 115
        anchors.horizontalCenter: circulargauge.horizontalCenter
        styleColor: "#ededed"
        font.pixelSize: window.width / 110
        font.bold: false
    }
    MouseArea{
        id: chartMouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
        enabled: redirect !== ""; // if redirect is set, the graph will redirect to the redirect variable which will be a qml page
        onClicked: {
            stackView.push(redirect);
        }
    }
}

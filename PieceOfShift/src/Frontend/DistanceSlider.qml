import QtQuick 2.15
import QtQuick.Controls 2.5

Item {
    property alias minValue: slider.from
    property alias maxValue: slider.to
    property alias value: slider.value
    width: slider.width
    height: slider.height
    Slider {
        id: slider
        width: 0.95 * window.width
        height: 0.08 * window.height
        font.pointSize: 14
        hoverEnabled: false
        enabled: false
        live: true
        snapMode: Slider.NoSnap
        value: 0

        Behavior on value {
            NumberAnimation {
                 duration: 200
            }
         }

         background: Rectangle {
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
           // implicitWidth: 200
            implicitHeight: 4
            width: slider.availableWidth
            height: implicitHeight
            radius: 2
            color: "#999999"
        }
/*
        handle: Rectangle {
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitWidth: 26
            implicitHeight: 26
            radius: 13
            color: "#0099ff"
        }
*/
        handle: Image {
            source: "../Pod.png"
            width: 150
            fillMode: Image.PreserveAspectFit
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth) - width / 2
            y: slider.topPadding + slider.availableHeight / 2 - height / 1.5
        }
    }
    //creates tickmarks and tick labels
    Repeater{
        id: tickrepeater
        model: 11
        Rectangle {
            id: tick
            width: 3
            height: width * 4
            x: slider.x * 1.1 + ((slider.width * 0.99) * (index / (tickrepeater.model - 1)))
            y: slider.y + slider.height / 1.95
            color: "#ededed"
            Text {
                id: ticktext
                text: window.width < 400  ? slider.to * index / 10: slider.to * index / 10 + qsTr(" km")
                x: -t_metrics.width / 2
                y: 10
                font.pointSize: 12
                color: "#ededed"
            }
            TextMetrics {
                    id: t_metrics
                    font: ticktext.font
                    text: ticktext.text
                }
        }

    }
}



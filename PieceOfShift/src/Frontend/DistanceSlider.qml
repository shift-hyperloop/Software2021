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
            //implicitWidth: slider.height
            implicitHeight: 6
            width: slider.availableWidth
            height: implicitHeight
            radius: 0
            color: "#ededed"
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
            width: slider.width / 10
            fillMode: Image.PreserveAspectFit
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth) - width / 2
            y: slider.topPadding + slider.availableHeight / 2 - height / 1.5
        }
    }
    //alternative method for tickmarks, creates 10 tickmarks evenly
    /*
    Repeater{
            id: tickrepeater
            model: 11
            Rectangle {
                id: tick
                width: 3
                height: width * 4
                x: (slider.width - 15) * (index / (tickrepeater.model - 1)) + 6
                y: slider.y + slider.height / 1.95
                color: "#ededed"
                Text {
                    id: ticktext
                    text: window.width < 400  ? slider.to * index / 10: slider.to * index / 10 + qsTr(" m")
                    x: -t_metrics.width / 2
                    y: 10
                    font.pointSize: 12
                }
                TextMetrics {
                        id: t_metrics
                        font: ticktext.font
                        text: ticktext.text
                }
            }
        }*/
    //creates tickmarks and tick labels, every 10th meter
    Repeater{
        id: tickrepeater
        model: Math.round(slider.to / 10)
        Rectangle {
            id: tick
            width: 3
            height: width * 4
            x: 6 + (((slider.width - 15) / 168) * index * 10)
            y: slider.y + slider.height / 1.95
            color: "#ededed"
            Text {
                id: ticktext
                text: window.width < 400  ? 10 * index: 10 * index + qsTr(" m")
                x: -t_metrics.width / 2
                y: 10
                font.pixelSize: window.width / 110
                color: "#ededed"
                style: Text.Outline
                styleColor: "transparent"
            }
            TextMetrics {
                    id: t_metrics
                    font: ticktext.font
                    text: ticktext.text
            }
        }
    }
    //creates the last tickmark
    Rectangle {
        id: endTick
        width: 3
        height: width * 4
        x: 6 + (slider.width - 15)
        y: slider.y + slider.height / 1.95
        color: "#ededed"
        Text {
            id: endticktext
            text: window.width < 400  ? slider.to : slider.to + qsTr(" m")
            x: -endt_metrics.width / 2
            y: 10
            font.pixelSize: window.width / 110
            color: "#ededed"
            style: Text.Outline
            styleColor: "transparent"
        }
        TextMetrics {
                id: endt_metrics
                font: endticktext.font
                text: endticktext.text
        }
    }
    //creates ticks for the checkmarks marked in the actual tunnel, with 15m spacing. Change 15 to something else for other tunnels, etc.
    //ticks turn green when distance > ticks distance.
    //TODO: Add an array that shows which checkmarks have been passed, turn tick green if chechmark has been passed
    Repeater {
        id: checkmarkRepeater
        model: Math.round(slider.to / 15) + 1
        Rectangle {
            id: checkmark
            width: 3
            height: width * 4
            x: 6 + (((slider.width - 15) / 168) * index * 15)
            //x: (slider.width - 15) * (index / (checkmarkRepeater.model - 1)) + 6
            y: slider.y + slider.height / 1.95 - 15
            color: slider.value > 15 * index ? "#12aa34" : "#ededed"
            Text {
                id: checkText
                text: window.width < 400  ? 15 * index: 15 * index + qsTr(" m")
                x: -t_metrics2.width / 2
                y: -15
                font.pixelSize: window.width / 140
                color: "#ededed"
                style: Text.Outline
                styleColor: "transparent"
            }
            TextMetrics {
                    id: t_metrics2
                    font: checkText.font
                    text: checkText.text
            }
        }
    }
}



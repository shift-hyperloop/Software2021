import QtQuick 2.0
import QtQuick.Controls 2.5

Item {
    property alias minValue: slider.from
    property alias maxValue: slider.to
    property alias value: slider.value
    width: 1280
    height: 720
    Slider {
        id: slider
        x: 28
        y: 594
        width: 1224
        height: 98
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
            implicitWidth: 200
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
        }*/
        handle: Image {
            source: "assets/images/Pod.png"
            width: 150
            fillMode: Image.PreserveAspectFit
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 1.5
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.33000001311302185}
}
##^##*/

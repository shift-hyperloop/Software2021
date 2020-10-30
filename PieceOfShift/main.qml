import QtQuick 2.12
import QtQuick.Extras 1.4
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.3
import QtCharts 2.3
import QtDataVisualization 1.3
import Qt3D.Core 2.9
import Qt3D.Render 2.9

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: true
    color: "#444444"
    title: "PieceOfShift"

    Image {
        id: logoWhite_RightText
        x: 31
        y: 34
        width: 250
        source: "assets/images/Shift_Logo.png"
        fillMode: Image.PreserveAspectFit
    }
    Speedometer {
        id: speedometer
        x: 49
        y: 144
        width: 306
        height: 320
        minValue: 0
        maxValue: 600
    }


    Slider {
        id: slider
        from: 0
        to: 100
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

        handle: Rectangle {
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitWidth: 26
            implicitHeight: 26
            radius: 13
            color: "#0099ff"
        }

    }
    Timer {
        interval: 200
        running: true
        repeat: true
        property var distance: Math.random
        onTriggered: update()
    }
    function update(){
        var distance = (Math.random() * 0.03) + 0.1;
        var speed = (distance * 50) / 0.02;
        slider.value = slider.value + distance;
        speedometer.value = speed;
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.33000001311302185}
}
##^##*/

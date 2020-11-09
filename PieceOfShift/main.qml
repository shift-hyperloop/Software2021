import QtQuick 2.12
import QtQuick.Extras 1.4
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.3
import QtDataVisualization 1.3
import Qt3D.Core 2.9
import Qt3D.Render 2.9
import QtCharts 2.3
import shift.datamanagement 1.0

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: true
    color: "#444444"
    title: "PieceOfShift"
    menuBar: CustomMenuBar{
        _width: window.width
    }

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

    Thermometer {
        id: thermometer
        x: 1170
        y: 233
        scale: 2
        minValue: 0
        maxValue: 50
    }

    DistanceSlider{
        id: slider
        minValue: 0
        maxValue: 100
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
        thermometer.value = Math.random() * 25 + 25;
        chart.counter++;
        chart.lineseries.append(chart.counter, speed)
    }

    Chart {
        id: chart
        chartHeight: 300
        chartWidth: 300
        property var counter: 0
        x: 500
        y: 100
    }

    Text {
        id: labelText
        color: "white"
        width: 300
        height: 100
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.8999999761581421}
}
##^##*/

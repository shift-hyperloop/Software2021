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
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    Material.theme: Material.Dark
    id: window
    width: 1700
    height: 900
    visible: true
    //visibility: "FullScreen"
    color: "#444444"
    title: "PieceOfShift"
    menuBar: CustomMenuBar{
        /*_width: window.width - logoWhite_RightText.width
        x: logoWhite_RightText.width + 10*/
        id: menuBar
    }

    StackView {
        id: stackView
        anchors.fill: parent


        initialItem: Item {

            id: mainView

            property alias timer: timer
            property alias chart: chart;
            property alias counter: chart.counter
            Item {
                id: panelRightx
                y: topBar.height
                height: window.height - slider.height
                width: 0.3 * window.width

                Speedometer {
                    id: speedometer
                    anchors {
                        left: parent.left
                        top: parent.top
                    }

                    y: 0.06 * window.height //height of menubar is 0.05, but you cant use menuBar.height for some reason.
                    //speedometer has a weird bug where explicitly setting width and height turns it into a white circle
                    //therefore, scale is used to, uh, scale
                    scale: 0.1 + Math.min(window.width / 1000, window.height / 1000)
                    minValue: 0
                    maxValue: 600

            Speedometer {
                id: speedometer
                x: 0.03 * window.width
                y: 1.5 * speedometer.x
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
                x: 0.025 * window.width
                y: Math.max(window.height - 100, speedometer.y + speedometer.height);
                minValue: 0
                maxValue: 100
            }

            Timer {
                id: timer
                interval: 200
                running: true
                repeat: true
                property var distance: Math.random //What does this var do?
                onTriggered: update();

                function update(){
                    var distance = (Math.random() * 0.03) + 0.1;
                    var speed = (distance * 50) / 0.02;
                    slider.value = slider.value + distance;
                    speedometer.value = speed;
                    thermometer.value = Math.random() * 25 + 25;
                    chart.counter++;
                    chart.lineseries.append(chart.counter, speed);
                }
            }

            SimpleChart {
                id: chart
                chartHeight: 300
                chartWidth: 700
                property var counter: 0
                x: speedometer.width + 50
                y: 40

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stackView.push("PreviewPage.qml");
                    }
                }
            }

            Text {
                id: labelText
                color: "white"
                width: 300
                height: 100
            }

            ControlButtons{
                height: 200
                width: 300
                y: window.height - (height + 100)
                x: Math.max(window.width - (width + 30), thermometer.x + thermometer.width + 30)
                //Buttons will stop when colliding with thermometer
            }
            /*Battery{
                height:
                width:
                x:
                y:
            }*/
        }
    }


}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437;height:480}
}
##^##*/

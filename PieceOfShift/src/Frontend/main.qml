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
import CustomPlot 1.0

ApplicationWindow {
    Material.theme: Material.Dark
    Material.accent: "#0099ff"
    id: window
    width: 1700
    height: 900
    visible: true
    visibility: "Maximized"
    color: "#444444"
    title: "PieceOfShift"

    menuBar: CustomMenuBar{
        id: topBar
        NetworkInfo {
            id: networkinfo
            connected: true
            ping: 10
            anchors.right: parent.right
            anchors.top: parent.top
            z: 2
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    stackView.push("NetworkInfoPage.qml");
                }
                onHoveredChanged: {
                    parent.opacity = containsMouse ? 1.0 : 0.8;
                    cursorShape = containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
                }
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        property var chosenState // variable for the chosen state in StateIndication.qml
        initialItem: Item {

            id: mainView

            property alias timer: timer
            //property alias chart: chart
            property alias counter: customChart.counter
            //to change networkinfo status with button
            property alias connected: networkinfo.connected
            Item {
                id: panelLeft
                height: window.height - slider.height - anchors.topMargin
                width: 0.3 * window.width

                anchors {
                    left: parent.left
                    top: parent.top
                    topMargin: 0.05 * window.height //height of menubar is 0.05, but you cant use menuBar.height for some reason.
                }

                Speedometer {
                    id: speedometer
                    width: 226
                    height: 300
                    anchors {
                        left: parent.left
                        top: parent.top
                        topMargin: 30
                        leftMargin: 30
                    }
                    //speedometer has a weird bug where explicitly setting width and height turns it into a white circle
                    //therefore, scale is used to, uh, scale
                    scale: 0.15 + Math.min(window.width / 1600, window.height / 900)
                    transformOrigin: Item.TopLeft
                    minValue: 0
                    maxValue: 600
                }

            }
            Item {
                id: panelRight
                height: window.height - slider.height - anchors.topMargin
                width: 0.3 * window.width
                anchors {
                    right: parent.right
                    top: parent.top
                    topMargin: 0.05 * window.height
                }
                Thermometer {
                    id: thermometer
                    anchors {
                        right: parent.right
                        rightMargin: 20
                        top: parent.top
                        topMargin: (panelRight.height - (height * scale) - slider.height - (controlButtons.height * controlButtons.scale)) / 2
                    }
                    scale: Math.min(window.width / 1000, window.height / 600)
                    transformOrigin: Item.TopRight
                    minValue: 0
                    maxValue: 50
                }
                ControlButtons {
                    id: controlButtons
                    height: 200
                    width: 300
                    anchors {
                        bottom: parent.bottom
                        //bottomMargin: height * scale * 0.1
                        right: parent.right
                        rightMargin: 20
                    }
                    scale: Math.min(window.width / 1600, window.height / 900)
                    transformOrigin: Item.BottomRight
                }
            }
            Tiltmeter{
                id: tiltMeter
                rollDeg: 0
                pitchDeg: 0
                yawDeg: 0
                circleSize: window.height / 10
                anchors.left: battery.left
                anchors.leftMargin: circleSize * 1.5
                anchors.bottom: battery.top
                anchors.bottomMargin: circleSize
            }

            DistanceSlider{
                id: slider
                x: 0.025 * window.width
                anchors {
                    bottom: parent.bottom
                }

                minValue: 0
                maxValue: 100
            }
            Battery{
                id: battery
                height:window.height / 5
                anchors.left: parent.left
                anchors.leftMargin: window.height / 15
                anchors.bottom: slider.top
                anchors.bottomMargin: height/5
            }

            Timer {
                id: timer
                interval: 200
                running: true
                repeat: true
                onTriggered: update();

                //Updates both the speedometer and the graph with random values (for now)
                function update(){
                    var distance = (Math.random() * 0.03) + 0.1;
                    var speed = (distance * 50) / 0.02;
                    slider.value = slider.value + distance;
                    speedometer.value = speed;
                    valueTable.tableModel.setRow(0,{"name": "Speed", "value":qsTr(speedometer.value + "km/h")})
                    //updating field in table with index 0
                    thermometer.value = Math.random() * 25 + 25;
                    //change from customChart to chart to get old chart back.
                    customChart.counter++;
                    //chart.lineseries.append(chart.counter, speed);
                    battery.charge = 1 - slider.value / 100
                    tiltMeter.rollDeg +=  0.5 * Math.floor(Math.random()*3-1)
                    tiltMeter.yawDeg += 0.5 * Math.floor(Math.random()*3-1)
                    tiltMeter.pitchDeg += 0.5 * Math.floor(Math.random()*3-1)

                    customChart.chart.addData(Qt.point(customChart.counter, speed), 0);
                    customChart.chart.addData(Qt.point(customChart.counter, speed / 3), 1);
                }
            }

            CustomChart{
                id: customChart
                redirect: "MechanicalDetails.qml"
                width: window.width * 0.4
                height: window.height * 0.3
                anchors.right: valueTable.left
                anchors.rightMargin: 0.02*window.width
                anchors.top: valueTable.top
                property var counter: 0
                Component.onCompleted: {
                    //create a customPlot item with (2) graphs, and set their colors.
                    //any color sent to C++ will become a QColor, and vice versa.
                    chart.initCustomPlot(2);
                    chart.setGraphColor(0, "#2674BB");
                    chart.setGraphColor(1, "#AE3328");
                    chart.setDataType("Velocity");
                    chart.setName(0,"Speed km/h");
                    chart.setAxisLabels("Time","Speed km/h")
                    chart.setSimpleGraph(); // disables all interactions with the chart
                }
            }

            ValueTable{
                id: valueTable
                //tableWidth: 0.3 * window.width
                //tableHeight: 0.37 * window.height
                names: ["Speed","Voltage battery 1", "Value Value", "Bruh moments:", "Crashes"] // names for the values in the table
                values: [qsTr(0 + "km/h"), 12, 100, 8, 0] // values for the table
                anchors {                                   // indexes in names[] and values[] are corresponding
                    top: parent.top
                    topMargin: 0.06 * window.height
                    right: parent.right
                    rightMargin: thermometer.width + 0.07*window.width
                }
                scale: Math.min(window.width / 1600, window.height / 1000)
                transformOrigin: "TopLeft"
            }

            Text {
                id: labelText
                color: "white"
                width: 300
                height: 100
            }
        }
    }
}

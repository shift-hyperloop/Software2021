import QtQuick 2.12
import QtQuick.Extras 1.4
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.3
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
        Rectangle {
            id: menuDivider
            width: 2
            height: 0.05 * window.height
            color: "#ededed"
            opacity: 0.8
            anchors {
                top: parent.top
                left: parent.left
                leftMargin: window.height / 1.3
            }
        }

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
        PodState {
            id: podState
            currentState: 2
            anchors {
                top: parent.top
                left: menuDivider.right
                leftMargin: window.width * 0.01
            }
            z: 2
        }
    }

    DataManagerAccessor {
        id: dm
        Component.onCompleted: {
            dataManager.init()
        }

        dataManager.onNewData: {
            if (name == "Voltages[0-29]") {
            }
        }
    }

    /*
      TODO:
        Next workshop, focus on improving the Battery-page. Look into ValueAxis for naming of axes,
        and also look into multiple LineSeries in the same graph.
        This is wanted for the Battery-graphs, so figure out one way to have them on top of each other
        in a nice-looking way with clear referencing of each line.
      NOTE:
        ValueAxis.TitleText is the attribute that decides the naming of the axis itself (appears
        on the lefthand or righthand side of the graph).
        LineSeries.name is the attribute that decides what shows up in the "little square" over the graph
        that indicates the color of that particular line/function.
    */

    StackView {
        id: stackView
        anchors.fill: parent
        property var chosenState // variable for the chosen state in StateIndication.qml
        initialItem: Item {

            id: mainView

            property alias timer: timer
            //property alias chart: chart
            //property alias counter: customChart.counter
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
                    redirect: "MechanicalDetails.qml"
                    width: Math.round(window.width / 6) //round, because speedometer is very picky and doesnt like uneven widths.
                    height: width //width and height have to be equal!! (+- some margin but idk why you'd want an elliptical gauge)
                    anchors {
                        left: parent.left
                        top: parent.top
                        topMargin: 0.04 * window.height
                        leftMargin: window.width*0.025
                    }
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
                    id: thermometerBattery
                    width: window.width / 20
                    height: 4 * width
                    anchors {
                        right: parent.right
                        rightMargin: window.width * 0.025 - width * 0.3
                        top: parent.top
                        topMargin: 0.04 * window.height
                        //topMargin: (panelRight.height - (height * scale) - slider.height - (controlButtons.height * controlButtons.scale)) / 2
                    }
                    //scale: Math.min(window.width / 1000, window.height / 600)
                    transformOrigin: Item.TopRight
                    minValue: 0
                    maxValue: 100
                    measuredTemp: "Battery:"
                }
                Thermometer {
                    id: thermometerAmbient
                    width: window.width / 20
                    height: 4 * width
                    anchors {
                        right: thermometerBattery.right
                        rightMargin: window.width * 0.040
                        top: parent.top
                        topMargin: 0.04 * window.height
                        //topMargin: (panelRight.height - (height * scale) - slider.height - (controlButtons.height * controlButtons.scale)) / 2
                    }
                    //scale: Math.min(window.width / 1000, window.height / 600)
                    transformOrigin: Item.TopRight
                    minValue: 0
                    maxValue: 50
                    measuredTemp: "Ambient:"
                }
              /* ControlButtons {
                    id: controlButtons

                    height: window.height / 3.5
                    width: window.width / 5
                    y: window.height - slider.height - height - (0.04 * window.height)
                    anchors {
                        //bottom: parent.bottom
                        //bottomMargin: height * scale * 0.1
                        right: parent.right
                        rightMargin: window.width*0.025
                    }
                    transformOrigin: Item.BottomRight
                } */


            }
            ControlButtons{
                anchors.bottom: slider.top
                anchors.right: parent.right
                anchors.rightMargin: window.width * 0.025

            }
            Speedometer {
                id: barometer
                redirect: ""
                width: Math.round(window.width / 8)
                height: width
                minValue: 0
                maxValue: 100
                primaryUnit: " bar"
                secondaryTextVisible: false
                accentColor: "#e34242"
                anchors {
                    left: vcuchecklist.right
                    top: battery.top
                    leftMargin: window.width * 0.025
                }
            }

            Tiltmeter{
                id: tiltMeter
                rollDeg: 0
                pitchDeg: 0
                yawDeg: 0
                circleSize: window.height / 10
                anchors.left: parent.left
                anchors.leftMargin: 1.9*circleSize + window.width*0.025
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
                maxValue: 168
            }
            Battery{
                id: battery
                height: window.height / 4
                anchors.left: parent.left
                anchors.leftMargin: 0.025 * window.width
                anchors.bottom: slider.top
                anchors.bottomMargin: height/5
            }
            ValueTable{
                id: batteryCells
                anchors {
                    right: valueTable.left
                    rightMargin: 0.03 * window.width
                    top: valueTable.top
                }
                height: battery.height
                width: window.width / 3.5
                names: ["Max voltage", "Max battery temperature", "Minumum voltage", "Minumum battery temperature","Average voltage", "Average battery temperature"]
                values: [0,0,0,0,0,0]
            }
            Text{
                id: batteryText
                text: Math.round(battery.charge*100) + "%"
                font.pixelSize: window.width / 110
                anchors {
                    top: battery.bottom
                    topMargin: window.height*0.01
                }

                x: battery.x + battery.height/4 - width/2
                color: "white"
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
                    slider.value = slider.value + distance * 10;
                    speedometer.value = speed;
                    //valueTable.tableModel.setRow(0,{"name": "Speed", "value":qsTr(speedometer.value + "km/h")})
                    //updating field in table with index 0
                    thermometerAmbient.value = Math.random() * 25 + 25;
                    thermometerBattery.value = Math.random() * 10 + 25;
                    //change from customChart to chart to get old chart back.
                    //customChart.counter++;
                    //chart.lineseries.append(chart.counter, speed);
                    if(battery.charge>0){
                        battery.charge = 1 - slider.value / 100
                    }
                    else{
                        battery.charge = 0
                        vcuchecklist.checklist.get(1).currentState = "bad"
                    }


                    tiltMeter.rollDeg +=  0.5 * Math.floor(Math.random()*3-1)
                    tiltMeter.yawDeg += 0.5 * Math.floor(Math.random()*3-1)
                    tiltMeter.pitchDeg += 0.5 * Math.floor(Math.random()*3-1)
                }
            }

            /*CustomChart{
                id: customChart
                redirect: "MechanicalDetails.qml"
                width: window.width * 0.35
                height: window.height * 0.25
                anchors {
                    right: valueTable.left
                    rightMargin: 0.03 * window.width
                    top: valueTable.top
                }
                property var counter: 0
                Component.onCompleted: {
                    //create a customPlot item with (2) graphs, and set their colors.
                    //any color sent to C++ will become a QColor, and vice versa.
                    chart.initCustomPlot(2);
                    chart.setAxisRange(Qt.point(0, 100), Qt.point(0, 200));
                    chart.setGraphColor(0, "#2674BB");
                    chart.setGraphColor(1, "#AE3328");
                    chart.setGraphName(0,"Velocity");
                    chart.setGraphName(1,"Acceleration");
                    chart.setAxisLabels("Time","Speed km/h")
                    chart.setSimpleGraph(); // disables all interactions with the chart
                }
            }*/

            ValueTable{
                id: valueTable
                names: ["Speed","Voltage battery 1", "Value Value", "Bruh moments:", "Crashes", "Battery Charge", "Ambient temperature", "Value"] // names for the values in the table
                values: [qsTr(speedometer.value + "km/h"), 12, 100, 8, 0, qsTr(Math.round(battery.charge*100,1) + " %"), qsTr(Math.round(thermometerAmbient.value,1) + " \xB0 C"), 0] // values for the table
                anchors {                                   // indexes in names[] and values[] are corresponding
                    top: parent.top
                    topMargin: 0.09 * window.height
                    right: parent.right
                    rightMargin: thermometerAmbient.width * 2 + 0.03 * window.width
                }
                width: window.width / 4
                height: width * 4/5
            }

            VCUChecklist {
                id: vcuchecklist
                anchors {
                    left: battery.right
                    leftMargin: battery.height / 1.8
                    top: battery.top
                }
                width: 250
                height: 200
                names: ["Telemetry", "State Indication", "Sensors suite 1", "Sensors suite 2", "Inverter Control", "BMS Master"]
            }


        }
    }
}

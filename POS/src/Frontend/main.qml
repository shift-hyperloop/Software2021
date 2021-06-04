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

        property var maxVoltage: 0;
        property var currMaxVoltage: 0;

        property var minVoltage: Infinity;
        property var currMinVoltage: Infinity;

        property var avgVoltage: 0;
        property var voltageSum: 0;
        property var numVoltages: 0;

        property var maxTemp: 0;
        property var currMaxTemp: 0;

        property var minTemp: Infinity;
        property var currMinTemp: Infinity;

        property var avgTemp: 0;
        property var tempSum: 0;
        property var numTemps: 0;

        /* These two are used to update max, min and avg. 
        temps and voltages when all messages have been 
        received such that the values shown are current 
        and not for the whole run */
        property int voltagesReceived: 0;
        property int tempsReceived: 0;

        property var acceleration: 0
        property var position: 0

        property var soc_P1: 100
        property var soc_P2: 100

        property var table2Values: [speedometer.value + " m/s", acceleration + " m/s²", position + " m", (soc_P1 + soc_P2) / 2 +  " %", null, null]

        readonly property int num_voltage_messages: 6;
        readonly property int num_temp_messages: 4;

        dataManager.onNewData: {
            if (name.includes("Voltages_P") == true) { 
                for (let i = 0; i < data.length; i++) {
                    if (data[i] > currMaxVoltage) {
                        maxVoltage = data[i];
			            currMaxVoltage = data[i];
                        }
                    if (data[i] < currMinVoltage) {
                        minVoltage = data[i];
			            currMinVoltage = data[i];
                    }
		            voltageSum += data[i];
		            numVoltages++;
                }
		        voltagesReceived++;

                if (voltagesReceived >= num_voltage_messages) {
                    currMaxVoltage = 0;
                    currMinVoltage = Infinity;
                    avgVoltage = voltageSum / numVoltages;
                    voltageSum = 0;
                    numVoltages = 0;
                }
            }
            if (name.includes("Temp_P") == true) { 
                for (let i = 0; i < data.length; i++) {
                    if (data[i] > currMaxTemp) {
                        maxTemp = data[i];
			            currMaxTemp = data[i];
                    }
                    if (data[i] < currMinTemp) {
                        minTemp = data[i];
			            currMinTemp = data[i];
                    }
                    tempSum += data[i];
                    numTemps++;
                    }
                tempsReceived++;
                if (tempsReceived > num_temp_messages) {
                    currMaxTemp = 0;
                    currMinTemp = Infinity;
                    avgTemp = tempSum / numTemps;
                    tempSum = 0;
                    numTemps = 0;
                }
            }
            if (name == "IMU_PSA") {
                speedometer.value = data[1].toFixed(2);
                acceleration = data[2].toFixed(2);
                position = data[0].toFixed(2);
            }
            if (name == "IMU_YPR") {
                tiltMeter.yawDeg = data[0].toFixed(2);
                tiltMeter.pitchDeg = data[1].toFixed(2);
                tiltMeter.rollDeg = data[2].toFixed(2);
            }
            if (name == "BMS_Status_P1") {
                soc_P1 = data[0];
            }
            if (name == "BMS_Status_P2") {
                soc_P2 = data[0];
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
                    maxValue: 100
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
                value: dm.position

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

                charge: (dm.soc_P1 + dm.soc_P2) / 200 // Charge is between 0-1 and not 0-100
            }
            ValueTable{
                id: batteryCells
                anchors {
                    right: valueTable.left
                    rightMargin: 0.03 * window.width
                    top: valueTable.top
                }
		width: window.width * 0.28
                height: width * 4/5
                names: ["Max voltage", "Max battery temperature", "Min voltage", "Min battery temperature","Avg. voltage", "Avg. battery temperature"]
                values: [dm.maxVoltage + " V", dm.maxTemp + " °C", dm.minVoltage + " V", dm.minTemp + " °C", dm.avgVoltage.toFixed(2) + " V", dm.avgTemp.toFixed(2) + " V"]
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
                    //valueTable.tableModel.setRow(0,{"name": "Speed", "value":qsTr(speedometer.value + "km/h")})
                    //updating field in table with index 0
                    thermometerAmbient.value = Math.random() * 25 + 25;
                    thermometerBattery.value = Math.random() * 10 + 25;
                    //change from customChart to chart to get old chart back.
                    //customChart.counter++;
                    //chart.lineseries.append(chart.counter, speed);
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
                names: ["Velocity", "Acceleration", "Position", "Battery Charge", "Ambient temperature", "Pressure"] // names for the values in the table
                values: dm.table2Values // values for the table
                anchors {                                   // indexes in names[] and values[] are corresponding
                    top: parent.top
                    topMargin: 0.09 * window.height
                    right: parent.right
                    rightMargin: thermometerAmbient.width * 2 + 0.03 * window.width
                }
		        width: window.width * 0.28
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

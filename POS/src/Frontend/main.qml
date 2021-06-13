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

    // Global Styling
    Material.theme: Material.Dark
    Material.accent: "#0099ff"
    
    // Window Settings
    id: window
    width: 1700
    height: 900
    visible: true
    visibility: "Maximized"
    title: "POS"
    color: "#444444"

    menuBar: CustomMenuBar {
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
            id: networkInfo
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

    StackView {
        id: stackView
        anchors.fill: parent
        property var chosenState // variable for the chosen state in StateIndication.qml

        initialItem: Item {
            id: mainView

            // To change networkinfo status with button
            property alias connected: networkInfo.connected
            Item {
                id: panelTop
                height: window.height - slider.height - anchors.topMargin
                width: 0.3 * window.width

                anchors {
                    left: parent.left
                    top: parent.top
                    topMargin: 0.05 * window.height //height of menubar is 0.05, but you cant use menuBar.height for some reason.
                }

                

                Tiltmeter{
                    id: tiltMeter
                    rollDeg: 0
                    pitchDeg: 0
                    yawDeg: 0
                    circleSize: window.height / 10
                    anchors {
                        left: battery.left
                        leftMargin: window.width * 0.2
                        top: battery.bottom
                        topMargin: 0.08 * window.height
                    }
                }

                Battery {
                    id: battery
                    height: window.height / 4
                    anchors {
                        left: parent.left
                        top: parent.top
                        topMargin: 0.04 * window.height
                        leftMargin: window.width*0.025
                    }
                    charge: (dm.soc_P1 + dm.soc_P2) / 200 // Charge is between 0-1 and not 0-100
                }
                Text{
                    id: batteryText
                    text: Math.round(battery.charge*100) + "%"
                    font.pixelSize: window.width / 110
                    anchors {
                        left: battery.left
                        leftMargin: window.width * 0.028
                        top: battery.bottom
                        topMargin: window.height*0.01
                    }

                    x: battery.x + battery.height/4 - width/2
                    color: "white"
                }

                VCUChecklist {
                    id: vcuchecklist
                    anchors {
                        left: battery.right
                        leftMargin: battery.height
                        top: parent.top
                        topMargin: window.height * 0.1
                    }
                    width: 250
                    height: 200
                    names: ["Telemetry", "State Indication", "Sensors suite 1", "Sensors suite 2", "Inverter Control", "BMS Master"]
                }

                ValueTable{
                    id: batteryCells
                    anchors {
                        left: valueTable.right
                        leftMargin: 0.03 * window.width
                        top: valueTable.top
                    }
                    width: window.width * 0.28
                    height: width * 4/5
                    names: ["Max voltage", "Max battery temperature", "Min voltage", "Min battery temperature","Avg. voltage", "Avg. battery temperature"]
                    values: [dm.maxVoltage + " V", dm.maxTemp + " °C", dm.minVoltage + " V", dm.minTemp + " °C", dm.avgVoltage.toFixed(2) + " V", dm.avgTemp.toFixed(2) + " °C"]
                }
                

                ValueTable{
                    id: valueTable
                    names: ["Velocity", "Acceleration", "Position", "Battery Charge", "Ambient temperature", "Pressure"] // names for the values in the table
                    values: dm.table2Values // values for the table
                    anchors {                                   // indexes in names[] and values[] are corresponding
                        top: battery.top
                        left: vcuchecklist.right
                        leftMargin: window.width * 0.1
                    }
                    width: window.width * 0.28
                    height: width * 4/5

                }
            }

            Item {
                id: panelBottom
                height: window.height - slider.height - anchors.topMargin
                width: 0.3 * window.width
                anchors {
                    right: parent.right
                    rightMargin: window.width * 0.2
                    top: parent.verticalCenter
                    topMargin: 0.05 * window.height
                }
                Thermometer {
                    id: thermometerBattery
                    width: window.width / 20
                    height: 4 * width
                    anchors {
                        right: window.horizontalCenter
                        rightMargin: window.width * 0.01
                        top: parent.top
                        topMargin: 0.04 * window.height
                    }
                    transformOrigin: Item.TopRight
                    minValue: 0
                    maxValue: 400
                    measuredTemp: "Battery Avg" 
                    value: dm.avgTemp.toFixed(2)
                }

                Thermometer {
                    id: thermometerAmbient
                    width: window.width / 20
                    height: 4 * width
                    anchors {
                        right: thermometerBattery.right
                        rightMargin: window.width * 0.1
                        top: thermometerBattery.top
                    }
                    transformOrigin: Item.TopRight
                    minValue: 0
                    maxValue: 50
                    measuredTemp: "Ambient:"
                }

                Speedometer {
                    id: speedometer
                    redirect: "MechanicalDetails.qml"
                    width: Math.round(window.width / 5) //round, because speedometer is very picky and doesnt like uneven widths.
                    height: width //width and height have to be equal!! (+- some margin but idk why you'd want an elliptical gauge)
                    anchors {
                        right: thermometerAmbient.left
                        bottom: window.bottom
                        bottomMargin: 0.02 * window.height
                        rightMargin: window.width*0.18
                    }
                    minValue: 0
                    maxValue: 100
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
                        left: speedometer.right
                        verticalCenter: speedometer.verticalCenter
                        leftMargin: window.width * 0.025
                    }
                }
                
            }

            ControlButtons {
                anchors.bottom: slider.top
                anchors.right: parent.right
                anchors.rightMargin: window.width * 0.025
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
            
            




        }
    }
}

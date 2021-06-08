import QtQuick 2.0
import QtQuick.Controls 2.5
import shift.datamanagement 1.0

Page {
    id: inverterPage

    Button{
        text: "Go back"
        x: window.width * 0.01
        y: 0.05 * window.height
        height: window.height * 0.07
        width: window.width * 0.07
        font.pixelSize: window.height * 0.02
        onClicked: {
           stackView.pop(null);
        }
    }

    DataManagerAccessor {
        id: dm

        property var dcLink: 0
        property var juncTemp: 0
        property var limTemp: 0
        property var invTemp: 0

        dataManager.onNewData: {
            if (name.includes("DC-link measurement") == true) { 
                dcLink = data[0];
            }
            else if (name.includes("Junction Temperature") == true) { 
                juncTemp = data[0];
            }
            else if (name == "Temperature") { 
                limTemp = data[0];
            }
        }
    }

    CustomChart {
        id: phaseChart 
        width: window.width * 0.6
        height: window.height * 0.75
        anchors.bottom: parent.bottom
        anchors.bottomMargin: window.width * 0.05
        anchors.left: parent.left
        anchors.leftMargin: window.width * 0.01
        borderColor: "#222222"
        property var counter: 0
        Component.onCompleted: {
            //create a customPlot item with (2) graphs, and set their colors.
            //any color sent to C++ will become a QColor, and vice versa.
            chart.initCustomPlot(3);
            chart.setAxisRange(Qt.point(0, 100), Qt.point(0, 200));
            chart.setGraphColor(0, "#2674BB");
            chart.setGraphColor(1, "#AE3328");
            chart.setGraphColor(2, "#22AA22");
            chart.setGraphName(0, "Current measurements_0");
            chart.setGraphName(1, "Current measurements_1");
            chart.setGraphName(2, "Current measurements_2");
            chart.setAxisLabels("Time","Current [A]")
            chart.setBackgroundColor("#333333")

        }
    }

    Text {
        anchors.top: phaseChart.bottom
        anchors.topMargin: window.height * 0.03
        anchors.horizontalCenter: phaseChart.horizontalCenter
        text: "Phase Currents"
        color: "white"
        font.pixelSize: window.height * 0.03
    }

    ValueTable{
        id: limValues
        names: ["Junciton Temperature", "DC-link measurement", "LIM temp", "Inverter temp front"]
        values: [dm.juncTemp.toFixed(2) + " °C", dm.dcLink.toFixed(2) + " V?"]
        anchors.left: phaseChart.right
        anchors.leftMargin: window.width * 0.05
        anchors.top: phaseChart.top
        height: inverterPage.height * 0.2
        width: inverterPage.width * 0.3
    }

    //Text{
    //    anchors.bottom: limTemperatures.top
    //    anchors.bottomMargin: window.height * 0.01
    //    anchors.horizontalCenter: limTemperatures.horizontalCenter
    //    text: "Lim Temperatures"
    //    color: "white"
    //    font.pixelSize: window.height * 0.05
    //}
}

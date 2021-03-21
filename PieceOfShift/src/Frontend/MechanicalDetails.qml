import QtQuick.Controls 2.15
import QtQuick 2.12
import QtCharts 2.3
import CustomPlot 1.0


Page {
    id: item
    background: Rectangle{color: "#333333"} // background color for subpages

    property alias detailedChart: distanceChart;
    Keys.onPressed: { //If backspace is pressed => go back to previous page
        if (event.key === 16777219) {
            stackView.pop("main.qml");
        }
        /*
          onBackPressed should ideally work as above, but it doesn't, so it'll have to be done
          manually (although it's quite simple, so it's not too bad).
          */
    }
    Component.onDestruction:  {
        distanceChart.chart.remove();
        distanceChart2.chart.remove();
    }

    /*
      This function will, when the front-end is connected to the C++ backend,
      take in a QVariantMap (most likely) or the latest QVariant variable that
      keeps track of the values we want to monitor (pressure, temperature, ...) .
      For now, the function takes in nothing, but this will change in later revisions.
    */
    function checkForUpdates() {
        // Simple iteration for simulation purposes. Not final idea
        for (let element of pageElements) {
            element.text = Math.floor(Math.random() * 100 + 1).toString()
        }
    }

    property var pageElements: [
        pressureValue,
        tempValue,
    ]

    Button {
        id: backButton
        text: "Go Back"
        x: window.width * 0.01
        y: 0.05 * window.height
        onClicked: {
            stackView.pop("main.qml");
        }
    }

    CustomChart {
        id: distanceChart
        width: window.width * 0.6
        height: window.height * 0.35
        anchors.bottom: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: window.width * 0.01
        borderColor: "#222222"
        property var counter: 0
        Component.onCompleted: {
            //create a customPlot item with (2) graphs, and set their colors.
            //any color sent to C++ will become a QColor, and vice versa.
            chart.initCustomPlot(2);
            chart.setAxisRange(Qt.point(0, 100), Qt.point(0, 200));
            chart.setGraphColor(0, "#2674BB");
            chart.setGraphColor(1, "#AE3328");
            chart.setDataType("Velocity");
            chart.setName(0,"Speed km/h");
            chart.setAxisLabels("Time","Speed km/h")
            chart.setBackgroundColor("#333333")

        }
    }

    CustomChart {
        id: distanceChart2
        width: window.width * 0.6
        height: window.height * 0.35
        anchors.top: distanceChart.bottom
        anchors.topMargin: window.height * 0.02
        anchors.left: parent.left
        anchors.leftMargin: window.width * 0.01
        borderColor: "#222222"
        property var counter: 0
        Component.onCompleted: {
            //create a customPlot item with (2) graphs, and set their colors.
            //any color sent to C++ will become a QColor, and vice versa.
            chart.initCustomPlot(2);
            chart.setAxisRange(Qt.point(0, 1000), Qt.point(0, 500));
            chart.setGraphColor(0, "#2674BB");
            chart.setGraphColor(1, "#AE3328");
            chart.setDataType("Velocity");
            chart.setName(0,"Speed km/h");
            chart.setAxisLabels("Time","Speed km/h")
            chart.setBackgroundColor("#333333")
        }
    }

    Timer {
        id: updateValues
        running: true
        repeat: true
        // This interval might have to be shorter when processing real-time
        interval: 100
        onTriggered: {
            checkForUpdates();
        }
    }

    Rectangle {
        id: brakesSection
        x: window.width - width
        y: 0.05 * window.height
        height: (window.height - y) / 3
        width: Math.sqrt(2) * height
        color: "transparent"
        border.color: "black"
        border.width: 2
        radius: 4

        Text {
            id: brakesText
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: qsTr("BRAKES")
        }

        Rectangle {
            id: valvesContainer
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            //x: parent.x
            //y: parent.y + parent.height * 1/3
            height: 0.75 * parent.height
            width: parent.width / 3
            color: "transparent"
            border.color: "white"
            border.width: 2
            radius: 4

            Text {
                id: valveStatus
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                text: qsTr("Valve Status")
            }

            Image {
                id: green
                source: "../green.png"
                height: (parent.height - valveStatus.height - 30) / 2
                width: height
                anchors.horizontalCenter: parent.horizontalCenter
                y: valveStatus.y + valveStatus.height + 6
                opacity: 1
            }

            Image {
                id: red
                source: "../red.png"
                height: (parent.height - valveStatus.height - 30) / 2
                width: height
                anchors.horizontalCenter: parent.horizontalCenter
                y: green.y + green.height + 2
                opacity: 0.2
            }
        }

        Rectangle {
            id: brakePadsContainer
            x: valvesContainer.x + valvesContainer.width
            y: valvesContainer.y
            height: 0.75 * parent.height
            width: parent.width / 3
            color: "transparent"
            border.color: "white"
            border.width: 2
            radius: 4

            Text {
                id: tempText
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                text: qsTr("Pad temp.")
            }

            Text {
                id: tempValue
                anchors.centerIn: parent
                color: "white"
                text: qsTr("10C")
            }
        }

        Rectangle {
            id: pressureContainer
            x: brakePadsContainer.x + brakePadsContainer.width
            y: brakePadsContainer.y
            height: 0.75 * parent.height
            width: parent.width / 3
            color: "transparent"
            border.color: "white"
            border.width: 2
            radius: 4

            Text {
                id: pressureText
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                text: qsTr("Cylinder pressure")
            }

            Text {
                id: pressureValue
                anchors.centerIn: parent
                color: "white"
                text: qsTr("10kPa")
            }
        }
    }


    Rectangle {
        id: suspensionSection
        x: window.width - width
        y: brakesSection.y + brakesSection.height
        height: (window.height - 0.05 * window.height) / 3
        width: Math.sqrt(2) * height
        color: "transparent"
        border.color: "black"
        border.width: 2
        radius: 4

        Text {
            id: suspensionText
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: qsTr("SUSPENSION")
        }

        Rectangle {
            id: iBeamDistanceContainer
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            height: 0.75 * parent.height
            width: parent.width / 3
            color: "transparent"
            border.color: "white"
            border.width: 2
            radius: 4

            Text {
                id: distanceText
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                text: qsTr("I-beam distance")
            }

            Text {
                id: distanceValue
                anchors.centerIn: parent
                color: "white"
                text: qsTr("10 units")
            }
        }

        Rectangle {
            id: accelerationContainer
            x: iBeamDistanceContainer.x + iBeamDistanceContainer.width
            y: iBeamDistanceContainer.y
            height: 0.75 * parent.height
            width: parent.width / 3
            color: "transparent"
            border.color: "white"
            border.width: 2
            radius: 4

            Text {
                id: accelerationText
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                text: qsTr("Acceleration")
            }

            Text {
                id: accelerationValue
                anchors.centerIn: parent
                color: "white"
                text: qsTr("10 m/s^2")
            }
        }

        Rectangle {
            id: rollContainer
            x: accelerationContainer.x + accelerationContainer.width
            y: accelerationContainer.y
            height: 0.75 * parent.height
            width: parent.width / 3
            color: "transparent"
            border.color: "white"
            border.width: 2
            radius: 4

            Text {
                id: rollText
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                text: qsTr("Roll")
            }

            Text {
                id: rollValue
                anchors.centerIn: parent
                color: "white"
                text: qsTr("What goes here?")
            }
        }
    }

    /*
      Another rectangle to show (text-)info of valves being open or shut.
      Will probably not be a part of final revision, but just to have an
      object associated with updating the red/green images for displaying
      whether or not valves are open
    */


    Button {
        //Change positioning of button. Right now it overlaps
            id: button
            text: "Click"
            y: 0.05 * window.height
            anchors.right: brakesSection.left
            onClicked: {
                green.opacity = (green.opacity === 1) ? 0.2 : 1;
                red.opacity = (red.opacity === 1) ? 0.2 : 1;
            }
        }


}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

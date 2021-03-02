import QtQuick.Controls 2.15
import QtQuick 2.12
import QtCharts 2.3

Page {

    id: item
    height: window.height * 0.95
    width: window.width

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
        x: 0
        y: 0.05 * window.height
        onClicked: {
            stackView.pop("main.qml");
        }
    }

    Chart {
        id: distanceChart
        x: 0
        y: backButton.y + backButton.height
        chartWidth: Math.sqrt(2) * chartview.height
        chartHeight: Math.floor((window.height * 0.95 - backButton.height) / 2)
        // We can use HTML coding for text apparently. This is the only way the text turns white
        // (even though it's already defined in Chart.qml -> ValueAxis). QML is weird
        x_axis.titleText: "<font color='white'>Time</font>"
        y_axis.titleText: "<font color='white'>Distance</font>"
        lineseries.name: "<font color='white'>Example: Pod Distance Covered</font>"
        /*
          The following function is called when the component (i.e. page) is loaded.
          It will then iterate through the points from the previous graph (in main.qml)
          and add all those points to this graph.
        */

        Component.onCompleted: {
            let prv_graph = mainView.chart;
            for (let i = 0; i < prv_graph.lineseries.count; i++) {
                detailedChart.lineseries.append(prv_graph.lineseries.at(i).x, prv_graph.lineseries.at(i).y);
            }
        }


        //Timer for simulating continously updated points
        Timer {
            running: mainView.timer.running; repeat: true; interval: 200;
            onTriggered: {
                update(distanceChart, mainView.counter);
                update(someOtherChart, mainView.counter);
            }

            function update(chart, globalCounter) {
                var distance = (Math.random() * 0.03) + 0.1;
                var speed = (distance * 50) / 0.02;
                globalCounter++;
                chart.lineseries.append(globalCounter, speed)
            }
        }
    }

    Chart {
        id: someOtherChart
        x: distanceChart.x
        y: distanceChart.chartview.y + distanceChart.chartview.height + 10
        chartWidth: Math.sqrt(2) * chartview.height
        chartHeight: Math.floor((window.height * 0.95 - backButton.height) / 2)
        // We can use HTML coding for text apparently. This is the only way the text turns white
        // (even though it's already defined in Chart.qml -> ValueAxis). QML is weird
        x_axis.titleText: "<font color='white'>Time</font>"
        y_axis.titleText: "<font color='white'>Acceleration</font>"
        lineseries.name: "<font color='white'>Example: Acceleration over time</font>"

        LineSeries {
            id: test
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
        //radius: width*0.5

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
            x: red.x - text.length
            y: red.y + red.height

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

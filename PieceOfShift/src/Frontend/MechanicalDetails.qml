import QtQuick 2.15
import QtSensors 5.15
import QtQuick 2.5
import QtLocation 5.6
import QtQuick.Controls 1.4

Item {

    id: item
    height: window.height * 0.95
    width: window.width

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
        brakesAirReservoirPressure,
        brakesCaliperTemp
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
        id: rect1
        x: 0
        y: backButton.y + backButton.height
        height: 100
        width: Math.sqrt(2) * height
        color: "grey"
        border.color: "black"
        border.width: 1
        //radius: width*0.5

        Text {
            id: brakesAirReservoirPressure
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "black"
            text: "Pressure"
        }
    }

    Rectangle {
        id: rect2
        x: rect1.x
        y: rect1.y + rect1.height
        height: 100
        width: Math.sqrt(2) * height
        color: "grey"
        border.color: "black"
        border.width: 1
        //radius: width*0.5

        Text {
            id: brakesCaliperTemp
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "black"
            text: "Temperature"
        }
    }

    /*
      Another rectangle to show (text-)info of valves being open or shut.
      Will probably not be a part of final revision, but just to have an
      object associated with updating the red/green images for displaying
      whether or not valves are open
    */
    Rectangle {
        id: rect3
        x: rect2.x
        y: rect2.y + rect2.height
        height: 100
        width: Math.sqrt(2) * height
        color: "grey"
        border.color: "black"
        border.width: 1
        //radius: width*0.5

        Text {
            id: brakesValveStatus
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "black"
            text: "Open"
        }
    }

    Image {
        id: valveOpen
        source: "green.png"
        opacity: 1
        x: 200
        y: 200
    }

    Image {
        id: valveClosed
        source: "red.png"
        opacity: 0.2
        x: valveOpen.x
        y: valveOpen.y + valveOpen.height
    }

    Button {
        id: button
        text: "Change Valve status"
        x: valveClosed.x
        y: valveClosed.y + valveClosed.height

        onClicked: {
            if (brakesValveStatus.text === "Open") {
                brakesValveStatus.text = "Closed";
                valveOpen.opacity = 0.2;
                valveClosed.opacity = 1;
            }
            else {
                brakesValveStatus.text = "Open";
                valveOpen.opacity = 1;
                valveClosed.opacity = 0.2;
            }
        }
    }




}

import QtQuick 2.15
import QtSensors 5.15
import QtQuick 2.5
import QtLocation 5.6
import QtQuick.Controls 1.4

Item {

    id: item
    height: window.height * 0.95
    width: window.width

    Rectangle {
        x: 100
        y: 400
        width: 100
        height: width
        color: "grey"
        border.color: "black"
        border.width: 1
        radius: width*0.5

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "black"
            text: "Pressure"

        }
    }

    Image {
        id: valveIllustration
        source: "file"
    }

}

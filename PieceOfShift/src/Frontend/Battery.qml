import QtQuick 2.0

Item {
    property var charge: 1 // how much charge is left, number between 1 and 0

    Image {
        id: batteryImg
        source: "../battery.png"
        fillMode: Image.PreserveAspectFit
        height: parent.height
        z: 3
        }
        Rectangle {
            id: container
            height: batteryImg.height * 0.3
            width: batteryImg.width * 0.65
            y: batteryImg.y + batteryImg.height * 0.37
            z: 1
            anchors.horizontalCenter: batteryImg.horizontalCenter
        }
        Rectangle{
            id: rectRed
            color: "#A52A2A"
            height: {
                if( charge > 0){
                    container.height  - rectGreen.height
                }
                else{
                    container.height
                }
            }
            width: container.width
            anchors.top: container.top
            anchors.horizontalCenter: container.horizontalCenter
            z: 2

        }
        Rectangle{
            id: rectGreen
            color: "#7CB06D"
            height: container.height * charge
            width: container.width
            anchors.bottom: container.bottom
            anchors.horizontalCenter: container.horizontalCenter
            z: 2
        }
}



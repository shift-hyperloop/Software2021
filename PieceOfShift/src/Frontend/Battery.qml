import QtQuick 2.0

Item {
    property var charge: 1 // how much charge is left, number between 1 and 0

    Image {
        id: batteryImg
        source: "../battery.png"
        fillMode: Image.PreserveAspectFit
        height: parent.height
        z: 3
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
            onClicked: {
                stackView.push("DetailedBatteryPage.qml")
            }
        }
        }
        Rectangle {
            id: container
            height: batteryImg.height * 0.83
            width: batteryImg.width * 0.88
            y: batteryImg.y + batteryImg.height * 0.15
            z: 1
            anchors.horizontalCenter: batteryImg.horizontalCenter
        }
        Rectangle{
            id: rectRed                 //red rectangle is anchored to the top and starts with height 0.
            color: "#e36868"                // height increases as charge decreases
            height: {
                if( charge > 0){
                    container.height  - rectGreen.height
                }
                else{                   // when charge reaches 0 the red rectangle fills the whole battery image
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
            color: "#55a848"
            height: container.height * charge //the green rectangle is anchored to the bottom and height decreases as charge decreases
            width: container.width
            anchors.bottom: container.bottom
            anchors.horizontalCenter: container.horizontalCenter
            z: 2
        }
}



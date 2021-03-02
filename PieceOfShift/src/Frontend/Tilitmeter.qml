import QtQuick 2.0

Item {
    property alias circleSize: r.circleSize
    property alias rollDeg: roll.rollDeg
    property alias pitchDeg: pitch.pitchDeg
    property alias yawDeg: yaw.yawDeg

    Rectangle{
        id:r
        property var circleSize
        anchors.centerIn: parent
        color: "grey"
        width: parent.width
        height: parent.height

            Flow{
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: width * 0.1

                Rectangle{
                    property var rollDeg
                    id: roll
                    width: circleSize
                    height: circleSize
                    radius: 100
                    color: "black"
                    Semicircle{
                        transform: Rotation{ origin.x: circleSize / 2; origin.y: circleSize / 2; angle: rollDeg}
                    }
                }
                Rectangle{
                    id: pitch
                    property var pitchDeg
                    width: circleSize
                    height: circleSize
                    radius: 100
                    color: "black"
                    Semicircle{
                        transform: Rotation{ origin.x: circleSize / 2; origin.y: circleSize / 2; angle: pitchDeg}
                    }
                }
                Rectangle{
                    property var yawDeg
                    id: yaw
                    width: circleSize
                    height: circleSize
                    radius: 100
                    color: "black"
                    Semicircle{
                        transform: Rotation{ origin.x: circleSize / 2; origin.y: circleSize / 2; angle: yawDeg}
                    }
                }
            }
            Text {
                text: qsTr("Roll: " + roll.rollDeg + " deg")
                x: roll.x + r.width / 3- circleSize
                y: roll.y
            }
            Text {
                text: qsTr("Yaw: " + yaw.yawDeg+ " deg")
                x: yaw.x + r.width / 3 - circleSize
                y: roll.y
            }
            Text {
                text: qsTr("Pitch: " + pitch.pitchDeg+ " deg")
                x: pitch.x + r.width / 3- circleSize
                y: pitch.y
            }
    }
}

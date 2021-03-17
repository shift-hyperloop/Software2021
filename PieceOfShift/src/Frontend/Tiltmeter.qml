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
        color: "#87CEEB"
        width: parent.width
        height: parent.height

            Flow{
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: width * 0.1
                Rectangle {
                    width: circleSize
                    height: circleSize
                    color: "#00000000"
                    Text {
                        text: qsTr("Roll: " + roll.rollDeg + "°")
                        horizontalAlignment: Text.AlignLeft
                        anchors {
                            left: parent.left
                            leftMargin: circleSize * 0.15
                            bottom: parent.top
                            bottomMargin: 10
                        }
                        color: "white"
                        font.pixelSize: circleSize / 5
                    }
                    Rectangle{
                        property var rollDeg
                        id: roll
                        width: circleSize
                        height: circleSize
                        radius: 100
                        color: "black"
                        Semicircle{
                            //transform: Rotation{ origin.x: circleSize / 2; origin.y: circleSize / 2; angle: rollDeg}
                            rotation: rollDeg
                            Behavior on rotation {
                                NumberAnimation {
                                    duration: 100
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    width: circleSize
                    height: circleSize
                    color: "#00000000"
                    Text {
                        text: qsTr("Pitch: " + pitch.pitchDeg + "°")
                        horizontalAlignment: Text.AlignLeft
                        anchors {
                            left: parent.left
                            leftMargin: circleSize * 0.15
                            bottom: parent.top
                            bottomMargin: 10
                        }
                        color: "white"
                        font.pixelSize: circleSize / 5
                    }
                    Rectangle{
                        id: pitch
                        property var pitchDeg
                        width: circleSize
                        height: circleSize
                        radius: 100
                        color: "black"
                        Semicircle{
                            //transform: Rotation{ origin.x: circleSize / 2; origin.y: circleSize / 2; angle: pitchDeg
                            rotation: pitchDeg
                            Behavior on rotation {
                                NumberAnimation {
                                    duration: 100
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    width: circleSize
                    height: circleSize
                    color: "#00000000"
                    Text {
                        text: qsTr("Yaw: " + yaw.yawDeg + "°")
                        horizontalAlignment: Text.AlignLeft
                        anchors {
                            left: parent.left
                            leftMargin: circleSize * 0.15
                            bottom: parent.top
                            bottomMargin: 10
                        }

                        color: "white"
                        font.pixelSize: circleSize / 5
                    }
                    Rectangle{
                        property var yawDeg
                        id: yaw
                        width: circleSize
                        height: circleSize
                        radius: 100
                        color: "black"
                        Semicircle{
                            //transform: Rotation{ origin.x: circleSize / 2; origin.y: circleSize / 2; angle: yawDeg}
                            rotation: yawDeg
                            Behavior on rotation {
                                NumberAnimation {
                                    duration: 100
                                }
                            }
                        }
                    }
                }
            }
    }
}

import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import shift.datamanagement 1.0

Item {
    DataManagerAccessor {
        id: dataManager
    }

    Rectangle {
        id: buttons
        color: "#00ffffff"
        anchors.fill: parent
        border.width: 0
        Button{
            id: b0
            text: "Engage High Voltage"
            anchors {
                top: parent.top
                right: parent.right
                rightMargin: 10
            }

            width: parent.width - 20
            height: parent.height / 3
            contentItem: Text {
                text: parent.text
                font.pixelSize: window.width / 90
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle{
                border.width: 3
                radius: 8
                color: parent.down ? "#ffa126" : "#e0942f"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        dataManager.dataManager.sendPodCommand(PodCommand.HIGH_VOLTAGE);
                    }
                    onPressed: {
                        parent.color = "#e0942f";
                    }
                    onReleased: {
                        parent.color = "#ffa126";
                    }
                    onHoveredChanged: {
                        parent.opacity = containsMouse ? 1.0 : 0.8;
                        cursorShape = containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
                    }
                }
            }
        }
        Button{
            id: b1
            text: "Start"
            anchors {
                left: parent.left
                top: parent.top
                leftMargin: 10
                topMargin: b0.height - 5
            }
            width: parent.width * 0.455
            height: parent.height / 3
            contentItem: Text {
                text: parent.text
                font.pixelSize: parent.height * 0.2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle{
                /*
                border.width: 3
                radius: 8
                color: parent.down ? "#1db552" : "#24d160"
                */
                implicitWidth: parent.width
                implicitHeight: parent.height
                border.width: 2
                border.color: "#888"
                radius: 8
                opacity: 0.8
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        mainView.timer.start();
                        dataManager.dataManager.sendPodCommand(PodCommand.START);
                        // To test that connection status works:
                        //networkinfo.connected = true;
                        //networkinfo.connectionStrength = 3
                    }
                    onPressed: {
                        parent.color = "#aaa";
                    }
                    onReleased: {
                        parent.color = "#eee";
                    }
                    onHoveredChanged: {
                        parent.opacity = containsMouse ? 1.0 : 0.8;
                        cursorShape = containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
                    }
                }
            }
        }
        Button{
            id: b2
            text: "Stop"
            anchors {
                right: parent.right
                top: parent.top
                rightMargin: 10
                topMargin: b0.height - 5
            }

            width: parent.width * 0.455
            height: parent.height / 3
            contentItem: Text {
                text: parent.text
                font.pixelSize: parent.height * 0.2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle{
                /*
                border.width: 3
                radius: 8
                color: parent.down ? "#cc121e" : "#ff1424"
                */
                implicitWidth: parent.width
                implicitHeight: parent.height
                border.width: 2
                border.color: "#888"
                radius: 8
                opacity: 0.8
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        mainView.timer.stop();
                        dataManager.dataManager.sendPodCommand(PodCommand.STOP);
                    }
                    onPressed: {
                        parent.color = "#aaa";
                    }
                    onReleased: {
                        parent.color = "#eee";
                    }
                    onHoveredChanged: {
                        parent.opacity = containsMouse ? 1.0 : 0.8;
                        cursorShape = containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
                    }
                }
            }
        }
        Button{
            height: parent.height / 3
            width: parent.width - 20
            text: "Emergency Stop"
            anchors {
                top: b0.bottom
                left: parent.left
                leftMargin: 10
                topMargin: b1.height - 10
            }


            contentItem: Text {
                text: parent.text
                font.pixelSize: parent.height * 0.2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle{
                border.width: 3
                radius: 8
                color: parent.down ? "#cc121e" : "#ff1424"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        dataManager.dataManager.sendPodCommand(PodCommand.EMERGENCY_BRAKE);
                        //valueTable.tableModel.setRow(3,{"name": "Bruh moments:", "color":valueTable.tableModel.getRow(3).color += 1})
                        //accessing a value in valuetable - should work but does not
                    }
                    onPressed: {
                        parent.color = "#cc121e";
                    }
                    onReleased: {
                        parent.color = "#ff1424";
                    }
                    onHoveredChanged: {
                        parent.opacity = containsMouse ? 1.0 : 0.8;
                        cursorShape = containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

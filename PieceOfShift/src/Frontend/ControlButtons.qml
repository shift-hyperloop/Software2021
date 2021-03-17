import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import shift.datamanagement 1.0

Item {

    DataManagerAccessor {
        id: dataManager
    }

    Rectangle{
        color: "#00ffffff"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        border.width: 0
        radius: 10

        Button{
            id: b1
            text: "Start"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.topMargin: 10
            width: parent.width * 0.47
            height: parent.height * 0.5
            contentItem: Text {
                text: parent.text
                font.pixelSize: parent.height * 0.15
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
            x: 300
            text: "Stop"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            anchors.topMargin: 10
            width: parent.width * 0.45
            height: parent.height * 0.5
            contentItem: Text {
                text: parent.text
                font.pixelSize: parent.height * 0.15
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
            x: 10
            y: 269
            text: "Emergency Stop"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 19
            anchors.right: parent.right
            anchors.rightMargin: 10
            implicitWidth: parent.width - 20
            height: parent.height * 0.4
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

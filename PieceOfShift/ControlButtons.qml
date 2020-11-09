import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
Item {
    Rectangle{
        anchors.fill: parent
        border.width: 5
        radius: 10
        color: "grey"

        Button{
            text: "Start"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.topMargin: 10
            width: parent.width * 0.45
            height: parent.height * 0.5
            contentItem: Text {
                text: parent.text
                font.bold: true
                font.pixelSize: parent.height * 0.15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle{
                border.width: 5
                radius: 10
                color: parent.down ? "darkgreen" : "green"
            }
            onClicked: {

            }
        }
        Button{
            text: "Stop"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            anchors.topMargin: 10
            width: parent.width * 0.45
            height: parent.height * 0.5
            contentItem: Text {
                text: parent.text
                font.bold: true
                font.pixelSize: parent.height * 0.15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle{
                border.width: 5
                radius: 10
                color: parent.down ? "darkred" : "red"
            }
            onClicked: {

            }
        }
        Button{
            text: "Emergency Stop"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            implicitWidth: parent.width - 20
            height: parent.height * 0.4
            contentItem: Text {
                text: parent.text
                font.bold: true
                font.pixelSize: parent.height * 0.2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle{
                border.width: 5
                radius: 10
                color: parent.down ? "darkred" : "red"
            }
            onClicked: {

            }
        }
    }
}

import QtQuick 2.0
import QtQuick 2.14
import Qt.labs.qmlmodels 1.0

Item {
    property int speedValue: 10
    width: 400
    height: 400
    Rectangle {
        id: rectangle
        x: 0
        y: 0
        anchors.fill: parent
        color: "#00000000"
        border.color: "#ededed"
        border.width: 3
        TableView{
            x: rectangle.x + rectangle.border.width
            y: rectangle.y + rectangle.border.width
            id: table
            anchors.fill: parent
            columnSpacing: 0
            interactive: false
            model: TableModel {
                TableModelColumn { display: "name" }
                TableModelColumn { display: "color" }
                   rows: [
                       {
                           "name": "Speed",
                           "color": qsTr(speedValue + "km/h")
                       },
                       {
                           "name": "Voltage battery 1",
                           "color": "12"
                       },
                       {
                           "name": "Value Value",
                           "color": "100"
                       },
                       {
                           "name": "Bruh moments:",
                           "color": "8"
                       },
                       {
                           "name": "Crashes",
                           "color": "0"
                       }
                   ]
            }

            delegate: Rectangle {
                implicitWidth: rectangle.width / table.columns
                implicitHeight: rectangle.height / table.rows
                border.color: "#ffffff"
                color: "#00000000"
                border.width: 2
                Text {
                    height: parent.height
                    width: parent.width
                    text: display
                    font.pixelSize: 18
                    color: "#e3e3e3"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
}

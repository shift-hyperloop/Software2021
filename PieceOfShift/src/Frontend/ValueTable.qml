import QtQuick 2.0
import QtQuick 2.14
import Qt.labs.qmlmodels 1.0

Item {
    property int rowCount
    property var names: []
    property var values: []
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
                id: tableModel
                TableModelColumn { display: "name" }
                TableModelColumn { display: "value" }
                   rows: []
            }
            Component.onCompleted: {
                for(var i = 0; i< rowCount; i++){
                    tableModel.appendRow({
                        "name" : names[i],
                        "value" : values[i]
                    })
                }


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

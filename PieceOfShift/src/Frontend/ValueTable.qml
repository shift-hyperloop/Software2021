import QtQuick 2.0
import QtQuick 2.14
import Qt.labs.qmlmodels 1.0

Item {
    id: tableItem
    property var names: []
    property var values: []
    property alias tableModel: tableModel
    //property alias tableWidth: tableItem.width
    //property alias tableHeight: tableItem.height
    width: 500
    height: 400
    Rectangle {
        id: rectangle
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
            Component.onCompleted: { //adds the names and values that are deffined when the component is used
                for(var i = 0; i< names.length; i++){
                    tableModel.appendRow({
                        "name" : names[i],
                        "value" : values[i]
                    })
                }


            }

            delegate: Rectangle {
                implicitWidth: rectangle.width / table.columns
                implicitHeight: rectangle.height / table.rows
                //width: rectangle.width / table.columns
                //height: rectangle.height / table.rows
                border.color: "#ededed"
                color: "#00000000"
                border.width: 2
                Text {
                    anchors.fill: parent
                    text: display
                    font.pixelSize: 18
                    color: "#ededed"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
}

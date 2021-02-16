import QtQuick 2.0
import QtQuick 2.14
import Qt.labs.qmlmodels 1.0

Item {
    width: 216
    height: 215
    Rectangle {
        id: rectangle
        x: 8
        y: 8
        width: 200
        height: 200
        color: "#00000000"
        border.color: "#ffffff"
        border.width: 5
    }
    TableView{
        width: 300
        height: 300
        columnSpacing: 0
        interactive: false
        model: TableModel {
            TableModelColumn { display: "name" }
            TableModelColumn { display: "color" }
                   rows: [
                       {
                           "name": "cat",
                           "color": "black"
                       },
                       {
                           "name": "dog",
                           "color": "brown"
                       },
                       {
                           "name": "bird",
                           "color": "white"
                       }
                   ]
               }

        delegate: Rectangle {
                implicitWidth: 100
                implicitHeight: 50
                border.color: "#000000"
                border.width: 2
                Text {
                    text: qsTr("")
                }
                Text {
                    text: display
                }
            }
    }
}

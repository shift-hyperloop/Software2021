import QtQuick 2.0
import QtQuick 2.15

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
        columnSpacing: 5
        delegate: Rectangle {
                implicitWidth: 50
                implicitHeight: 50
                border.color: "#000000"
                border.width: 2
                Text {
                    text: qsTr("Test2!")
                }
            }
    }
}

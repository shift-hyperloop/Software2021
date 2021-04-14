import QtQuick.Controls 2.15
import QtQuick 2.15
import QtQuick.Dialogs 1.3

Item {
    id: cGrid

    // Ideally, anchors would be used instead of x-/y-positioning. But anchors didn't work, so I CBA
    // to spend time fixing this right now
    // Note: might be because of the menu-bar
    TextField {
        id: rowText
        placeholderText: qsTr("Enter rows")
        x: 2
        y: height + 2
        validator: IntValidator {bottom: 1; top: 50;}
        focus: true
        text: qsTr("9")
        // For some annoying ass reason, anchors aren't working (QML I hate you so much)
        //anchors.top: parent.top
        //anchors.left: parent.left
    }

    TextField {
        id: colText
        placeholderText: qsTr("Enter columns")
        x: rowText.x + rowText.width + 5
        y: rowText.y
        validator: IntValidator {bottom: 1; top: 50;}
        text: qsTr("20")
    }

    Grid {
        id: grid
        x: rowText.x + 5
        y: rowText.y + rowText.height + 5
        spacing: 1
        width: window.width - 10
        height: window.height * 0.95 - rowText.height - rowText.y

        columns: colText.text ? parseInt(colText.text) : 10;
        rows: rowText.text ? parseInt(rowText.text) : 10;

        // This component creates a fixed number of repetitive, sub-components (in this case rectangles)
        Repeater {
            // This attribute specifies the number of components to create
            model: parent.columns * parent.rows
            // Here we create columns * rows number of Rectangle-components
            Rectangle {
                states: [
                    State {
                        name: "very hot"
                        PropertyChanges { target: rect; color: "#FF0000"}
                    },
                    State {
                        name: "slightly hot"
                        PropertyChanges { target: rect; color: "#FF8800"}
                    },
                    State {
                        name: "hot"
                        PropertyChanges { target: rect; color: "#FFBB00"}
                    }
                ]
                id: rect
                width: Math.floor((parent.width - 20) / parent.columns)
                height: Math.floor((parent.height - 20) / parent.rows)
                color: "red"
                border {
                    color: {
                        return "black";
                    }
                    width: 2
                }

                Text {
                    text: rect.Positioner.index + "\u00b0"
                    anchors.centerIn: parent
                }
            }
        }
    }

    Timer {
        id: timer
        running: true
        repeat: true
        interval: 1000
        onTriggered: {

        }
    }

}
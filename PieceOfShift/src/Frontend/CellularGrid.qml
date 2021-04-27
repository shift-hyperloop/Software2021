import QtQuick.Controls 2.15
import QtQuick 2.15
import QtQuick.Dialogs 1.3

Item {
    id: cGrid

    Column {
        id: colorIndex
        x: 10
        y: 0.05 * window.height + 25
        spacing: 5

        Text {
            id: explanation
            x: parent.x
            y: parent.y
            width: 130
            text: qsTr("The following\nboxes indicate\ncell temperatures")
            color: "yellow"
        }

        Rectangle {
            id: color1
            x: parent.x
            color: "#FF0000"

            width: Math.floor((grid.width - 20) / grid.columns)
            height: Math.floor((grid.height - 20) / grid.rows)

            border.width: 2
            border.color: "black"

            Text {
                anchors.centerIn: parent
                text: ">= 50" + "\u00b0" + "C"
            }
        }

        Rectangle {
            id: color2
            x: parent.x
            color: "#FF8800"
            
            width: Math.floor((grid.width - 20) / grid.columns)
            height: Math.floor((grid.height - 20) / grid.rows)

            border.width: 2
            border.color: "black"

            Text {
                anchors.centerIn: parent
                text: ">= 36" + "\u00b0" + "C"
            }
        }

        Rectangle {
            id: color3
            x: parent.x
            color: "#FFBB00"
            
            width: Math.floor((grid.width - 20) / grid.columns)
            height: Math.floor((grid.height - 20) / grid.rows)

            border.width: 2
            border.color: "black"

            Text {
                anchors.centerIn: parent
                text: ">= 22" + "\u00b0" + "C"
            }
        }

        Rectangle {
            id: color4
            x: parent.x
            color: "#FFFF00"
            
            width: Math.floor((grid.width - 20) / grid.columns)
            height: Math.floor((grid.height - 20) / grid.rows)

            border.width: 2
            border.color: "black"

            Text {
                anchors.centerIn: parent
                text: ">= 6" + "\u00b0" + "C"
            }
        }

        Rectangle {
            id: color5
            x: parent.x
            color: "#9dff00"
            
            width: Math.floor((grid.width - 20) / grid.columns)
            height: Math.floor((grid.height - 20) / grid.rows)

            border.width: 2
            border.color: "black"

            Text {
                anchors.centerIn: parent
                text: "< 6" + "\u00b0" + "C"
            }
        }

    }

    Grid {
        id: grid
        x: colorIndex.x + colorIndex.width + 5
        y: colorIndex.y
        spacing: 1
        width: window.width - colorIndex.width - 15
        height: window.height * 0.95 - y + 25

        columns: 20
        rows: 9

        // This component creates a fixed number of repetitive, sub-components (in this case rectangles)
        Repeater {
            id: repeater
            // This attribute specifies the number of components to create
            model: parent.columns * parent.rows
            // Here we create columns * rows number of Rectangle-components
            Rectangle {
                id: rect
                width: Math.floor((parent.width - 20) / parent.columns)
                height: Math.floor((parent.height - 20) / parent.rows)
                color: "red"
                property var temperature: 50
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
                    },
                    State {
                        name: "not so hot"
                        PropertyChanges { target: rect; color: "#FFFF00"}
                    },
                    State {
                        name: "cold"
                        PropertyChanges { target: rect; color: "#9dff00"}
                    }
                ]

                transitions: Transition {
                    ColorAnimation { duration: 800 }
                }
                border {
                    color: "black"
                    width: 2
                }

                Text {
                    text: rect.temperature + "\u00b0" + "C"
                    anchors.centerIn: parent
                }
            }
        }
    }

    Timer {
        id: timer
        running: true
        repeat: true
        interval: 200
        onTriggered: {
            for (let i = 0; i < repeater.count; i++) {
                let temperature = Math.floor(Math.random() * 70) - 10;
                repeater.itemAt(i).temperature = temperature;
                repeater.itemAt(i).state = (temperature < 6) ?
                            'cold' : (temperature < 22) ?
                            'not so hot' : (temperature < 36) ?
                            'hot' : (temperature < 50) ?
                            'slightly hot' : 'very hot';
            }
        }
    }
}
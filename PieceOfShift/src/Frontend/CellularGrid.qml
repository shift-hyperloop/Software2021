import QtQuick.Controls 2.15
import QtQuick 2.15
import QtQuick.Dialogs 1.3

Item {
    id: cGrid

    Grid {
        id: grid
        x: 7
        y: 0.05 * window.height + 25
        spacing: 1
        width: window.width - 10
        height: window.height * 0.95 - y

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
                        name: "error"
                        PropertyChanges { target: rect; color: "#910000"}
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
                let temperature = Math.floor(Math.random() * 60) + 60;
                repeater.itemAt(i).temperature = temperature;
                repeater.itemAt(i).state = (temperature < 30) ?
                            'error' : (temperature < 60) ?
                            'not so hot' : (temperature < 90) ?
                            'hot' : (temperature < 120) ?
                            'slightly hot' : 'very hot';
            }
        }
    }
}
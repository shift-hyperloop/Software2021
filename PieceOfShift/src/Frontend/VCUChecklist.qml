import QtQuick 2.15
import QtQuick.Layouts 1.3
import shift.datamanagement 1.0

Item {
    property alias checklist: checklistModel
    property var names: []
    Rectangle {
        width: 200
        height: 200
        color: "#00000000"
        ListModel {
            id: checklistModel

        }

        Component {
            id: checklistDelegate
            Row {
                state: currentState
                spacing: 10
                Text {
                    id: text
                    text: name
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: window.width / 110
                }

                Rectangle {
                    id: rect
                    height: 10; width: 10
                    radius: height
                    color: "blue"
                    y: text.font.pixelSize / 2
                }
                states: [
                    State {
                        name: "good"
                        PropertyChanges {
                            target: rect
                            color: "green"
                        }
                    },
                    State {
                        name: "bad"
                        PropertyChanges {
                            target: rect
                            color: "red"
                        }
                    },
                    State {
                        name: "ok"
                        PropertyChanges {
                            target: rect
                            color: "yellow"
                        }
                    }

                ]
            }
        }

        ListView {
            id: checklistListView
            anchors.fill: parent
            model: checklistModel
            delegate: checklistDelegate
            interactive: false
            Component.onCompleted: {
                for (var i = 0; i < names.length; i++){
                    checklistModel.append({"name": names[i], "currentState": "bad"});
                }
            }
        }
    }

    Timer {
        id: timer
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            checklistModel.get(0).currentState = "ok"
            checklistModel.get(1).currentState = 'good'
        }
    }
}


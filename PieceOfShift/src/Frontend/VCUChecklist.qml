import QtQuick 2.15
import QtQuick.Layouts 1.3
import shift.datamanagement 1.0

Item {
    width: 200
    height: 200
    property alias checklist: checklistModel
    property var names: []
    Rectangle {
        id: checklist
        anchors.fill: parent
        color: "#00000000"
        ListModel {
            id: checklistModel

        }
        //The checklist is made up of two components, text, and a colored circle. The circle changes color based on the current state of that checklist object. Circle can be replaced by
        //an icon in the future. State of an object is set by "checklist.get(i).currentState = ''"
        Component {
            id: checklistDelegate
            Row {
                state: currentState
                spacing: 10
                width: parent.width
                Text {
                    id: text
                    text: name
                    width: parent.width * 0.8
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: checklist.width / 10
                    Layout.fillWidth: true
                }

                Rectangle {
                    id: rect
                    y: text.font.pixelSize / 2
                    height: parent.width / 20; width: parent.width / 20
                    radius: height
                    color: "blue"
                    Layout.alignment: Qt.AlignRight
                }

                states: [
                    State {
                        name: "bad"
                        PropertyChanges {
                            target: rect
                            color: "red"
                        }
                    },
                    State {
                        name: "precon 1"
                        PropertyChanges {
                            target: rect
                            color: "white"
                            border.color: "black"
                            border.width: 2
                            width: (parent.width / 20) + 4 ; height: (parent.width / 20) + 4

                        }
                    },
                    State {
                        name: "precon 2"
                        PropertyChanges {
                            target: rect
                            color: "light yellow"
                        }
                    },
                    State {
                        name: "precon 3"
                        PropertyChanges {
                            target: rect
                            color: "yellow"
                        }
                    },
                    State {
                        name: "precon 4"
                        PropertyChanges {
                            target: rect
                            color: "green"
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
            //The listView is populated by the elements in the names array from main.qml. Every object starts with state "bad".
            Component.onCompleted: {
                for (var i = 0; i < names.length; i++){
                    checklistModel.append({"name": names[i], "currentState": "bad"});
                }
            }
        }
    }
//for testing purposes
    Timer {
        id: timer
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            checklistModel.get(0).currentState = "precon 1"
            checklistModel.get(1).currentState = 'precon 2'
            checklistModel.get(5).currentState = 'precon 4'
            checklistModel.get(3).currentState = "precon 3"
        }
    }


}


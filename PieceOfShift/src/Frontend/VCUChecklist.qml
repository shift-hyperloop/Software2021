import QtQuick 2.15

Item {
    Rectangle {
        width: 200
        height: 200

        ListModel {
            id: checklistModel
        }

        Component {
            id: checklistDelegate
            Row {
                spacing: 10
                Text { text: name }
                Text { text: '$' + cost }
            }
        }

        ListView {
            anchors.fill: parent
            model: checklistModel
            delegate: checklistDelegate
        }
    }
    ListView {
        width: 180; height: 200

        Component {
            id: contactsDelegate
            Rectangle {
                id: wrapper
                width: 180
                height: contactInfo.height
                color: ListView.isCurrentItem ? "black" : "red"
                Text {
                    id: contactInfo
                    text: name + ": " + number
                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                }
            }
        }

        model: ContactModel {}
        delegate: contactsDelegate
        focus: true
    }

}

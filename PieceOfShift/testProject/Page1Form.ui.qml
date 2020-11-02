import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    id: test123
    width: 600
    height: 400

    title: qsTr("Page 1")

    Label {
        text: qsTr("You are on Page 1.")
        anchors.centerIn: parent
    }

    Button {
        id: button
        x: 266
        y: 248
        text: qsTr("CLICK ME")
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/


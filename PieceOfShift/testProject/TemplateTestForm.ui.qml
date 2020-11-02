import QtQuick 2.4
import QtQuick.Controls 2.15

Item {

    width: 640
    height: 480


    Button {
        anchors.centerIn: parent
        id: button
        text: qsTr("Press me")
        anchors.verticalCenterOffset: -116
        anchors.horizontalCenterOffset: 0
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/


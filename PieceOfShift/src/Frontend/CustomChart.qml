import QtQuick 2.0
import CustomPlot 1.0

Item {
    property alias ccrect: ccrect
    property alias chart: customPlot
    property var redirect: ""
    Rectangle {
        id: ccrect
        width: parent.width
        height: parent.height
        color: "#333333"


        Rectangle {
            id: customRect
            width: parent.width - 6
            height: parent.height - 6
            x: 3
            y: 3

            CustomPlotItem {
                id: customPlot
                anchors.fill: parent

            }
        }
        MouseArea{
            id: chartMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
            enabled: redirect !=""; // if redirect is set, the graph will redirect to the redirect variable which will be a qml page
            onClicked: {
                stackView.push(redirect);
            }
        }
    }
}

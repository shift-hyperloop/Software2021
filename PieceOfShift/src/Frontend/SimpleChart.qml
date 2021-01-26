import QtQuick 2.14
import QtCharts 2.3

Item {
    property alias y_axis: y_axis
    property alias x_axis: x_axis
    property alias chartview: chartview
    property alias lineseries: lineseries
    property alias chartWidth: chartview.width
    property alias chartHeight: chartview.height

    ChartView{
        id: chartview
        visible: true
        width: 10
        height: 10
        antialiasing: true
        backgroundColor: "transparent"
        titleColor: "white"
        property var x_max: x_axis.max
        property var y_max: y_axis.max

        MouseArea{
            id: chartMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
            onClicked: {
                stackView.push("MovementsDetailed.qml")
            }
        }

        LineSeries{
            id: lineseries
            axisX: x_axis
            axisY: y_axis
            pointsVisible: true
            useOpenGL: true

            ValueAxis{
                id: y_axis
                labelsColor: "white"
                color: "white"
                min: 0
                max: 10
                titleText: ""
            }
            ValueAxis{
                id: x_axis
                labelsColor: "white"
                color: "white"
                min: 0
                max: 10
                titleText: ""
            }

            onPointAdded: {
                var new_point = at(index)
                if(new_point.x > x_axis.max){
                    x_axis.max = new_point.x + Math.round(new_point.x/2)
                    chartview.x_max = x_axis.max
                }
                if(new_point.y > y_axis.max){
                    y_axis.max = new_point.y+ Math.round(new_point.y/2)
                    chartview.y_max = y_axis.max
                }
                if (new_point.y < y_axis.min) {
                    y_axis.min = new_point.y - Math.round(new_point.y/2)
                }
            }


        }
            Rectangle {
                id: rectangle1
                visible: false
                z: 1
                width: _text.width + 20
                height: 40
                color: "grey"
                radius: 50
                Text {
                    id: _text
                    text: qsTr("")
                    anchors.centerIn: parent
                }
            }
    }
}

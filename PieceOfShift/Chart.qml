import QtQuick 2.14
import QtCharts 2.3

Item {
    property alias y_axis: y_axis
    property alias x_axis: x_axis
    property alias chartview: chartview
    property alias lineseries: lineseries
    ChartView{
        id: chartview
        visible: true
        width:10
        height: 10
        MouseArea{
            id: chartMouseArea
            anchors.fill: parent
            hoverEnabled: true
            property var mouse_x: 0
            property var mouse_y: 0
            onEntered: {
                hoverEnabled = false
                parent.forceActiveFocus()
            }
            onExited: {
                hoverEnabled = true
            }
            onWheel: {
                if((wheel.angleDelta).y > 0){
                   var p = chartview.plotArea
                   var m = 1.25
                    chartview.zoomIn(Qt.rect(p.x,p.y + (p.height - p.height/m),p.width / m, p.height / m))
                }
                else{
                    p = chartview.plotArea
                    m = 3/4
                    chartview.zoomIn(Qt.rect(p.x ,p.y + (p.height - p.height/m),p.width / m, p.height / m))
                }
            }
            onPressed: {
                timer.mouse_x_= mouseX
                timer.mouse_y_= mouseY
                timer.start()
            }
            onReleased: {
                timer.stop()

            }
            Timer{
                id: timer
                repeat: true
                interval: 50
                property int mouse_x_: chartMouseArea.mouseX
                property int mouse_y_: chartMouseArea.mouseY
                onTriggered: {
                    chartview.scrollUp(chartMouseArea.mouseY - mouse_y_)
                    chartview.scrollLeft(chartMouseArea.mouseX - mouse_x_)
                    mouse_x_ = chartMouseArea.mouseX
                    mouse_y_ = chartMouseArea.mouseY
                }
            }

        }


        LineSeries{
            id: lineseries
            axisX: x_axis
            axisY: y_axis

            ValueAxis{
                id: y_axis
                min: 0
                max: 10
                titleText: ""
            }
            ValueAxis{
                id: x_axis
                min: 0
                max: 10
                titleText: ""
            }
            XYPoint { x: 0; y: 0 }
            XYPoint { x: 1.1; y: 2.1 }
            XYPoint { x: 1.9; y: 3.3 }
            XYPoint { x: 2.1; y: 2.1 }
            XYPoint { x: 2.9; y: 4.9 }
            XYPoint { x: 3.4; y: 3.0 }
            XYPoint { x: 4.1; y: 3.3 }
            onHovered: {
                //
                var punkt = "(" + point.x.toFixed(2) + "," + point.y.toFixed(2) + ")"
                _text.text = punkt
                var p = chartview.mapToPosition(Qt.point(point.x,point.y),lineseries)
                rectangle1.x = p.x
                rectangle1.y = p.y
            }
            onPointAdded: {
                var new_point = at(index)
                if(new_point.x > x_axis.max){
                    x_axis.max*=1.5
                }
                if(new_point.y > y_axis.max){
                    y_axis.max*=1.5
                }
            }


        }
            Rectangle {
                id: rectangle1
                visible: parent.activeFocus
                z: 1
                width: _text.width + 20
                height: 40
                color: "grey"
                radius:50
                Text {
                    id: _text
                    text: qsTr("")
                    anchors.centerIn: parent
                }
            }

            Keys.onLeftPressed: {
                chartview.scrollLeft(100)
            }
            Keys.onRightPressed: {
                chartview.scrollRight(100)
            }
            Keys.onUpPressed: {
                chartview.scrollUp(100)
            }
            Keys.onDownPressed: {
                chartview.scrollDown(100)
                lineseries.append(10,15)
            }
    }
}

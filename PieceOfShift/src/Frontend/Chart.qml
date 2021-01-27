import QtCharts 2.3
import QtQuick 2.14
import QtQuick.Controls 2.5
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
            property var mouse_x: 0
            property var mouse_y: 0
            onEntered: { //mouseare has the signal onEntered which is needed to change the focus to the chart
                hoverEnabled = false    //without active focus the chart wont handle hover events
                parent.forceActiveFocus() //Two elements in the same place cant both accept hover events, so disable hover for the mousearea
            }
            onExited: {
                hoverEnabled = true // enable hover to detect when the mouse enteres
            }
            onWheel: {
                if((wheel.angleDelta).y > 0){
                   var p = chartview.plotArea
                   var zoom = 4/3
                    chartview.zoomIn(Qt.rect(p.x,p.y + (p.height - p.height/zoom),p.width / zoom, p.height / zoom))
                }// create a rectangle, and make the visable area in the chartview the same size as the rectangle
                else{
                    p = chartview.plotArea
                    zoom = 0.75
                    chartview.zoomIn(Qt.rect(p.x ,p.y + (p.height - p.height/zoom),p.width / zoom, p.height / zoom))
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
                interval: 1
                property int mouse_x_: chartMouseArea.mouseX
                property int mouse_y_: chartMouseArea.mouseY
                onTriggered: {
                    chartview.scrollUp(chartMouseArea.mouseY - mouse_y_) // move the visable area of the graph according to how much you have moved the mouse
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

            //Note: the hovered rectangle will never disappear after having showed. Can fix later by using a QML Timer-object
            onHovered: { // display the point you're hovering over on the chart by setting the content of rectangle1 to the hovered point
                _text.text = "(" + point.x.toFixed(2) + "," + point.y.toFixed(2) + ")";
                var p = chartview.mapToPosition(Qt.point(point.x,point.y),lineseries);
                rectangle1.visible = true;
                rectangle1.x = p.x; //make the displayed point follow the mouse
                rectangle1.y = p.y;
            }

            onPointAdded: {
                var new_point = at(index)
                if(new_point.x > x_axis.max){ // if a now point is added and it is outside the visible area, the axes will scale
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

        Keys.onLeftPressed: {
            chartview.scrollLeft(x_axis.max)
        }
        Keys.onRightPressed: {
            chartview.scrollRight(x_axis.max)
        }
        Keys.onUpPressed: {
            chartview.scrollUp(y_axis.max)
        }
        Keys.onDownPressed: {
            chartview.scrollDown(y_axis.max)
        }

    }
}

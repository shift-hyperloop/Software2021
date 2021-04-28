import QtQuick 2.0
import QtQuick.Controls 2.5
Page {
    id: inverterPage
    Button{
        text: "Go back"
        x: window.width * 0.01
        y: 0.05 * window.height
        height: window.height * 0.07
        width: window.width * 0.07
        font.pixelSize: window.height * 0.02
        onClicked: {
           stackView.pop(null);
        }
    }
    Chart3D{
        id: chart3d
        width: window.width / 1.5
        height: window.height / 1.2
        anchors.centerIn: parent
        colorArray: ["red","green","blue", "yellow"]
        Component.onCompleted: {
           var values = [
           [1,2,3],[4,4,4],[2,2,2],[3,2,1]
           ]
           addData(values)
        }
    }
    Timer{
        id: chartTimer
        interval: 500
         running: true
         repeat: true
         onTriggered: update();
         function update(){
             var values = [
                         [(Math.random()*2-1).toFixed(3),(Math.random()*2-1).toFixed(3),(Math.random()*2-1).toFixed(3)],
                         [(Math.random()*2-1).toFixed(3),(Math.random()*2-1).toFixed(3),(Math.random()*2-1).toFixed(3)],
                         [(Math.random()*2-1).toFixed(3),(Math.random()*2-1).toFixed(3),(Math.random()*2-1).toFixed(3)],
                         [(Math.random()*2-1).toFixed(3),(Math.random()*2-1).toFixed(3),(Math.random()*2-1).toFixed(3)]
                     ]
             chart3d.addData(values)
         }
    }
    Repeater{
        model: 4
        Rectangle{
            color: chart3d.colorArray[index]
            width: window.width / 35
            height: width
            radius: width
            x: chart3d.width*1.1
            y: window.height * 0.1 * (index+2)
            border.width: 1
        }
    }
    Repeater{
        model: 4
        Text {
            text: qsTr("Accelerometer " + String(index + 1))
            x: chart3d.width*1.2
            y: window.height * 0.1 * (index+2) + window.height * 0.01
            font.pixelSize: window.height * 0.02
            color: "grey"
        }
    }
}

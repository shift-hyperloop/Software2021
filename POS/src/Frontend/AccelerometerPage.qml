import QtQuick 2.0
import QtQuick.Controls 2.5
Page {
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
        axisMax: 5
        axisMin: -5
        anchors.centerIn: parent
        colorArray: ["red","green","blue", "yellow"]
        Component.onCompleted: {
           var values = [
               [1,2,3],
               [4,4,4],
               [2,2,2],
               [3,2,1]
           ]
           addData(values) // function for adding points to the chart
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

}

import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Shapes 1.15
import QtQuick.Controls 2.5
Item {
    property alias connection: shapeRect.connection
    Rectangle{
        id: shapeRect
        color: "#373840"
        anchors.fill: parent
        property var connection

        Shape {
           ShapePath{
               strokeColor: shapeRect.connection > 0 ? "lightgray" : "black"
               strokeWidth: shapeRect.width/10
               startX: (shapeRect.width * 0.9) * 1/4
               startY: shapeRect.height*0.9
               PathLine { x: (shapeRect.width * 0.9) * 1/4; y: shapeRect.height*3/4}
           }
        }
        Shape {
           ShapePath{
               strokeColor: shapeRect.connection > 1 ? "lightgray" : "black"
               strokeWidth: shapeRect.width/10
               startX: (shapeRect.width * 0.9) * 2/4
               startY: shapeRect.height*0.9
               PathLine { x: (shapeRect.width * 0.9) * 2/4; y: shapeRect.height*2/4 }
           }
        }
        Shape {
           ShapePath{
               strokeColor: shapeRect.connection > 2 ? "lightgray" : "black"
               strokeWidth: shapeRect.width/10
               startX: (shapeRect.width * 0.9) * 3/4
               startY: shapeRect.height*0.9
               PathLine { x: (shapeRect.width * 0.9) * 3/4; y: shapeRect.height * 1/4}
           }
        }
        Shape {
           ShapePath{
               strokeColor: shapeRect.connection > 3 ? "lightgray" : "black"
               strokeWidth: shapeRect.width/10
               startX: (shapeRect.width * 0.9)
               startY: shapeRect.height*0.9
               PathLine { x:(shapeRect.width * 0.9); y: shapeRect.height*0.1 }
           }
        }
    }

}

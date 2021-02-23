import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Shapes 1.15
import QtQuick.Controls 2.5
Item {
    property alias connection: shapeRect.connection
    Rectangle{
        id: shapeRect
        color: "grey"
        height: width
        x: 0
        y: 0
        property var connection: 3

        Shape {
           ShapePath{
               strokeColor: shapeRect.connection > 0 ? "black" : "lightgray"
               strokeWidth: shapeRect.width/10
               startX: (shapeRect.width * 0.9) * 1/4
               startY: shapeRect.height*0.9
               PathLine { x: (shapeRect.width * 0.9) * 1/4; y: shapeRect.height*3/4}
           }
        }
        Shape {
           ShapePath{
               strokeColor: shapeRect.connection > 1 ? "black" : "lightgray"
               strokeWidth: shapeRect.width/10
               startX: (shapeRect.width * 0.9) * 2/4
               startY: shapeRect.height*0.9
               PathLine { x: (shapeRect.width * 0.9) * 2/4; y: shapeRect.height*2/4 }
           }
        }
        Shape {
           ShapePath{
               strokeColor: shapeRect.connection > 2 ? "black" : "lightgray"
               strokeWidth: shapeRect.width/10
               startX: (shapeRect.width * 0.9) * 3/4
               startY: shapeRect.height*0.9
               PathLine { x: (shapeRect.width * 0.9) * 3/4; y: shapeRect.height * 1/4}
           }
        }
        Shape {
           ShapePath{
               strokeColor: shapeRect.connection > 3 ? "black" : "lightgray"
               strokeWidth: shapeRect.width/10
               startX: (shapeRect.width * 0.9)
               startY: shapeRect.height*0.9
               PathLine { x:(shapeRect.width * 0.9); y: shapeRect.height*0.1 }
           }
        }
    }

}

import QtQuick 2.12
import QtQuick.Shapes 1.15

Item {
    property alias color: shape.fillColor
    anchors.fill: parent
Shape {
    id: semi
    property var radius: width / 2
    anchors.fill: parent
    layer.enabled: true
    layer.samples: 4

    ShapePath {
        id: shape
        fillColor: "blue"
        strokeColor: "blue"
        capStyle: ShapePath.FlatCap

        PathAngleArc {
            centerX: width/2; centerY: height / 2
            radiusX: semi.radius; radiusY: semi.radius
            startAngle: 180
            sweepAngle: 180
        }

    }
    ShapePath {
        id: shape2
        fillColor: "transparent"
        strokeColor: "lightgrey"
        capStyle: ShapePath.FlatCap
        PathAngleArc {
            centerX: width/2; centerY: height / 2
            radiusX: semi.radius; radiusY: semi.radius
            startAngle: 180
            sweepAngle: 360
        }
    }
   ShapePath{
       strokeColor: "white"
       startX: width / 3
       startY: height / 2
       PathLine { x: width * 2 / 3; y: height / 2 }
   }
}
}

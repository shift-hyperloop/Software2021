import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("PieceOfShift")

    StackView {
        id: stackView
        initialItem: mainView
        anchors.fill: parent
    }

    Item {
        id: mainView;
        property alias component1: component1;
        property alias component2: component2;
        property alias simpleChart: simpleChart;
        property alias counter: simpleChart.counter;

        ExampleComponent {
            id: component1
            x_choord: 0
            y_choord: 0
        }

        ExampleComponent {
            id: component2
            x_choord: component1.width_
            y_choord: 0
        }

        SimpleChart {
            id: simpleChart
            x: component1.x + 10
            y: component1.y + component1.height + 10
            chartview.title: "Simple chart example"
            chartview.height: 250
            chartview.width: 250
            chartview.theme: "ChartThemeDark"
            property var counter: 5;
            /*
              The following function is called when the component (i.e. page) is loaded.
              It will then iterate through the points from the detailed graph (in main.qml)
              and add all those points to this graph.
            */
            Component.onCompleted: {
                for (let i = 0; i < detailedChart.lineseries.count; i++) {
                    let x_point = detailedChart.lineseries.at(i).x;
                    let y_point = detailedChart.lineseries.at(i).y;
                    simpleChart.lineseries.append(x_point, y_point);
                }
            }

            //Timer for simulating continously updated points
            Timer {
                running: true; repeat: true; interval: 1000;
                onTriggered: {
                    parent.lineseries.append(parent.counter, parent.counter);
                    parent.counter++;
                }
            }
        }

    }
}

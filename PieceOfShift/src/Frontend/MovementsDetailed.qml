import QtQuick 2.12
import QtQuick.Controls 2.15


Page {

    id: page
    property alias detailedChart: detailedChart;
    Keys.onPressed: { //If backspace is pressed => go back to previous page
        if (event.key === 16777219) {
            stackView.pop("main.qml");
        }
        /*
          onBackPressed should ideally work as above, but it doesn't, so it'll have to be done
          manually (although it's quite simple, so it's not too bad).
          */
    }

    //Buttons for resetting the graph-axis or going back to previous page
    Button{
        id: but1
        text: "Reset Graph Axes"
        x: 0
        // This y-value corresponds to the y-value of the MenuBar in CustomMenuBar.qml
        y: 0.05 * window.height
        onClicked: {
            // reset the zoom
            detailedChart.x_axis.min = 0
            detailedChart.y_axis.min = 0
            //detailedChart.x_axis.max = detailedChart.x_max
            //detailedChart.y_axis.max = detailedChart.y_max
        }
    }
    Button {
        id: but2
        text: "Previous Page"
        x: but1.x + but1.width
        y: but1.y
        onClicked: {
            stackView.pop("main.qml");
        }
    }

    Chart {
        id: detailedChart
        x: 0
        y: but1.y + but1.height
        chartview.width: window.width - 100
        chartview.height: window.height - but1.height - but1.y
        /*
          The following function is called when the component (i.e. page) is loaded.
          It will then iterate through the points from the previous graph (in main.qml)
          and add all those points to this graph.
        */
        Component.onCompleted: {
            let prv_graph = mainView.chart;
            for (let i = 0; i < prv_graph.lineseries.count; i++) {
                let x_point = prv_graph.lineseries.at(i).x
                let y_point = prv_graph.lineseries.at(i).y
                detailedChart.lineseries.append(x_point, y_point);
            }
        }


        //Timer for simulating continously updated points
        Timer {
            running: mainView.timer.running; repeat: true; interval: 200;
            onTriggered: {
                update(detailedChart, mainView.counter);
            }

            function update(chart, globalCounter) {
                var distance = (Math.random() * 0.03) + 0.1;
                var speed = (distance * 50) / 0.02;
                globalCounter++;
                chart.lineseries.append(globalCounter, speed)
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

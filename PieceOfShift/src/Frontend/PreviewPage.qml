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

    Chart {
        id: detailedChart
        x: 0
        y: 0
        chartview.width: window.width - 100
        chartview.height: window.height
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

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

    Label {
        id: label
        text: qsTr("This is an example page with an example chart.")
    }
    Button {
        onClicked: stackView.pop("main.qml")
        x: detailedChart.chartview.x
        y: detailedChart.chartview.height + 20
        text: qsTr("Previous page")
        font.capitalization: Font.MixedCase
    }

    Chart {
        id: detailedChart
        x: label.x + 10
        y: label.y + label.height + 10
        chartview.width: 400
        chartview.height: 400
        chartview.theme: "ChartThemeDark"
        /*
          The following function is called when the component (i.e. page) is loaded.
          It will then iterate through the points from the previous graph (in main.qml)
          and add all those points to this graph.
        */
        Component.onCompleted: {
            let prv_graph = mainView.simpleChart;
            for (let i = 0; i < prv_graph.lineseries.count; i++) {
                let x_point = prv_graph.lineseries.at(i).x
                let y_point = prv_graph.lineseries.at(i).y
                detailedChart.lineseries.append(x_point, y_point);
            }
        }


        //Timer for simulating continously updated points
        Timer {
            running: true; repeat: true; interval: 1000;
            onTriggered: {
                let increment = mainView.counter;
                parent.lineseries.append(increment, increment);
                increment++;
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

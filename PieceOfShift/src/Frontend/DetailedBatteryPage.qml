import QtQuick 2.0
import QtQuick.Controls 2.15

Item {

    id: detailedBatteryPage
    property alias chart1: chart1;
    property alias chart2: chart2;
    property alias chart3: chart3;
    property alias chart4: chart4;
    property alias chart5: chart5;
    property alias chart6: chart6;

    //If backspace is pressed => go back to previous page
    Keys.onPressed: {
        if (event.key === 16777219) {
            stackView.pop("main.qml");
        }
    }

    function update(allLineseries, globalCounter) {
        globalCounter++;
        for (let i = 0; i < allLineseries.length; i++) {
            allLineseries[i].append(globalCounter++, (i+1) * 5);
        }
    }

    function resetChartAxes(charts) {
        charts.forEach(chart => {
            const currentLineseries = chart.lineseries;
            chart.x_axis.min = 0;
            chart.y_axis.min = 0;
            chart.x_axis.max = currentLineseries.at(currentLineseries.length - 1).x - 20;
            chart.y_axis.max = currentLineseries.at(currentLineseries.length - 1).y - 40;
        });
    }

    Rectangle {
        id: rect1
        y: 0.05 * window.height
        x: 0
        width: window.width/2
        height: 30
        border.color: "black"
        border.width: 2
        radius: 4
        color: "transparent"

        Text {
            id: voltageSum
            text: qsTr("Sum of Voltages: :)")
            color: "white"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rect2
        y: rect1.y
        x: rect1.width
        width: window.width / 2
        height: 30
        border.color: "black"
        border.width: 2
        radius: 4
        color: "transparent"

        Text{
            id: ambientTemp
            text: qsTr("Ambient temperature: :)")
            color: "white"
            anchors.centerIn: parent
        }
    }



    Button {
        id: but1
        text: "Reset Graph"
        x: 0
        // This y-value corresponds to the y-value of the MenuBar in CustomMenuBar.qml
        y: rect1.y + rect1.height
        onClicked: {
            const charts = [chart2, chart3, chart4, chart5, chart6];
            resetChartAxes(charts);
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


    //This is the amount of vertical height that's "left" when taking elements above into account
    property var remainingWindowHeight: window.height - 0.05 * window.height - but1.height - rect1.height

    MultiLineChart {
        id: chart1
        x: 0
        y: but1.y + but1.height
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(remainingWindowHeight / 3)
        // Voltages? Idk ask Bendik
        lineseries1.name: "<font color='white'>V1</font>"
        lineseries2.name: "<font color='white'>V2</font>"
        lineseries3.name: "<font color='white'>V3</font>"
        x_axis.titleText: "<font color='white'>Time</font>"
        y_axis.titleText: "<font color='white'>Voltage</font>"


        //Timer for simulating continously updated points
        Timer {
            running: mainView.timer.running; repeat: true; interval: 50;
            onTriggered: {
                // allLineseries is a variable in MultiLineChart.qml which is a list of every LineSeries, e.g.
                // all the individual lines on the actual graph. So we update every line in the same graph
                update(chart1.allLineseries, mainView.counter);
                //update(chart2, mainView.counter);
                //update(chart3, mainView.counter);
                //update(chart4, mainView.counter);
                //update(chart5, mainView.counter);
                //update(chart6, mainView.counter);
            }
        }
    }

    Chart {
        id: chart2
        x: chart1.chartview.width
        y: but1.y + but1.height
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(remainingWindowHeight / 3)
        x_axis.titleText: "<font color='white'>Time</font>"
        y_axis.titleText: "<font color='white'>Temperature</font>"


        //Timer for simulating continously updated points
        Timer {
            running: mainView.timer.running; repeat: true; interval: 200;
            onTriggered: {
            }
        }
    }

    Chart {
        id: chart3
        x: 0
        y: chart1.y + chart1.chartview.height
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(remainingWindowHeight / 3)
        x_axis.titleText: "<font color='white'>Time</font>"
        y_axis.titleText: "<font color='white'>Blabla</font>"


        //Timer for simulating continously updated points
        Timer {
            running: mainView.timer.running; repeat: true; interval: 200;
            onTriggered: {
            }

        }
    }

    Chart {
        id: chart4
        x: chart1.chartview.width
        y: chart1.y + chart1.chartview.height
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(remainingWindowHeight / 3)
        x_axis.titleText: "<font color='white'>TBD</font>"
        y_axis.titleText: "<font color='white'>TBD</font>"


        //Timer for simulating continously updated points
        Timer {
            running: mainView.timer.running; repeat: true; interval: 200;
            onTriggered: {
            }

        }
    }

    Chart {
        id: chart5
        x: 0
        y: chart1.y + chart1.chartview.height + chart3.chartview.height
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(remainingWindowHeight / 3)
        x_axis.titleText: "<font color='white'>TBD</font>"
        y_axis.titleText: "<font color='white'>TBD</font>"


        //Timer for simulating continously updated points
        Timer {
            running: mainView.timer.running; repeat: true; interval: 200;
            onTriggered: {
            }

        }
    }

    Chart {
        id: chart6
        x: chart1.chartview.width
        y: chart1.y + chart1.chartview.height + chart3.chartview.height
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(remainingWindowHeight / 3)
        x_axis.titleText: "<font color='white'>TBD</font>"
        y_axis.titleText: "<font color='white'>TBD</font>"


        //Timer for simulating continously updated points
        Timer {
            running: mainView.timer.running; repeat: true; interval: 200;
            onTriggered: {
            }

        }
    }

}

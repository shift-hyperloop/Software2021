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

    function update(chart, globalCounter) {
        var distance = (Math.random() * 0.03) + 0.1;
        var speed = (distance * 50) / 0.02;
        globalCounter++;
        chart.lineseries.append(globalCounter, speed)
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

    Button {
        id: but1
        text: "Reset Graph"
        x: 0
        // This y-value corresponds to the y-value of the MenuBar in CustomMenuBar.qml
        y: 0.05 * window.height
        onClicked: {
            const charts = [chart1, chart2, chart3, chart4, chart5, chart6];
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


    //This is the amount of vertical height that's "left" when taking buttons and menu-bar into account
    property var remainingWindowHeight: window.height - 0.05 * window.height - but1.height

    Chart {
        id: chart1
        x: 0
        y: 0.05 * window.height + but1.height
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(remainingWindowHeight / 3)


        //Timer for simulating continously updated points
        Timer {
            running: mainView.timer.running; repeat: true; interval: 200;
            onTriggered: {
                update(chart1, mainView.counter);
                update(chart2, mainView.counter);
                update(chart3, mainView.counter);
                update(chart4, mainView.counter);
                update(chart5, mainView.counter);
                update(chart6, mainView.counter);
            }
        }
    }

    Chart {
        id: chart2
        x: chart1.chartview.width
        y: 0.05 * window.height + but1.height
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(remainingWindowHeight / 3)


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


        //Timer for simulating continously updated points
        Timer {
            running: mainView.timer.running; repeat: true; interval: 200;
            onTriggered: {
            }

        }
    }

}

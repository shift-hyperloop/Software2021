import QtQuick 2.0

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

    Chart {
        id: chart1
        x: 0
        y: 0
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(window.height / 3)


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
        y: 0
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(window.height / 3)


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
        y: chart1.chartview.height
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(window.height / 3)


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
        y: chart1.chartview.height
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(window.height / 3)


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
        y: chart1.chartview.height + chart3.chartview.height
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(window.height / 3)


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
        y: chart1.chartview.height + chart3.chartview.height
        chartview.width: Math.floor(window.width / 2)
        chartview.height: Math.floor(window.height / 3)


        //Timer for simulating continously updated points
        Timer {
            running: mainView.timer.running; repeat: true; interval: 200;
            onTriggered: {
            }

        }
    }

}

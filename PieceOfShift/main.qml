import QtQuick 2.12
import QtQuick.Controls 2.5
import QtCharts 2.3
import shift.datamanagement 1.0

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("PieceOfShift")

    DataManager {
        id: manager
        onNewVelocity: {
            lineSeries.append(velocity.x, velocity.y)
            chartView.title = name
        }
    }

    Timer {
        id: timer
        repeat: true
        interval: 1
        onTriggered: {
            manager.dummyData();
        }

    }

    ChartView {
            id: chartView
            theme: ChartView.ChartThemeBlueCerulean
            backgroundColor: "#2b2b2b"
            titleColor: "white"
            width: 1000
            height: 500
            y: 100
            antialiasing: true

            ValueAxis {
                id: xAxis
                min: 0
                max: 1000
                tickCount: 11
                labelFormat: "%d"
            }

            ValueAxis {
                id: yAxis
                min: 0
                max: 100
                tickCount: 11
                labelFormat: "%d"
            }

            LineSeries {
                axisX: xAxis
                axisY: yAxis
                id: lineSeries
                useOpenGL: true
                name: "Data"
            }
        }

    Text {
        id: labelText
        color: "white"
        width: 300
        height: 100
    }

    Button {
        id: startThread
        text: "Start"
        onClicked: {
            timer.start()
        }
    }

    Button {
        id: stopThread
        text: "Stop"
        x: 200
        onClicked: {
            timer.stop()
        }
    }

    Button {
        id: clearGraph
        text: "Clear"
        x: 100
        onClicked: {
            lineSeries.clear()
        }
    }
}

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
            console.log(v.x, v.y)
            lineSeries.append(v.x, v.y)
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

            ValueAxis {
                id: xAxis
                min: 800
                max: 1200
                tickCount: 10
                labelFormat: "%d"
            }

            ValueAxis {
                id: yAxis
                min: 5000
                max: 40000
                tickCount: 10
                labelFormat: "%d"
            }

            LineSeries {
                axisX: xAxis
                axisY: yAxis
                id: lineSeries
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
        }
    }

    Timer {
        id: timer
        interval: 500; running: true; repeat: true
        onTriggered: {

        }
    }
}

import QtQuick 2.0
import QtQuick.Controls 2.15

Page {

    id: detailedBatteryPage
    background: Rectangle{color: "#333333"} // background color for subpages

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

    Component.onDestruction:  {
            chart1.chart.remove();
            chart2.chart.remove();
            chart3.chart.remove();
            chart4.chart.remove();
            chart5.chart.remove();
            chart6.chart.remove();
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
        id: but2
        text: "Go back"
        anchors {
            top: rect1.bottom
            left: rect1.left
            margins: 5
        }
        height: 0.5 * y
        width: window.width * 0.07
        font.pixelSize: window.height * 0.02
        onClicked: {
            stackView.pop("main.qml");
        }
    }

    //This is the amount of vertical height that's "left" when taking elements above into account
    property var remainingWindowHeight: window.height - 0.05 * window.height - but2.height - rect1.height

    CustomChart {
        id: chart1
        width: Math.floor(window.width / 2)
        height: Math.floor(remainingWindowHeight / 3)
        anchors.left: parent.left
        anchors.top: but2.bottom
        anchors.margins: 5
        property var counter: 0
        Component.onCompleted: {
            chart.initCustomPlot(3);
            chart.setGraphColor(0, "#2674BB");
            chart.setGraphColor(1, "#AE3328");
            chart.setGraphColor(2, "#FC37AB");
            chart.setGraphName(0,"Voltage1");
            chart.setGraphName(1,"Voltage2");
            chart.setGraphName(2,"Voltage3");
            chart.setAxisLabels("Time","Voltage")
            chart.setAxisRange(Qt.point(0, 500), Qt.point(0, 300));
        }
    }

    CustomChart {
        id: chart2
        width: Math.floor(window.width / 2)
        height: Math.floor(remainingWindowHeight / 3)
        anchors.top: but2.bottom
        anchors.left: chart1.right
        property var counter: 0
        Component.onCompleted: {
            chart.initCustomPlot(3);
            chart.setGraphColor(0, "#2674BB");
            chart.setGraphColor(1, "#AE3328");
            chart.setGraphColor(2, "#FC37AB");
            chart.setGraphName(0,"Voltage1");
            chart.setGraphName(1,"Voltage2");
            chart.setGraphName (2,"Voltage3");
            chart.setAxisLabels("Time","Voltage")
            chart.setAxisRange(Qt.point(0, 800), Qt.point(0, 300));
        }
    }

    CustomChart {
        id: chart3
        width: Math.floor(window.width / 2)
        height: Math.floor(remainingWindowHeight / 3)
        anchors.top: chart1.bottom
        anchors.left: parent.left
        property var counter: 0
        Component.onCompleted: {
            chart.initCustomPlot(3);
            chart.setGraphColor(0, "#2674BB");
            chart.setGraphColor(1, "#AE3328");
            chart.setGraphColor(2, "#FC37AB");
            chart.setGraphName(0,"Voltage1");
            chart.setGraphName(1,"Voltage2");
            chart.setGraphName(2,"Voltage3");
            chart.setAxisLabels("Time","Voltage")
            chart.setAxisRange(Qt.point(0, 1500), Qt.point(0, 300));
        }
    }
    
    CustomChart {
        id: chart4
        width: Math.floor(window.width / 2)
        height: Math.floor(remainingWindowHeight / 3)
        anchors.top: chart2.bottom
        anchors.left: chart3.right
        property var counter: 0
        Component.onCompleted: {
            chart.initCustomPlot(3);
            chart.setGraphColor(0, "#2674BB");
            chart.setGraphColor(1, "#AE3328");
            chart.setGraphColor(2, "#FC37AB");
            chart.setGraphName(0,"Voltage1");
            chart.setGraphName(1,"Voltage2");
            chart.setGraphName(2,"Voltage3");
            chart.setAxisLabels("Time","Voltage")
            chart.setAxisRange(Qt.point(0, 600), Qt.point(0, 300));
        }
    }

    CustomChart {
        id: chart5
        width: Math.floor(window.width / 2)
        height: Math.floor(remainingWindowHeight / 3)
        anchors.top: chart3.bottom
        anchors.left: parent.left
        property var counter: 0
        Component.onCompleted: {
            chart.initCustomPlot(3);
            chart.setGraphColor(0, "#2674BB");
            chart.setGraphColor(1, "#AE3328");
            chart.setGraphColor(2, "#FC37AB");
            chart.setGraphName(0,"Voltage1");
            chart.setGraphName(1,"Voltage2");
            chart.setGraphName(2,"Voltage3");
            chart.setAxisLabels("Time","Voltage")
            chart.setAxisRange(Qt.point(0, 300), Qt.point(0, 300));
        }
    }

    CustomChart {
        id: chart6
        width: Math.floor(window.width / 2)
        height: Math.floor(remainingWindowHeight / 3)
        anchors.top: chart4.bottom
        anchors.left: chart5.right
        property var counter: 0
        Component.onCompleted: {
            chart.initCustomPlot(3);
            chart.setGraphColor(0, "#2674BB");
            chart.setGraphColor(1, "#AE3328");
            chart.setGraphColor(2, "#FC37AB");
            chart.setGraphName(0,"Voltage1");
            chart.setGraphName(1,"Voltage2");
            chart.setGraphName(2,"Voltage3");
            chart.setAxisLabels("Time","Voltage")
            chart.setAxisRange(Qt.point(0, 100), Qt.point(0, 300));
        }
    }

}

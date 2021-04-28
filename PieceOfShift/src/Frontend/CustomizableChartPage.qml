import QtQuick.Controls 2.15
import QtQuick 2.12
import QtQuick.Dialogs 1.3
import CustomPlot 1.0
import shift.datamanagement 1.0

Page {
    id: item
    background: Rectangle{color: "#333333"} // background color for subpages

    Keys.onPressed: { //If backspace is pressed => go back to previous page
        if (event.key === 16777219) {
            stackView.pop("main.qml");
        }
        /*
          onBackPressed should ideally work as above, but it doesn't, so it'll have to be done
          manually (although it's quite simple, so it's not too bad).
          */
    }

    DataManagerAccessor {
        id: dmAccessor

        dataManager.onNewDataName: {
            listModel.append({"text": name, "color": "red"})
        }
    }
    
    CustomChart {
        id: ccChart
        x: 50
        y: 100
        width: window.width - 100
        height: window.height * 0.8
        property var counter: 0
        Component.onCompleted: {
            chart.initCustomPlot(0);
        }
    }

    ComboBox {
        id: dropDown
        width: window.width * 0.1
        height: window.height * 0.05
        y: window.height * 0.8 + 150
        x: 100
        textRole: "text"
        valueRole: "value"

        model: ListModel {
            id: listModel        
        }

        Component.onCompleted: {
            var names = dmAccessor.dataManager.getAllDataNames();
            names.forEach(appendItem);

            function appendItem(item, index) {
                listModel.append({"text": item, "color": "white"});
            } 
        }
    } 

    ColorDialog {
        id: colorDialog
    }

    Button {
        id: colorChoose
        width: window.width * 0.1
        height: window.height * 0.05
        y: window.height * 0.8 + 150
        x: 120 + dropDown.width
        text: "Pick color..."

        onClicked: {
            colorDialog.open()
        }
    }

    Rectangle {
        id: colorDisp
        color: colorDialog.color

        width: window.height * 0.05 - 10
        height: width
        y: window.height * 0.8 + 155
        x: 140 + dropDown.width * 2
    }

    Button {
        id: addButton
        width: window.width * 0.1
        height: window.height * 0.05
        y: window.height * 0.8 + 150
        x: window.width * 0.4 + 10
        text: "Add Graph"

        onClicked: {
            var graphIndex = ccChart.chart.addGraph();
            ccChart.chart.setGraphColor(graphIndex, colorDialog.color);
            ccChart.chart.setGraphName(graphIndex, dropDown.currentText);
            graphType.currentText == "Line" ? ccChart.chart.setDotVisibility(false, graphIndex) : ccChart.chart.setDotVisibility(true, graphIndex);
            graphType.currentText == "Scatter" ? ccChart.chart.setLineVisibility(false, graphIndex) : ccChart.chart.setLineVisibility(true, graphIndex) ;

            ccChart.chart.replot();
        }

    }

    Button {
        id: reset
        width: window.width * 0.1
        height: window.height * 0.05
        y: window.height * 0.8 + 150
        x: window.width * 0.8
        text: "Reset"

        onClicked: {
            ccChart.chart.initCustomPlot(0)
        }
    }

    ComboBox {
        id: graphType
        width: window.width * 0.1
        height: window.height * 0.05
        y: window.height * 0.8 + 150
        x: colorDisp.width + dropDown.width * 2 + 160
        textRole: "text"
        valueRole: "value"

        model: ListModel {
            id: graphTypes   
            ListElement {text: "Line"}
            ListElement {text: "LineDot"}
            ListElement {text: "Scatter"}
        }
    } 

}
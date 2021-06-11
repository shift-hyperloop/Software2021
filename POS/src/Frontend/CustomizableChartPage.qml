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

    }
    
    CustomChart {
        id: ccChart
        x: 50
        y: window.height * 0.15
        width: window.width - 100
        height: window.height * 0.8
        property var counter: 0
        Component.onCompleted: {
            chart.initCustomPlot(0);
        }
    }
    ListModel{
        id: allData
    }

    ComboBox {
        id: dropDown
        width: inputRect.width
        height: window.height * 0.05
        anchors.top: inputRect.bottom
        anchors.topMargin: window.height * 0.01
        anchors.left: inputRect.left
        textRole: "text"
        valueRole: "value"
        visible: input.activeFocus
        model: ListModel {
            id: tempData
        }
        Component.onCompleted: {
            var names = dmAccessor.dataManager.getAllDataNames();
            names.forEach(appendItem);

            function appendItem(item, index) {
                allData.append({"text": item, "color": "white"});
            } 
            for( var i = 0; i < allData.rowCount(); i++ ) {
                tempData.append(allData.get(i))
            }
        }
        onActivated: visible = false
    } 

    Rectangle{
        color: "lightgray"
        id: inputRect
        width: input.width
        height: input.height
        border.width: 2
        anchors.left: ccChart.left
        anchors.leftMargin: window.width * 0.02
        anchors.verticalCenter: colorChoose.verticalCenter
        TextInput {
            id: input
            text: dropDown.currentText
            padding: 5
            bottomPadding: 0
            selectByMouse : true
            height: window.height * 0.04
            width: window.width / 6
            font.pixelSize: window.height / 40
            onFocusChanged: {
                if(!dropDown.activeFocus || input.activeFocus || inputRect.activeFocus){
                    dropDown.visible = false
                }


            }

            onDisplayTextChanged: {
                if(text != dropDown.currentText || text == ""){
                    if(dropDown.currentIndex >=0){
                        dropDown.currentIndex = -1
                    }

                    dropDown.visible = true
                    tempData.clear()
                    for( var i = 0; i < allData.rowCount(); i++ ) {
                        var dataName = (allData.get(i).text).toLowerCase()
                        if(dataName.includes(input.text.toLowerCase())){
                            tempData.append(allData.get(i))
                        }
                    }
                    dropDown.popup.open()
                }
            }
        }
    }
    Button {
        id: openDropdown
        width: window.width * 0.02
        height: window.height * 0.05
        y: window.height * 0.07
        anchors.left: inputRect.right
        anchors.leftMargin: window.width * 0.01
        text: "▼"

        onClicked: {
            dropDown.popup.open()
        }
    }

    ColorDialog {
        id: colorDialog
    }

    Button {
        id: colorChoose
        width: window.width * 0.1
        height: window.height * 0.05
        y: window.height * 0.07
        anchors.left: openDropdown.right
        anchors.leftMargin: window.width * 0.02
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
        anchors.verticalCenter: colorChoose.verticalCenter
        anchors.left: colorChoose.right
        anchors.leftMargin: window.width * 0.01
    }

    Button {
        id: addButton
        width: window.width * 0.1
        height: window.height * 0.05
        y: window.height * 0.07
        anchors.left: graphType.right
        anchors.leftMargin: window.width * 0.02
        text: "Add Graph"

        onClicked: {
            if(dropDown.currentIndex >=0){
                var graphIndex = ccChart.chart.addGraph();
                ccChart.chart.setGraphColor(graphIndex, colorDialog.color);
                ccChart.chart.setGraphName(graphIndex, dropDown.currentText);
                graphType.currentText == "Line" ? ccChart.chart.setDotVisibility(false, graphIndex) : ccChart.chart.setDotVisibility(true, graphIndex);
                graphType.currentText == "Scatter" ? ccChart.chart.setLineVisibility(false, graphIndex) : ccChart.chart.setLineVisibility(true, graphIndex) ;

                ccChart.chart.replot();

                dropDown.currentIndex = -1
                dropDown.popup.close()
                dropDown.visible = false
            }


        }

    }

    Button {
        id: reset
        width: window.width * 0.1
        height: window.height * 0.05
        y: window.height * 0.07
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
        y: window.height * 0.07
        anchors.left: colorDisp.right
        anchors.leftMargin: window.width * 0.02
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

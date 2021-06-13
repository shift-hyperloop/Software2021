import QtQuick 2.12
import QtQuick.Controls 2.5
import shift.datamanagement 1.0

Page {
    id: page
    background: Rectangle{color: "#333333"} // background color for subpages
    Keys.onPressed: { //If backspace is pressed => go back to previous page
        if (event.key === 16777219) {
            //pop(null) implicitely pops to the first element, aka main.qml
            stackView.pop(null);
        }

    }

    DataManagerAccessor {
        id: dataManager
    }

    Button{
        text: "Go back"
        x: window.width * 0.01
        y: 0.05 * window.height
        height: window.height * 0.07
        width: window.width * 0.07
        font.pixelSize: window.height * 0.02
        onClicked: {
           stackView.pop(null);
        }
    }
    Item {
        id: connectionInputs
        //visible: ! networkinfo.connected // the connection inputs and connect button is not visible when connected
        Rectangle{
            color: "lightgray"
            id: ipInput
            width: inputIP.width
            height: inputIP.height
            border.width: 1
            x: window.width / 5
            y: window.height / 4
            TextInput {
                id: inputIP
                text: "192.168.  0.100"
                inputMask: "000.000.000.000;_" //format of the input, 0s are placeholders for numbers, . are unchangable
                padding: 5
                bottomPadding: 0
                selectByMouse : true
                height: window.height / 25
                width: window.width / 7
                font.pixelSize: window.height / 30
            }
            MouseArea{
                cursorShape: inputIP.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor;
                enabled: false
                anchors.fill: parent
            }

        }
        Text{
            id: iplabel
            text: "IP-adress: "
            color: "black"
            anchors.right: ipInput.left
            anchors.rightMargin: 10
            anchors.top: ipInput.top
            font.pixelSize: inputIP.font.pixelSize
        }


        Rectangle{
            color: "lightgray"
            id: ipPort
            width: inputPort.width
            height: inputPort.height
            border.width: 1
            anchors.right: ipInput.right
            anchors.top: ipInput.bottom
            anchors.topMargin: height
            TextInput {
                id: inputPort
                validator: IntValidator{} // you can only write numbers
                text: "80"
                padding: 5
                bottomPadding: 0
                selectByMouse : true
                width: inputIP.width
                height: inputIP.height
                font.pixelSize: inputIP.font.pixelSize
            }
            MouseArea{
                cursorShape: inputPort.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor;
                enabled: false
                anchors.fill: parent
            }
        }
        Text{
            id: portlabel
            text: "Port Number: "
            color: "black"
            anchors.right: ipPort.left
            anchors.rightMargin: 10
            anchors.top: ipPort.top
            font.pixelSize: inputIP.font.pixelSize
        }
        Button{
            id: connectButton
            text: qsTr("Connect")
            font.pixelSize: inputIP.font.pixelSize * 0.8
            y: ipInput.y - 5
            anchors.left: ipInput.right
            anchors.leftMargin: width / 4
            Component.onCompleted: {
                connectButton.forceActiveFocus()
            }

           // enabled: !networkinfo.connected //if connected to pod the button is disabled
            onClicked: {
                dataManager.dataManager.connectToPod(inputIP.text, inputPort.text);
                stackView.pop(null); // go back to main page after connecting
            }
            Keys.onReturnPressed: {
                clicked()
            }
        }
    }
    CustomChart{
        id: networkChart
        anchors.left: parent.left
        anchors.top: parent.verticalCenter
        anchors.leftMargin: window.width * 0.01
        width: page.width / 2
        height: page.height / 2.5
        Component.onCompleted: {
            chart.initCustomPlot(1);
            chart.setAxisRange(Qt.point(0, 100), Qt.point(0, 200));
            chart.setGraphColor(0, "#2674BB");
            chart.setGraphName(0,"");
            chart.setAxisLabels("", "")
        }
    }
    ValueTable{
        names: ["Value 1","Value 2", "Value Value", "Value"]
        values: [10, 12, 100, 8]
        anchors.bottom: networkChart.bottom
        anchors.right: parent.right
        anchors.rightMargin: 0.025 * window.width
        height: page.height / 2.5
        width: page.width / 3
    }

}

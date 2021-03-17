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
        y: 50
        x: 25
        onClicked: {
           stackView.pop(null);
        }
    }
    Item {
        id: connectionInputs
        visible: ! networkinfo.connected
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
                text: "IP-adress"
                inputMask: "000.000.000.000;_"
                padding: 5
                bottomPadding: 0
                selectByMouse : true
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
        }


        Rectangle{
            color: "lightgray"
            id: ipPort
            width: inputPort.width
            height: inputPort.height
            border.width: 1
            anchors.right: ipInput.right
            anchors.top: ipInput.top
            anchors.topMargin: height * 2
            TextInput {
                id: inputPort
                validator: IntValidator{}
                width: inputIP.width
                padding: 5
                bottomPadding: 0
                selectByMouse : true
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
        }
        Button{
            id: connectButton
            text: qsTr("Connect")
            y: ipInput.y - 5
            anchors.left: ipInput.right
            anchors.leftMargin: width / 4
            enabled: !networkinfo.connected
            onClicked: {
                dataManager.dataManager.connectToPod(inputIP.text, inputPort.text);
            }

        }
    }
    Chart{
        id: networkChart
        anchors.right: parent.left
        anchors.top: parent.verticalCenter
        chartview.width: page.width / 2
        chartview.height: page.height / 2
    }
    ValueTable{
        rowCount: 4
        names: ["Value 1","Value 2", "Value Value", "Value"]
        values: [10, 12, 100, 8]
        anchors.bottom: networkChart.bottom
        anchors.right: parent.right
        height: page.height / 3
        width: page.width / 3
    }

}

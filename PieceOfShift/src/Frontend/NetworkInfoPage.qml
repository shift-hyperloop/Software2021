import QtQuick 2.12
import QtQuick.Controls 2.5
Item {
    Keys.onPressed: { //If backspace is pressed => go back to previous page
        if (event.key === 16777219) {
            //pop(null) implicitely pops to the first element, aka main.qml
            stackView.pop(null);
        }

    }
    Button{
        text: "Go back"
        y: 50
        x: 25
        onClicked: {
           stackView.pop(null);
        }
    }
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
        text: qsTr("Connect")
        y: ipInput.y - 5
        anchors.left: ipInput.right
        anchors.leftMargin: width / 4
        onClicked: {
            console.log("IP: " + inputIP.text + " Port: " + inputPort.text)
            inputIP.clear()
            inputPort.clear()
        }

    }


}

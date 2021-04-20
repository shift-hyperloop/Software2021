import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
Page{
    property var stateIndicationStates: ["Off", "State 1", "State 2", "State 3", "State 4"];

    // if you have previously chosen a button it will be saved in the chosenButton variable in main.qml
    // this is so that the button will still be checked when you return to this page
    property var chosenButton
    background: Rectangle{color: "#333333"} // background color for subpages

    id: stateIndicationPage
    Keys.onPressed: { //If backspace is pressed => go back to previous page
        if (event.key === 16777219) {
            //pop(null) pops to the first element, aka main.qml
            stackView.pop(null);
        }

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
    Text {
        text: qsTr("Choose a state")
        font.pixelSize: window.width / 50
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: borderRectangle.top
        anchors.topMargin: window.height * 0.05

    }
    ColumnLayout{
        id: column
        anchors.centerIn: parent 
        spacing: window.height  / 15

        Repeater{
            model: stateIndicationStates.length
            RadioButton{
                text: stateIndicationStates[index]
                font.pixelSize: window.width / 75
                onClicked: {
                    chosenButton = index
                    stackView.chosenState = chosenButton
                }
            }
        }
    }
    Rectangle{
        id: borderRectangle
        anchors.centerIn: column
        width: column.width * 4
        height: column.height*1.5
        border.width: window.width * 0.01
        color: "transparent"
    }

    Component.onCompleted: {
        chosenButton = stackView.chosenState // if you have previously chosen a button it will be selected
        if(chosenButton == null){            //if not 0 will be selected
            chosenButton = 0
        }
        column.children[chosenButton].checked = true
    }


}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
Page{
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
        y: 50
        x: 25
        onClicked: {
           stackView.pop(null);
        }
    }
    Text {
        text: qsTr("Choose a state")
        font.pointSize: 20
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.1

    }
    ColumnLayout{
        id: column
        anchors.centerIn: parent
        RadioButton{
            text: "Off"
            checked: true
            onClicked: {
                chosenButton = 0
                stackView.chosenState = chosenButton
            }
        }
        RadioButton{
            text: "State 1"
            onClicked: {
                chosenButton = 1
                stackView.chosenState = chosenButton
            }
        }
        RadioButton{
            text: "State 2"
            onClicked: {
                chosenButton = 2
                stackView.chosenState = chosenButton
            }
        }
        RadioButton{
            text: "State 3"
            onClicked: {
                chosenButton = 3
                stackView.chosenState = chosenButton
            }
        }
        RadioButton{
            text: "State 4"
            onClicked: {
                chosenButton = 4
                stackView.chosenState = chosenButton
            }
        }

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

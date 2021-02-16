import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
Page{
    property var chosenButton
    id: stateIndicationPage
    Keys.onPressed: { //If backspace is pressed => go back to previous page
        if (event.key === 16777219) {
            stackView.pop("main.qml");
        }

    }
    Button{
        text: "Go back"
        y: 50
        x: 25
        onClicked: {
           stackView.pop("main.qml");
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
        console.log(chosenButton)
        chosenButton = stackView.chosenState
        if(chosenButton == null){
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

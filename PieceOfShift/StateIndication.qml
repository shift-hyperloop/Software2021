import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
Page{
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
        anchors.centerIn: parent
        RadioButton{
            text: "Off"
        }
        RadioButton{
            text: "State 1"
        }
        RadioButton{
            text: "State 2"
        }
        RadioButton{
            text: "State 3"
        }
        RadioButton{
            text: "State 4"
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

import QtQuick 2.12
import QtQuick.Controls 2.15
import "button_script.js" as Logic

Page {
    Keys.onPressed: {
        console.log(event.key); //debug
        if (event.key === 16777219) {  //167777219 is the number that defines the event of pressing backspace
            stackView.pop("main.qml");
        }
        /*
          onBackPressed should ideally work as above, but it doesn't, so it'll have to be done
          manually (although it's quite simple, so it's not too bad).
          */
    }

    Label {
        id: label
        text: qsTr("This is a page that has been pushed. \nPress to go back.")
        Text {
            text: stackView.depth
        }
    }
    Button {
        onClicked: stackView.pop("main.qml")
        anchors.centerIn: parent
        text: qsTr("Go Back")
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

import QtQuick 2.0
import QtQuick.Controls 2.5
Item {
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
}

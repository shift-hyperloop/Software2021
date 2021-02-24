import QtQuick 2.0
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
}

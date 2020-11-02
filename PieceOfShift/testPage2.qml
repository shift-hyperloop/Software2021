import QtQuick 2.0
import QtQuick.Controls 2.12
import "button_script.js" as Logic

StackView {
    id: stackView

    initialItem: Component {
        id: page

        Page {
            Row {
                spacing: 20
                anchors.centerIn: parent

                Button {
                    text: "calculate"
                    onClicked: Logic.calculate(label1, label2)
                    autoRepeat: true;
                    autoRepeatDelay: 10;
                    autoRepeatInterval: 10;
                }
            }
            Row {
                spacing: 20


                Label {
                    id: label1
                    text: qsTr("label1")
                }
                Label {
                    id: label2
                    text: qsTr("label2")
                }
            }
        }
    }
}

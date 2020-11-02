import QtQuick 2.12
import QtQuick.Controls 2.15
import "test_script.js" as Script
import "."



ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Stack")

    StackView {
        id: stackView
        initialItem: mainView
        anchors.fill: parent
    }

    Component {
        id: mainView

        Item {

            TestComp {
                id: t1
                x_choord: 0
                y_choord: 0
            }

            TestComp {
                id: t2
                x_choord: t1.width_
                y_choord: 0
            }

        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/

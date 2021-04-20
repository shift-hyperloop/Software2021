import QtQuick 2.0
import QtQuick.Controls 2.5
Page {
    id: inverterPage
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
    ValueTable{
        names: ["Value 1","Value 2", "Value Value", "Value"]
        values: [10, 12, 100, 8]
        anchors.centerIn: parent
        height: inverterPage.height / 3
        width: inverterPage.width / 3
    }
}

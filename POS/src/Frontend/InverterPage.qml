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
        id:limTemperatures
        names: ["Temperature 1","Temperature 2", "Temperature 3", "Temperature 4"]
        values: [30, 40, 50, 60]
        anchors.centerIn: parent
        height: inverterPage.height / 3
        width: inverterPage.width / 3
    }
    Text{
        anchors.bottom: limTemperatures.top
        anchors.bottomMargin: window.height * 0.01
        anchors.horizontalCenter: limTemperatures.horizontalCenter
        text: "Lim Temperatures"
        color: "white"
        font.pixelSize: window.height * 0.05
    }
}

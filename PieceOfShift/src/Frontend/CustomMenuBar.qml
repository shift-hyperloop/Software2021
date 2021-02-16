import QtQuick 2.12
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
Item {
    property alias _width: __menu.width
    property alias _height: __menu.height
    //Don't need this if we only set width in main.qml <-- Turns out we actually do
    Rectangle {
        width: logoWhite_RightText.width + 5
        height: logoWhite_RightText.height + 10
        color: "#373840"
        Image {
            id: logoWhite_RightText
            x: 5
            y: 5
            height: 0.05 * window.height - 10
            source: "../../assets/images/Shift_Logo.png"
            fillMode: Image.PreserveAspectFit


        }
    }
    MenuBar{
        id: __menu
        width: window.width - logoWhite_RightText.width
        height: 0.05 * window.height
        x: logoWhite_RightText.width
        background: Rectangle {
            color: "#373840"
        }

        Menu{
            title: qsTr("&File")

            MenuItem { text: qsTr("&New...")
                onTriggered: {

                }
              }
            MenuItem { text: qsTr("&Open...")
                onTriggered: {

                }
              }
            MenuItem { text: qsTr("&Save")
                onTriggered: {

                }
              }
            MenuItem { text: qsTr("Save &As...")
                onTriggered: {

                }
              }
            MenuSeparator { }
            MenuItem { text: qsTr("&Quit")
                onTriggered: {
                    window.close()
                }
              }
        }
        Menu {
            title: qsTr("&Edit")
            MenuItem { text: qsTr("Cu&t")
                onTriggered: {

                }
              }
            MenuItem { text: qsTr("&Copy")
                onTriggered: {

                }
              }
            MenuItem { text: qsTr("&Paste")
                onTriggered: {

                }
             }
        }
        Menu{
            title: qsTr("View")
            Menu{
                title: qsTr("Battery")
                MenuItem{
                    CheckBox{
                        checked: true
                        onCheckStateChanged: thermometer.visible = checked
                        }
                    Label{
                            text: "Thermometer"
                            anchors.centerIn: parent
                        }
                    Menu{
                        title: qsTr("Charts")

                    }
                }
                Menu{
                    title: qsTr("Charts")
                }
            }
            Menu{
                title: qsTr("Speed")
                MenuItem{
                    CheckBox{
                        checked: true
                        onCheckStateChanged: speedometer.visible = checked
                        }
                    Label{
                            text: "Speedometer"
                            anchors.centerIn: parent
                        }
                }
                Menu{
                    title: qsTr("Charts")
                    MenuItem{
                        CheckBox{
                            checked: true
                            onCheckStateChanged: chart.visible = checked
                            }
                        Label{
                                text: "Speed"
                                anchors.centerIn: parent
                            }
                    }
                }
            }
            Menu{
                title: qsTr("Position")
                MenuItem{
                    CheckBox{
                        checked: true
                        onCheckStateChanged: slider.visible = checked
                        }
                    Label{
                            text: "Distance slider"
                            anchors.centerIn: parent
                        }
                }
                Menu{
                    title: qsTr("Charts")

                }
            }
            Menu{
                title: qsTr("Rotation")
                Menu{
                    title: qsTr("Charts")

                }
            }
        }
        Menu{
            title: qsTr("State indication")
            MenuItem { text: qsTr("Change State")
                onTriggered: {
                    stackView.push("StateIndication.qml");
                }
              }
        }
        Menu {
            title: qsTr("&Help")
            MenuItem { text: qsTr("&About")
            onTriggered: {
                Qt.openUrlExternally("https://github.com/shift-hyperloop/Software2021");
            }
            }
        }
    }
}

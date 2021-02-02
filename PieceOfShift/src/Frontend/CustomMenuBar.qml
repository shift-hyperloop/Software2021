import QtQuick 2.12
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
Item {
    property alias _width: __menu.width
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
            source: "../Shift_Logo.png"
            fillMode: Image.PreserveAspectFit


        }
    }
    MenuBar{
        id: __menu
        width: window.width - logoWhite_RightText.width - 5
        x: logoWhite_RightText.width + 5
        height: 0.05 * window.height
        background: Rectangle {
            color: "#373840"
        }
        padding: 2
        delegate: MenuBarItem {
            id: menuBarItem
            font.pixelSize: 0.025 * window.height
            implicitHeight: 0.05 * window.height
            contentItem: Text {
                text: menuBarItem.text
                font: menuBarItem.font
                opacity: enabled ? 1.0 : 0.3
                color: "#ededed"
                verticalAlignment: Text.AlignVCenter
                height: 0.05 * window.height
            }

            background: Rectangle {
                implicitWidth: menuBarItem.implicitContentWidth
                implicitHeight: 0.05 * window.height
                opacity: enabled ? 0.3 : 1
                color: menuBarItem.highlighted ? "#ededed" : "transparent"
            }
        }

        Menu {
            title: qsTr("File")
            font.pixelSize:  0.025 * window.height
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
            title: qsTr("Edit")
            font.pixelSize:  0.025 * window.height

            MenuItem { text: qsTr("&Cut")
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
            font.pixelSize:  0.025 * window.height

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
            font.pixelSize:  0.025 * window.height

            MenuItem { text: qsTr("Change State")
                onTriggered: {
                    stackView.push("StateIndication.qml");
                }
              }
        }
        Menu {
            title: qsTr("Help")
            font.pixelSize:  0.025 * window.height

            MenuItem { text: qsTr("&About")
            onTriggered: {
                Qt.openUrlExternally("https://github.com/shift-hyperloop/Software2021");
            }
            }
        }
    }
}

import QtQuick 2.12
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
Item {
    property alias _width: __menu.width
    MenuBar{
        id: __menu
        width: _width
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

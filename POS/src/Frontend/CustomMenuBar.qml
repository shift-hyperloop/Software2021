import Qt.labs.platform 1.1
import QtQuick 2.12
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import shift.datamanagement 1.0

Item {
   // property alias _width: __menu.width
    //property alias _height: __menu.height

    DataManagerAccessor {
        id: dmAccessor
    }

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
            MouseArea{ //pressing the shift logo at any point wil return you to the main page
                hoverEnabled: true
                anchors.fill: parent
                onHoveredChanged: {
                    parent.opacity = containsMouse ? 1.0 : 0.8;
                    cursorShape = containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor;
                }
                onClicked: {
                    stackView.pop(null);
                }
            }
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
            height: __menu.height
            contentItem: Text {
                text: menuBarItem.text
                font: menuBarItem.font
                opacity: enabled ? 1.0 : 0.3
                color: "#ededed"
                verticalAlignment: Text.AlignVCenter
                height: __menu.height
                anchors.verticalCenter: parent.verticalCenter

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
                FileDialog {
                    id: fileDialogOpen
                    title: "Please choose a file"
                    fileMode: "OpenFile"
                    acceptLabel: "Open"
                    //folder: "" adding a folder here will make it the default open folder
                    defaultSuffix: "txt"
                    //selectedNameFilter.index: 0 // this is for sorting by filetype
                    //nameFilters: ["Text files (.txt)", "CSV files (.csv)"]
                    onAccepted: {
                        // remove prefixed "file:///"
                        var path = file.toString();

                        // remove prefixed "file:///"
                        path = path.replace(/^(file:\/{3})/,"");
                        // unescape html codes like '%23' for '#'
                        var cleanPath = decodeURIComponent(path);
                        dmAccessor.dataManager.readLogFile(cleanPath)

                    }
                }
                onTriggered: {
                    fileDialogOpen.open()
                }
              }
            MenuItem { text: qsTr("&Save")
                onTriggered: {

                }
              }
            MenuItem { text: qsTr("Save &As...")
                FolderDialog {
                    
                    id: folderDialog
                    acceptLabel : "Save here"
                    //folder: //standard folder

                    onAccepted: {
                        var path = folder.toString(); //folderDialog.folderUrl.toString();
                        // remove prefixed "file:///"
                        path = path.replace(/^(file:\/{3})/,"");
                        // unescape html codes like '%23' for '#'
                        var cleanPath = decodeURIComponent(path);
                        dmAccessor.dataManager.writeLogFile(cleanPath)
                        console.log(folder) // this is the path of the folderSave

                    }
                 }
                onTriggered: {
                    folderDialog.open()
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
            title: qsTr("Startup")
            font.pixelSize:  0.025 * window.height

            MenuItem { text: qsTr("Start Pod")
                onTriggered: {
                    stackView.push("StartupPage.qml");
                }
              }

        }
        Menu{
            title: qsTr("View")
            font.pixelSize:  0.025 * window.height
            MenuItem{
                CheckBox{
                    id:fullscreen
                    anchors.verticalCenter: parent.verticalCenter
                    onCheckStateChanged: {
                        if(checked){
                           window.visibility = 5 //fullscreen
                        }
                        else{
                            window.visibility = 4 //maximized
                        }
                        }
                    }
                onTriggered: {
                    if(!fullscreen.checked){
                        fullscreen.checked = true;
                    }
                    else{
                        fullscreen.checked = false;
                    }
                }

                Label{
                    text: "Fullscreen"
                    anchors.centerIn: parent
                }
            }
            MenuItem { text: qsTr("Accelerometer")
                onTriggered: {
                    stackView.push("AccelerometerPage.qml");
                }
              }
            MenuItem { text: qsTr("Battery Graphs")
                onTriggered: {
                    stackView.push("DetailedBatteryPage.qml");
                }
              }
            MenuItem { text: qsTr("Battery Cells")
                onTriggered: {
                    stackView.push("CellularGrid.qml");
                }
              }
            MenuItem { text: qsTr("Custom Chart")
                onTriggered: {
                    stackView.push("CustomizableChartPage.qml");
                }
              }
            MenuItem { text: qsTr("Inverter")
                onTriggered: {
                    stackView.push("InverterPage.qml");
                }
              }

            MenuItem { text: qsTr("Mechanical")
                onTriggered: {
                    stackView.push("MechanicalDetails.qml");
                }
              }
            MenuItem { text: qsTr("Network")
                onTriggered: {
                    stackView.push("NetworkInfoPage.qml");
                }
              }


/*
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
            }*/
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
            id: menuHelp
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

import QtQuick.Controls 2.15
import QtQuick 2.15
import QtQuick.Dialogs 1.3
import shift.datamanagement 1.0

Item {
    id: cGrid

    // Press back-button => go back to the previous page
    Keys.onPressed: {
        if (event.key === 16777219) {
            stackView.pop("main.qml");
        }
    }

    DataManagerAccessor {
        id: dm

        dataManager.onNewData: {
            if (name == "Temp_P1[0-22]") {
                for (let i = 0; i < 23; i++) {
                    var temperature = data[i];
                    repeater.itemAt(i).temperature = temperature;
                    repeater.itemAt(i).state = (temperature < 6) ?
                                'cold' : (temperature < 22) ?
                                'not so hot' : (temperature < 36) ?
                                'hot' : (temperature < 50) ?
                                'slightly hot' : 'very hot';
                }
            }
            if (name == "Temp_P1[23-44]") {
                for (let i = 23; i < 45; i++) {
                    var temperature = data[i-23];
                    repeater.itemAt(i).temperature = temperature;
                    repeater.itemAt(i).state = (temperature < 6) ?
                                'cold' : (temperature < 22) ?
                                'not so hot' : (temperature < 36) ?
                                'hot' : (temperature < 50) ?
                                'slightly hot' : 'very hot';
                }
            }
            if (name == "Temp_P2[0-22]") {
                for (let i = 45; i < 68; i++) {
                    var temperature = data[i-45];
                    repeater.itemAt(i).temperature = temperature;
                    repeater.itemAt(i).state = (temperature < 6) ?
                                'cold' : (temperature < 22) ?
                                'not so hot' : (temperature < 36) ?
                                'hot' : (temperature < 50) ?
                                'slightly hot' : 'very hot';
                }
            }
            if (name == "Temp_P2[23-44]") {
                for (let i = 68; i < 90; i++) {
                    var temperature = data[i-68];
                    repeater.itemAt(i).temperature = temperature;
                    repeater.itemAt(i).state = (temperature < 6) ?
                                'cold' : (temperature < 22) ?
                                'not so hot' : (temperature < 36) ?
                                'hot' : (temperature < 50) ?
                                'slightly hot' : 'very hot';
                }
            }
        }
    }

    // Create a column of fixed cells to indicate what temperatures correspond to which colours
    Column {
        id: colorIndex
        // Just set some fixed x- and y-coordinates that looks good, nothing too fancy here
        x: 10
        y: 0.05 * window.height + 25
        // Space between each element in the column
        spacing: 5

        // Create, similar to all other pages, a button to go back
        Button {
            id: but2
            text: "Go back"
            // Arbitrary height/width that fits the page well
            height: 70
            width: 105
            // Set the size of the font inside the button
            font.pixelSize: window.height * 0.02
            onClicked: {
                stackView.pop("main.qml");
            }
        }

        // A small text included to explain what the cells are for
        Text {
            id: explanation
            x: parent.x
            y: parent.y
            width: 130
            text: qsTr("The following\nboxes indicate\ncell temperatures")
            color: "yellow"
        }

        // The following 5 rectangles are aforementioned cells to describe the temp. range of each colour
        Rectangle {
            id: color1
            x: parent.x
            color: "#FF0000"
            
            // Width and height are taken from grid in order to have the same size as the actual grid-cells
            width: Math.floor((grid.width - 20) / grid.columns)
            height: Math.floor((grid.height - 20) / grid.rows)

            // Set border to 2 pixels wide, and black colour. Same for all following column-cells
            border.width: 2
            border.color: "black"
            // Text that will contain the actual temperature range
            Text {
                anchors.centerIn: parent
                // \u in QML text means unicode, and 00b0 is the unicode value of the degrees symbol
                text: ">= 50" + "\u00b0" + "C"
            }
        }

        Rectangle {
            id: color2
            x: parent.x
            color: "#FF8800"
            
            width: Math.floor((grid.width - 20) / grid.columns)
            height: Math.floor((grid.height - 20) / grid.rows)

            border.width: 2
            border.color: "black"

            Text {
                anchors.centerIn: parent
                text: ">= 36" + "\u00b0" + "C"
            }
        }

        Rectangle {
            id: color3
            x: parent.x
            color: "#FFBB00"
            
            width: Math.floor((grid.width - 20) / grid.columns)
            height: Math.floor((grid.height - 20) / grid.rows)

            border.width: 2
            border.color: "black"

            Text {
                anchors.centerIn: parent
                text: ">= 22" + "\u00b0" + "C"
            }
        }

        Rectangle {
            id: color4
            x: parent.x
            color: "#FFFF00"
            
            width: Math.floor((grid.width - 20) / grid.columns)
            height: Math.floor((grid.height - 20) / grid.rows)

            border.width: 2
            border.color: "black"

            Text {
                anchors.centerIn: parent
                text: ">= 6" + "\u00b0" + "C"
            }
        }

        Rectangle {
            id: color5
            x: parent.x
            color: "#9dff00"
            
            width: Math.floor((grid.width - 20) / grid.columns)
            height: Math.floor((grid.height - 20) / grid.rows)

            border.width: 2
            border.color: "black"

            Text {
                anchors.centerIn: parent
                text: "< 6" + "\u00b0" + "C"
            }
        }

    }

    /*
    Create a grid that will resemble the battery-cells on the pod in order to track their temperatures.
    This grid will have format 9x20, i.e. 9 rows, 20 columns, as requested per glorious Bendik Nyhavn.
    The number of columns and rows can be defined in the component, but it's worth mentioning that the index
    of every element in the grid is incrementing, and not done in two dimensions. For example, since we have
    9x20 objects, the last element will have index 179 (9 * 20 - 1), not index (8, 19) as one might be used to.
    */
    Grid {
        id: grid
        // Position the grid according to the above rectangles. Could probably be done better with anchors
        x: colorIndex.x + colorIndex.width + 5
        y: colorIndex.y
        // Space between each element in the grid
        spacing: 1
        // Make width according to the window size and the reference-cells, with a bit extra breathing room
        width: window.width - colorIndex.width - 15
        height: window.height * 0.95 - y + 25

        // Here we define the number of elements to go in the grid
        columns: 20
        rows: 9

        // This component creates a fixed number of repetitive, sub-components (in this case rectangles)
        Repeater {
            id: repeater
            // This attribute specifies the number of components to create
            model: parent.columns * parent.rows
            // Here we create columns * rows number of Rectangle-components
            Rectangle {
                id: rect
                // Divide the width and height into sections of the entire grid
                width: Math.floor((parent.width - 20) / parent.columns)
                height: Math.floor((parent.height - 20) / parent.rows)
                // Initial color corresponds to lowest temperature (we assume they're cold at start)
                color: "#9dff00"
                // Define a variable that tells us the temperature of the cell, which we can also change based
                // on what data we receive from the pod. 
                property var temperature: 0
                // Define a list of states that the cells can change between. The way these can be used, is
                // by changing "rect.state", and the below transitions will define what the state-changes look like
                states: [
                    State {
                        // Each state needs a name, and PopertyChanges define what the State-component targets
                        // (the ID of the component), as well as what attributes to change (in our case, only colour).
                        name: "very hot"
                        PropertyChanges { target: rect; color: "#FF0000"}
                    },
                    State {
                        name: "slightly hot"
                        PropertyChanges { target: rect; color: "#FF8800"}
                    },
                    State {
                        name: "hot"
                        PropertyChanges { target: rect; color: "#FFBB00"}
                    },
                    State {
                        name: "not so hot"
                        PropertyChanges { target: rect; color: "#FFFF00"}
                    },
                    State {
                        name: "cold"
                        PropertyChanges { target: rect; color: "#9dff00"}
                    }
                ]
                // Define transitions (or here, only one transition) to define how a change in state will look.
                // Here we only define a colour-transition that takes 0.8s . 
                transitions: Transition {
                    ColorAnimation { duration: 800 }
                }

                // Define a border to each cell
                border {
                    color: "black"
                    width: 2
                }

                // Each cell contains text of its own temperature
                Text {
                    text: rect.temperature + "\u00b0" + "C"
                    anchors.centerIn: parent
                }
            }
        }
    }

    // Timer to simulate changes in temperature
    //Timer {
    //    id: timer
    //    running: true
    //    repeat: true
    //    interval: 200
    //    // Fancy-shmancy JS code
    //    onTriggered: {
    //        for (let i = 0; i < repeater.count; i++) {
    //            let temperature = Math.floor(Math.random() * 70) - 10;
    //            /*
    //            itemAt(index) returns the repeater item at the corresponding index
    //            repeater.count is the number of items in in the repeater, and in our case the number of
    //            ojects in the grid
    //            */
    //            repeater.itemAt(i).temperature = temperature;
    //            repeater.itemAt(i).state = (temperature < 6) ?
    //                        'cold' : (temperature < 22) ?
    //                        'not so hot' : (temperature < 36) ?
    //                        'hot' : (temperature < 50) ?
    //                        'slightly hot' : 'very hot';
    //        }
    //    }
    //}
}
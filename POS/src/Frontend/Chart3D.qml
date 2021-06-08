import QtQuick 2.5
import QtQuick.Window 2.12
import QtDataVisualization 1.2
import QtQuick.Controls 2.5
import shift.datamanagement 1.0

//The way this 3d chart works is that the chart is a Scatter3D. Each point in the chart is its own graph made of a Scatter3DSeries
//Each Scatter3DSeries needs a list of its points (a ListModel where every point is a ListElement with x,y and z values)
//Since we are only showing onw point at a time from each graph things become more complicated.
//The ListModel for the graphs can then only have one ListElement, so each graph (Scatter3DSeries) now has to ListModels
//the graphs have a ListModel called values(n) which contains all its values that you can cycle through using the slider
//they also have a ListModel called currentValue(n) that only contains a listelement with the point currently beeing shown,
//this ListElement is changed every time a new point is added, or the slider is moved.


Item {

    DataManagerAccessor {
        id: dm

        Component.onCompleted: {
            dataManager.init()
        }

        dataManager.onNewData: {
            if (name == "Suite XS Front Pos") {
                addDataSingle(0, [data[0], data[1], data[2]])
                currentValueValues[0] = [data[0], data[1], data[2]]
                addDataSingle(1, [data[3], data[4], data[5]])
                currentValueValues[1] = [data[3], data[4], data[5]]
            }
            else if (name == "Suite XS Rear Pos") {
                addDataSingle(2, [data[0], data[1], data[2]])
                currentValueValues[2] = [data[0], data[1], data[2]]
                addDataSingle(3, [data[3], data[4], data[5]])
                currentValueValues[3] = [data[3], data[4], data[5]]
            }

        }
    }

    property var currentValueValues: [
        [0,0,0],
        [0,0,0],
        [0,0,0],
        [0,0,0]
    ]

    property var allValues: []
    property var numReceived: 0

    property var colorArray: ["red","green","blue", "yellow"]
    property var axisMin: -5
    property var axisMax: 5
    property var sliderVisible: true
    property var currentValue0: currentValue0
    property var slider: slider
    Theme3D {
        id: theme
        type: Theme3D.ThemeArmyBlue
        font.pointSize: 50
        windowColor:  "#303030"
        labelBackgroundColor: "#303030"
        labelTextColor: "grey"
        backgroundColor: "darkgrey"
        lightColor: "white"

    }
    ValueAxis3D{
        id: xAxis
        min: axisMin
        max: axisMax
        autoAdjustRange: false
    }
    ValueAxis3D{
        id: yAxis
        min: axisMin
        max: axisMax
        autoAdjustRange: false
    }
    ValueAxis3D{
        id: zAxis
        min: axisMin
        max: axisMax
        autoAdjustRange: false
    }
    Scatter3D {
        id: scatter
        width: parent.width
        height: parent.height
        theme: theme
        axisX: xAxis
        axisY: yAxis
        axisZ: zAxis
        Scatter3DSeries {
            baseColor: colorArray[0]
            colorStyle: Q3DTheme.ColorStyleUniform
            ItemModelScatterDataProxy {
               itemModel: currentValue0
                xPosRole: "xPos"
                yPosRole: "yPos"
                zPosRole: "zPos"
            }
        }
        Scatter3DSeries {
            baseColor: colorArray[1]
            colorStyle: Q3DTheme.ColorStyleUniform
            ItemModelScatterDataProxy {
               itemModel: currentValue1
                xPosRole: "xPos"
                yPosRole: "yPos"
                zPosRole: "zPos"
            }
        }
        Scatter3DSeries {
            baseColor: colorArray[2]
            colorStyle: Q3DTheme.ColorStyleUniform
            ItemModelScatterDataProxy {
               itemModel: currentValue2
                xPosRole: "xPos"
                yPosRole: "yPos"
                zPosRole: "zPos"
            }
        }
        Scatter3DSeries {
            baseColor: colorArray[3]
            colorStyle: Q3DTheme.ColorStyleUniform
            ItemModelScatterDataProxy {
               itemModel: currentValue3
                xPosRole: "xPos"
                yPosRole: "yPos"
                zPosRole: "zPos"
            }
        }
        Component.onCompleted: {

        }
    }
    ListModel {
        id: currentValue0
        ListElement{ xPos: "0"; yPos: "0"; zPos: "0"; }
    }
    ListModel {
        id: currentValue1
        ListElement{ xPos: "0"; yPos: "0"; zPos: "0"; }
    }
    ListModel {
        id: currentValue2
        ListElement{ xPos: "0"; yPos: "0"; zPos: "0"; }
    }
    ListModel {
        id: currentValue3
        ListElement{ xPos: "0"; yPos: "0"; zPos: "0"; }

    }
    ListModel {
        id: values0
        ListElement{ xPos: "0"; yPos: "0"; zPos: "0"; }
        ListElement{ xPos: "2.754"; yPos: "1.455"; zPos: "3.362"; }
        ListElement{ xPos: "2.754"; yPos: "1.455"; zPos: "3.362"; }

    }
    ListModel {
        id: values1
        ListElement{ xPos: "0"; yPos: "0"; zPos: "0"; }
        ListElement{ xPos: "1.754"; yPos: "1.455"; zPos: "1.362"; }
        ListElement{ xPos: "2.754"; yPos: "2.455"; zPos: "2.362"; }

    }
    ListModel {
        id: values2
        ListElement{ xPos: "0"; yPos: "0"; zPos: "0"; }
        ListElement{ xPos: "0.754"; yPos: "0.455"; zPos: "1.362"; }
        ListElement{ xPos: "0.704"; yPos: "0.055"; zPos: "0.302"; }

    }
    ListModel {
        id: values3
        ListElement{ xPos: "0"; yPos: "0"; zPos: "0"; }
        ListElement{ xPos: "3.754"; yPos: "2.455"; zPos: "3.362"; }
        ListElement{ xPos: "3.354"; yPos: "2.255"; zPos: "3.162"; }


    }

    Slider{
        id: slider
        visible: sliderVisible
        anchors.top: scatter.bottom
        anchors.horizontalCenter: scatter.horizontalCenter
        width: scatter.width / 2
        from: 0
        to: values0.rowCount() - 1
        stepSize: 1
        snapMode: Slider.SnapAlways
        onMoved: {
            currentValue0.clear()
            currentValue1.clear()
            currentValue2.clear()
            currentValue3.clear()
            currentValue0.append(values0.get(slider.value))
            currentValue1.append(values1.get(slider.value))
            currentValue2.append(values2.get(slider.value))
            currentValue3.append(values3.get(slider.value))
            currentValueValues[0][0] = currentValue0.get(0).xPos
            currentValueValues[0][1] = currentValue0.get(0).yPos
            currentValueValues[0][2] = currentValue0.get(0).zPos
            currentValueValues[1][0] = currentValue1.get(0).xPos
            currentValueValues[1][1] = currentValue1.get(0).yPos
            currentValueValues[1][2] = currentValue1.get(0).zPos
            currentValueValues[2][0] = currentValue2.get(0).xPos
            currentValueValues[2][1] = currentValue2.get(0).yPos
            currentValueValues[2][2] = currentValue2.get(0).zPos
            currentValueValues[3][0] = currentValue3.get(0).xPos
            currentValueValues[3][1] = currentValue3.get(0).yPos
            currentValueValues[3][2] = currentValue3.get(0).zPos
            t0.text = "Accelerometer 1 (" + currentValueValues[0][0] + "," + currentValueValues[0][1] + "," +currentValueValues[0][2] + ")"
            t1.text = "Accelerometer 2 (" + currentValueValues[1][0] + "," + currentValueValues[1][1] + "," + currentValueValues[1][2] + ")"
            t2.text = "Accelerometer 3 (" + currentValueValues[2][0] + "," + currentValueValues[2][1] + "," + currentValueValues[2][2] + ")"
            t3.text = "Accelerometer 4 (" + currentValueValues[3][0] + "," + currentValueValues[3][1] + "," + currentValueValues[3][2] + ")"
        }
    }
    Text{
        visible: sliderVisible
        font.pixelSize: window.height * 0.02
        text: "Time: " + slider.value
        anchors.top: slider.bottom
        anchors.horizontalCenter: slider.horizontalCenter

    }
    ListModel {
        id: tempList
        ListElement{ xPos: "0"; yPos: "0"; zPos: "0"; }

    }
    function addData(data){
        tempList.setProperty(0,"xPos",String(data[0][0]))
        tempList.setProperty(0,"yPos",String(data[0][1]))
        tempList.setProperty(0,"zPos",String(data[0][2]))
        values0.append(tempList.get(0))
        currentValue0.clear()
        currentValue0.append(values0.get(values0.count-1))


        tempList.setProperty(0,"xPos",String(data[1][0]))
        tempList.setProperty(0,"yPos",String(data[1][1]))
        tempList.setProperty(0,"zPos",String(data[1][2]))
        values1.append(tempList.get(0))
        currentValue1.clear()
        currentValue1.append(values1.get(values1.count-1))

        tempList.setProperty(0,"xPos",String(data[2][0]))
        tempList.setProperty(0,"yPos",String(data[2][1]))
        tempList.setProperty(0,"zPos",String(data[2][2]))
        values2.append(tempList.get(0))
        currentValue2.clear()
        currentValue2.append(values2.get(values2.count-1))

        tempList.setProperty(0,"xPos",String(data[3][0]))
        tempList.setProperty(0,"yPos",String(data[3][1]))
        tempList.setProperty(0,"zPos",String(data[3][2]))
        values3.append(tempList.get(0))
        currentValue3.clear()
        currentValue3.append(values3.get(values3.count-1))
        slider.to = values3.count-1
        slider.value = values3.count-1

        currentValueValues = data
        t0.text = "Accelerometer 1 (" + currentValueValues[0][0] + "," + currentValueValues[0][1] + "," +currentValueValues[0][2] + ")"
        t1.text = "Accelerometer 2 (" + currentValueValues[1][0] + "," + currentValueValues[1][1] + "," + currentValueValues[1][2] + ")"
        t2.text = "Accelerometer 3 (" + currentValueValues[2][0] + "," + currentValueValues[2][1] + "," + currentValueValues[2][2] + ")"
        t3.text = "Accelerometer 4 (" + currentValueValues[3][0] + "," + currentValueValues[3][1] + "," + currentValueValues[3][2] + ")"

    }

    function addDataSingle(index, data) {
        tempList.setProperty(0,"xPos",String(data[0]))
        tempList.setProperty(0,"yPos",String(data[1]))
        tempList.setProperty(0,"zPos",String(data[2]))


        if (index == 0) {
            values0.append(tempList.get(0))
            currentValue0.clear()
            currentValue0.append(values0.get(values0.count-1))
            t0.text = "Accelerometer 1 (" + data[0].toFixed(2) + "," + data[1].toFixed(2) + "," +data[2].toFixed(2) + ")"
        }
        else if (index == 1) {
            values1.append(tempList.get(0))
            currentValue1.clear()
            currentValue1.append(values1.get(values1.count-1))
            t1.text = "Accelerometer 2 (" + data[0].toFixed(2) + "," + data[1].toFixed(2) + "," +data[2].toFixed(2) + ")"
        }
        else if (index == 2) {
            values2.append(tempList.get(0))
            currentValue2.clear()
            currentValue2.append(values2.get(values2.count-1))
            t2.text = "Accelerometer 3 (" + data[0].toFixed(2) + "," + data[1].toFixed(2) + "," +data[2].toFixed(2) + ")"
        }
        else if (index == 3) {
            values3.append(tempList.get(0))
            currentValue3.clear()
            currentValue3.append(values3.get(values3.count-1))
            t3.text = "Accelerometer 4 (" + data[0].toFixed(2) + "," + data[1].toFixed(2) + "," +data[2].toFixed(2) + ")"
        }

        numReceived = (numReceived + 1) % 2
        if (numReceived == 0) {
            slider.to += 1
            slider.value += 1
        }

    }

    Repeater{
        model: 4
        Rectangle{
            color: colorArray[index]
            width: window.width / 35
            height: width
            radius: width
            x: parent.width*0.85
            y: window.height * 0.1 * (index+2)
            border.width: 1
        }
    }
    Text {
        id: t0
        text: "Accelerometer 1 (" + currentValueValues[0][0] + "," + currentValueValues[0][1] + "," +currentValueValues[0][2] + ")"
        x: parent.width*0.95
        y: window.height * 0.1 * (2) + window.height * 0.01
        font.pixelSize: window.height * 0.02
        color: "grey"
    }
    Text {
        id: t1
        text: "Accelerometer 2 (" + currentValueValues[1][0] + "," + currentValueValues[1][1] + "," + currentValueValues[1][2] + ")"
        x: parent.width*0.95
        y: window.height * 0.1 * (3) + window.height * 0.01
        font.pixelSize: window.height * 0.02
        color: "grey"
    }
    Text {
        id: t2
        text: "Accelerometer 3 (" + currentValueValues[2][0] + "," + currentValueValues[2][1] + "," + currentValueValues[2][2] + ")"
        x: parent.width*0.95
        y: window.height * 0.1 * (4) + window.height * 0.01
        font.pixelSize: window.height * 0.02
        color: "grey"
    }
    Text {
        id: t3
        text: "Accelerometer 4 (" + currentValueValues[3][0] + "," + currentValueValues[3][1] + "," + currentValueValues[3][2] + ")"
        x: parent.width*0.95
        y: window.height * 0.1 * (5) + window.height * 0.01
        font.pixelSize: window.height * 0.02
        color: "grey"
    }

}

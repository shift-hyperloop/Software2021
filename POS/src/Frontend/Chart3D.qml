import QtQuick 2.5
import QtQuick.Window 2.12
import QtDataVisualization 1.2
import QtQuick.Controls 2.5
Item {
    property var currentValues: [currentValue0,currentValue1,currentValue2,currentValue3]
    property var values: [values0,values1,values2,values3]
    property var colorArray: ["red","green","blue", "yellow"]
    property var axisMin: -5
    property var axisMax: 5
    property var sliderVisible: true
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
        min: -5
        max: 5
        autoAdjustRange: false
    }
    ValueAxis3D{
        id: yAxis
        min: -5
        max: 5
        autoAdjustRange: false
    }
    ValueAxis3D{
        id: zAxis
        min: -5
        max: 5
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


    }

}

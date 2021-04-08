import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
Page{

    id: stateIndicationPage


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
    property var names : ["Engage High Voltage", "Other Startup Protocol","Start" ]

    Button{
        text: "Engage High Voltage"
        height: window.height * 0.11
        width: window.width * 0.35
        font.pixelSize: window.height * 0.05
        x: window.width / 5
        y: window.height / 15 * 3
        onClicked: {
            //startupStatus.itemAt(index).status = 2
            //startupStatusText.itemAt(index).status = 2
        }
    }
    Rectangle{
        height: window.height*0.1
        width: height
        radius: height
        property int status: 0
        color: {
            if(status === 0){
               "red"
            }
            else if(status === 1 ){
               "yellow"
            }
            else{
                "green"
            }

        }
        x: window.width / 5 + window.width * 0.35 + window.width * 0.1
        y: window.height / 15 * 6 + window.height * 0.11 / 2 - height/2

        border.width: window.height*0.005

    }
    Text{
        property int status: 0
        x: window.width / 5 + window.width * 0.35 +  window.height*0.1+ window.width * 0.1 * 1.5
        y: window.height / 15 * 3 + window.height * 0.11 / 2 - height/2
        text: {
            if(status === 0){
               "Disengaged"
            }
            else if(status === 1 ){
               "Pending response"
            }
            else{
                "Engaged"
            }
        }
        font.pixelSize: window.height * 0.02
        color: "white"
    }

    Button{
        text: "Other Startup Protocol"
        height: window.height * 0.11
        width: window.width * 0.35
        font.pixelSize: window.height * 0.05
        x: window.width / 5
        y: window.height / 15 * 6
        onClicked: {
            //startupStatus.itemAt(index).status = 2
            //startupStatusText.itemAt(index).status = 2
        }
    }

    Rectangle{
        height: window.height*0.1
        width: height
        radius: height
        property int status: 0
        color: {
            if(status === 0){
               "red"
            }
            else if(status === 1 ){
               "yellow"
            }
            else{
                "green"
            }

        }
        x: window.width / 5 + window.width * 0.35 + window.width * 0.1
        y: window.height / 15 * 3 + window.height * 0.11 / 2 - height/2

        border.width: window.height*0.005

    }


    Text{
        property int status: 0
        x: window.width / 5 + window.width * 0.35 +  window.height*0.1+ window.width * 0.1 * 1.5
        y: window.height / 15 * 6 + window.height * 0.11 / 2 - height/2
        text: {
            if(status === 0){
               "Disengaged"
            }
            else if(status === 1 ){
               "Pending response"
            }
            else{
                "Engaged"
            }
        }
        font.pixelSize: window.height * 0.02
        color: "white"
    }
    Button{
        text: "Start"
        height: window.height * 0.11
        width: window.width * 0.35
        font.pixelSize: window.height * 0.05
        x: window.width / 5
        y: window.height / 15 * 9
        onClicked: {
            //startupStatus.itemAt(index).status = 2
            //startupStatusText.itemAt(index).status = 2
        }
    }

    Rectangle{
        height: window.height*0.1
        width: height
        radius: height
        property int status: 0
        color: {
            if(status === 0){
               "red"
            }
            else if(status === 1 ){
               "yellow"
            }
            else{
                "green"
            }

        }
        x: window.width / 5 + window.width * 0.35 + window.width * 0.1
        y: window.height / 15 * 9 + window.height * 0.11 / 2 - height/2

        border.width: window.height*0.005

    }

    Text{
        property int status: 0
        x: window.width / 5 + window.width * 0.35 +  window.height*0.1+ window.width * 0.1 * 1.5
        y: window.height / 15 * 9 + window.height * 0.11 / 2 - height/2
        text: {
            if(status === 0){
               "Disengaged"
            }
            else if(status === 1 ){
               "Pending response"
            }
            else{
                "Engaged"
            }
        }
        font.pixelSize: window.height * 0.02
        color: "white"
    }

}

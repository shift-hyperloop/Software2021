Item {
    DataManagerAccessor {
        id: dataManager

    }

    Button {
        id: connectButton
        x: 200
        y: 400
        text: "Connect"
        onClicked: dataManager.dataManager.connectToPod();
    }
    
    Button {
        id: sendButton
        x: 200
        y: 600
        text: "Send Data"
        onClicked: dataManager.dataManager.sendPodCommand(PodCommand.START);
    }
}
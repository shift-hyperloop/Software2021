const changeText = (label) => {
    let randomInt = Math.floor(Math.random() * 9);
    label.text = qsTr(randomInt.toString());
}

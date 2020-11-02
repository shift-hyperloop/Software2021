
let count = 0;
const click_func = (button) => {
    button.text = (count % 2 === 0) ? qsTr("lol") : qsTr("noob");
    count++;
}

function calculate(label1, label2) {
    let highNumber = Math.exp(150);
    let randomNum = Math.floor(Math.random() * 10000);
    label1.text=qsTr(randomNum.toString());
    label2.text=qsTr((randomNum * Math.floor(Math.random() * 100)).toString())
}

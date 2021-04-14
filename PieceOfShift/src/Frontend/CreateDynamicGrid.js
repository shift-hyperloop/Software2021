var component;
var cell;

function createSpriteObjects() {
    component = Qt.createComponent('Cell.qml');
    sprite = component.createObject(appWindow, { x: 100, y: 100 });

    if (sprite == null) {
        // Error Handling
        console.log('Error creating object');
    }
}

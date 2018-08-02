import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.1

Rectangle{
    id: imageButtonRoot

    clip: true

    width: 250
    height: 150
    color: 'transparent'

    signal entered()
    signal exited()
    signal pressed()
    signal released()
    signal clicked()
    signal pressAndHold

    property alias text: buttonText.text
    property alias font: buttonText.font
    property alias cursorShape: mouseArea.cursorShape

    property url firstImage: '../Icons/button.png'
    property url secondImage: '../Icons/button2.png'
    property url thirdImage: '../Icons/juzBox.png'

    property url src: src




    Image {
        id: buttonImage        
        source: src
        anchors.fill: parent
    }

    Text{
        id: buttonText ;
        anchors.centerIn: parent ;

        color: 'white'
        font.pointSize: 15
        renderType: Text.NativeRendering
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onEntered: imageButtonRoot.entered()
        onExited: imageButtonRoot.exited()
        onPressed: {imageButtonRoot.pressed() ;}
        onReleased: {imageButtonRoot.released()  ; }
        onClicked: imageButtonRoot.clicked()
        onPressAndHold: imageButtonRoot.pressAndHold()
    }
    
}

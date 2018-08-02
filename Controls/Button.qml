import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.1

Rectangle{

    id: root

    width: 50
    height: 50
    color: '#0197c9'


    property alias text: text.text
    property alias font: text.font
    property alias foreColor: text.color
    property alias imageSource: image.source


    signal entered()
    signal exited()
    signal pressed()
    signal released()
    signal clicked()
    signal pressAndHold

    border.width: 0
    border.color: 'skyblue'

    Behavior on scale{
        NumberAnimation{duration: 500 ; easing.type: Easing.OutExpo}
    }

    Text{
        id: text
        anchors.centerIn: parent
        color: 'white'
        font.pointSize: 15
        text: 'Text'

        Behavior on scale{
            NumberAnimation{duration: 500 ; easing.type: Easing.OutExpo}
        }


    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: {root.entered() ; text.scale = 1.1}
        onExited: {root.exited() ; text.scale = 1 }
        onPressed: {root.pressed() ; root.opacity = 0.7 }
        onReleased: {root.released() ; root.opacity = 1}
        onClicked: root.clicked()
        onPressAndHold: root.pressAndHold()
    }

    Image{
        id: image
        anchors.fill: parent
    }
}

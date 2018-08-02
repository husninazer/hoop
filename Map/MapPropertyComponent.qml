import QtQuick 2.9
import QtQuick.Controls 2.2


Column {

    signal moveToCurrentPosition()
    signal showMapTypeMenu()

    id: optionsMenuButtons
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 45
    anchors.right: parent.right; anchors.rightMargin: 10
    spacing: 10

    RoundButton {
        text: '\u25d4'
        height: width = 30

        onClicked: {
            moveToCurrentPosition()
        }
    }
    RoundButton {
        text: '\u25d1'
        height: width = 30

        onClicked: {
            showMapTypeMenu()
        }
    }

}


import QtQuick 2.9
import QtQuick.Controls 2.2

Column {

    anchors.bottom: parent.bottom
    anchors.bottomMargin: 30
    anchors.left: parent.left; anchors.leftMargin: 20


    RoundButton {
        text: '\u2713'
        height: width = 60
    }

    Rectangle {
        height: 20
        width: 4
        color: 'grey'
        anchors.horizontalCenter: parent.horizontalCenter
    }

    RoundButton {
        text: '\u2713'
        height: width = 60
    }

    Rectangle {
        height: 20
        width: 4
        color: 'grey'
        anchors.horizontalCenter: parent.horizontalCenter
    }

    RoundButton {
        text: qsTr("-")
        height: width = 60

    }
}

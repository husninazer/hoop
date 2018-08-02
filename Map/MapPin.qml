import QtQuick 2.9
import QtQuick.Controls 2.2

Column {
    id: locationPin

    property alias mapPinAnchor: mapPinAnchor

    signal getLocationText()


    anchors.centerIn: parent
    bottomPadding: 60
    Rectangle {
        height: width = radius = 40
        color: 'orange'
        border.color: 'red'

        Text {
            id: name
            anchors.centerIn: parent
            color: 'white'
            text: qsTr("15 m")
        }

        BusyIndicator {
            anchors.centerIn: parent

        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                getLocationText()
            }
        }
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        color: "orange"
        height: 20; width: 2
        border.color: 'red'
    }

    Rectangle {
        id: mapPinAnchor
        anchors.horizontalCenter: parent.horizontalCenter
        color: "red"
        height: width = radius = 5
    }

}

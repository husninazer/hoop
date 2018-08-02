import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0


import "../Controls" as Controls

Page {
    Image {
        anchors.fill: parent
        source: '../Images/background.jpg'
        fillMode: Image.PreserveAspectCrop
    }

    Controls.ImageButton{
                    id: btnReceive
                    width: 90
                    height: 130

                    anchors.centerIn: parent

                    src:  '../Images/fingerprint.png'

                    Behavior on scale {
                        NumberAnimation{duration: 500 ; easing.type: Easing.OutExpo}
                    }

                    cursorShape: Qt.PointingHandCursor
                    onEntered: { scale = 1.1}
                    onExited: { scale = 1}
                    onClicked: {
                        stackView.push('qrc:/Home/Receive.qml')
                    }
                }



}

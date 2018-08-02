import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0


import "../Controls" as Controls

Page {

    Component.onCompleted: {

    }

    Timer {
        interval: 500; running: true; repeat: true
                  onTriggered: {
                      btnReceive.scale === 1.1 ? btnReceive.scale = 1: btnReceive.scale = 1.1
                  }
    }

    Image {
        anchors.fill: parent
        source: '../Images/background.jpg'
        fillMode: Image.PreserveAspectCrop
    }

    PropertyAnimation {
        id: animFinger
        target: btnReceive
        property: 'scale'
        from: .5; to: 1
        duration: 300
        loops: Animation.Infinite
        easing.type: Easing.OutExpo
    }


    Column {
        anchors.centerIn: parent
        Controls.ImageButton {
                        id: btnReceive
                        width: 90
                        height: 130



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

        Controls.ImageButton {
                        id: btncancel
                        width: 90
                        height: 130
                        text: 'X Cancel'
                        font.pointSize: 20;
                        Behavior on scale {
                            NumberAnimation{duration: 500 ; easing.type: Easing.OutExpo}
                        }

                        cursorShape: Qt.PointingHandCursor
                        onEntered: { scale = 1.1}
                        onExited: { scale = 1}
                        onClicked: {
                            stackView.pop()
                        }
                    }


    }





    Controls.ImageButton{
                    id: btnBack
                    width: 50
                    height: 50

                    anchors.bottom: parent.bottom;anchors.bottomMargin: 15
                    anchors.left: parent.left; anchors.leftMargin: 15
                    src:  '../Images/back.png'

                    Behavior on scale {
                        NumberAnimation{duration: 500 ; easing.type: Easing.OutExpo}
                    }

                    cursorShape: Qt.PointingHandCursor
                    onEntered: { scale = 1.1}
                    onExited: { scale = 1}
                    onClicked: {
                        stackView.pop()
                    }
                }



}

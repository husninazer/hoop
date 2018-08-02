import QtQuick 2.9
import QtQuick.Controls 2.2

import "../Map"
//import QtQuick.Controls.Material 2.2

Popup {
    id: pop
    // anchors.centerIn: parent

    property variant stack: stack
    property string name: contactName.text

    signal push(variant content)
    signal clear()

    Component.onCompleted: {

        stack.push(amountForm)
    }

    enter: Transition {
        NumberAnimation { property: "scale"; from: 0.0; to: 1.0; duration: 100; }
    }

    exit: Transition {
        NumberAnimation { property: "scale"; from: 1.0; to: 0.0; duration: 100; }
    }

    width: parent.width - 2*(pop.leftMargin)
    height: parent.height - 2*(pop.topMargin)
    leftMargin: 15
    topMargin: 90
    modal: true
    focus: true

    onPush: {
        if (stack.depth !== 1)
        stack.push(content)
    }

    onClear: {
        txtAmount.text = ""
    }

    Item {
        id: stackPage
    }

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: stackPage
    }


    Component{
         id: amountForm
        Column {

            width: parent.width
            topPadding: 20
            spacing: 20


            Label {
                id: contactName
                anchors.horizontalCenter: parent.horizontalCenter
            }



            Label {
                text: 'Amount'
                anchors.horizontalCenter: parent.horizontalCenter
            }
            TextField {
                id: txtAmount
                width: parent.width - 80
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: 'Amount to Send'

            }

            Button {
                id: btnLogin
                text: 'Send'
                width: parent.width - 80
                anchors.horizontalCenter: parent.horizontalCenter
                highlighted: true

                ToolTip.timeout: 5000

                onClicked: {


                    if(txtLoginUserName.text === '' || txtLoginPassword.text === '') {
                        btnLogin.ToolTip.text = 'Fill in the amount to send'
                        btnLogin.ToolTip.visible = true
                        return
                    }


                    busyIndicatorLoginPage.visible = true
                    stackView.push("qrc:/Home/HomeComponent.qml")
                }
            }

    }
    }

}

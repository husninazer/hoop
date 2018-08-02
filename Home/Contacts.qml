import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0


import "../Controls" as Controls

Item {

    property real _width: contactsGridView.width
    property real _height: contactsGridView.height

    Component.onCompleted: {
        setModel()
    }

    Column {

        anchors.fill: parent
        anchors.topMargin: 10; anchors.leftMargin: 10

        GridView{

            id: contactsGridView

            width: parent.width
            height: parent.height - 40
            cellWidth: 85
            cellHeight: 80

            layoutDirection: Qt.LeftToRight
            clip: true

            add: Transition {
                NumberAnimation { properties: "x , y";  duration: 1000 ;easing.type: Easing.OutExpo }
            }

            delegate: Column {

                Controls.ImageButton{


                width: 60
                height: 60

                Behavior on scale {
                    NumberAnimation{duration: 1000 ; easing.type: Easing.OutExpo}
                }

                src: "qrc:/Images/contact.png"

                cursorShape: Qt.PointingHandCursor



                onEntered: { scale = 1.1}
                onExited: { scale = 1}
                onClicked: {

                  //  popupAmount.stack.push(amountForm)
                    popupAmount.clear()
                    popupAmount.name ="asfdasfasdf"
                    popupAmount.open()
                }


            }
                Text {
                    text: modelData.name
                    font.family: fontCLBold.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: 'white'
                }

            }

            Controls.ScrollBar{
                width: 10
                Component.onCompleted: target = parent
            }
        }
    }





    function setModel()
    {

        var contacts = [
                    {name: 'Mohammed ', id: '543243452345'},
                    {name: 'ISmail', id: '1345478567'},
                    {name: 'Ibrahim', id: '65784525'},
                    {name: 'Hamza', id: '456346'},
                    {name: 'Maryam', id: '234523523'},
                    {name: 'Ibrahim', id: '65784525'},
                    {name: 'Hamza', id: '456346'},
                    {name: 'Maryam', id: '234523523'},
                    {name: 'Ibrahim', id: '65784525'},
                    {name: 'Hamza', id: '456346'},
                    {name: 'Maryam', id: '234523523'},
                    {name: 'Ibrahim', id: '65784525'},
                    {name: 'Hamza', id: '456346'},
                    {name: 'Maryam', id: '234523523'},
                    {name: 'Ibrahim', id: '65784525'},
                    {name: 'Hamza', id: '456346'},
                    {name: 'Maryam', id: '234523523'}

         ]

        contactsGridView.model = ''
        contactsGridView.model = contacts
    }

}



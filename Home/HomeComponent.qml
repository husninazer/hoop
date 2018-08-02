import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import "../Map"

import "../Controls" as Controls


Page {
    id: root


    Component.onCompleted: {
      // createMap("mapbox")
       homeAnim.stop(); homeAnim.start()
    }

    PropertyAnimation {
        id: homeAnim
        target: mainTag ; from: 5 ; to: 1 ; easing.type: Easing.OutExpo
        property: 'scale' ; duration: 600
    }



    Image {
        anchors.fill: parent
        source: '../Images/background.jpg'
        fillMode: Image.PreserveAspectCrop
    }

    FontLoader {
        id: fontCLBold
        source: '../Fonts/Champagne & Limousines Bold.ttf'
    }

    Rectangle {
        id: balance
        width: parent.width
        height:  parent.height * .25

        color: '#54637a'

        Text  {
            id: text
            anchors.horizontalCenter: parent.horizontalCenter
            text: '\n\nBALANCE: 203 prims'; color: 'white'; font.pointSize: 35
            font.family:fontCLBold.name
        }


        layer.enabled: true

        layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0
                        verticalOffset: 3

                        color: "#344e77"
                    }

    }



    //Access Buttons LEft and Right
    Row {
        id: mainTag
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 50

        width : parent.width
        spacing: 20


        Controls.ImageButton{
                        id: btnReceive
                        width: 120
                        height: 120

                        src:  '../Images/button.png'

                        Behavior on scale {
                            NumberAnimation{duration: 500 ; easing.type: Easing.OutExpo}
                        }

                        cursorShape: Qt.PointingHandCursor
                        text:   "RECEIVE"
                        onEntered: { scale = 1.1}
                        onExited: { scale = 1}
                        onClicked: {
                            stackView.push('qrc:/Login.qml')
                        }
                    }





        Controls.ImageButton{

                        width: 120
                        height: 120

                        src:  '../Images/button.png'



                        Behavior on scale {
                            NumberAnimation{duration: 1000 ; easing.type: Easing.OutExpo}
                        }

                        cursorShape: Qt.PointingHandCursor
                        text:   "SEND"
                        onEntered: { scale = 1.1}
                        onExited: { scale = 1}
                        onClicked: {
                            stackView.push('qrc:/Home/Send.qml')
                        }
                    }


    }



    Component {
        id: mapComponent

        MapComponent{

         // anchors.fill: startPointPop


            onFollowmeChanged: mainMenu.isFollowMe = map.followme
            // onSupportedMapTypesChanged: mainMenu.mapTypeMenu.createMenu(map)
            onCoordinatesCaptured: {
                var text = "<b>" + qsTr("Latitude:") + "</b> " + Helper.roundNumber(latitude,4) + "<br/><b>" + qsTr("Longitude:") + "</b> " + Helper.roundNumber(longitude,4)
                stackView.showMessage(qsTr("Coordinates"),text);
            }
            onGeocodeFinished:{
                if (map.geocodeModel.status == GeocodeModel.Ready) {
                    if (map.geocodeModel.count == 0) {
                        stackView.showMessage(qsTr("Geocode Error"),qsTr("Unsuccessful geocode"))
                    } else if (map.geocodeModel.count > 1) {
                        stackView.showMessage(qsTr("Ambiguous geocode"), map.geocodeModel.count + " " +
                                              qsTr("results found for the given address, please specify location"))
                    } else {
                        console.log("Geocode Finished")
                        // stackView.showMessage(qsTr("Location"), geocodeMessage(),page)
                    }
                } else if (map.geocodeModel.status == GeocodeModel.Error) {
                    stackView.showMessage(qsTr("Geocode Error"),qsTr("Unsuccessful geocode"))
                }
            }
            onRouteError: stackView.showMessage(qsTr("Route Error"),qsTr("Unable to find a route for the given points"),page)

            onShowGeocodeInfo: stackView.showMessage(qsTr("Location"),geocodeMessage(),page)

            onErrorChanged: {
                if (map.error != Map.NoError) {
                    var title = qsTr("ProviderError")
                    var message =  map.errorString + "<br/><br/><b>" + qsTr("Try to select other provider") + "</b>"
                    if (map.error == Map.MissingRequiredParameterError)
                        message += "<br/>" + qsTr("or see") + " \'mapviewer --help\' "
                                + qsTr("how to pass plugin parameters.")
                    stackView.showMessage(title,message);
                }
            }
            onShowMainMenu: mapTypeMenu.show()
            onShowRouteMenu: itemPopupMenu.show("Route",coordinate)
            onShowPointMenu: itemPopupMenu.show("Point",coordinate)
            onShowRouteList: stackView.showRouteListPage()

            MapPin {
                id: mapPin

                onGetLocationText: {
                    var currentCoordinate = map.toCoordinate(Qt.point(map.width/2, map.height/2))

                    map.geocode(currentCoordinate)

                }
            }



            MapPropertyComponent {
                onMoveToCurrentPosition: {
                    map.center = map.currentPosition
                }

                onShowMapTypeMenu: {
                    mapTypeMenu.show()
                    //showMainMenu()
                }


            }
        }
    }

    function createMap(provider)
    {
        var zoomLevel = null
        var tilt = null
        var bearing = null
        var fov = null
        var center = null
        var panelExpanded = null

        if (map) {
            zoomLevel = map.zoomLevel
            tilt = map.tilt
            bearing = map.bearing
            fov = map.fieldOfView
            center = map.center
            panelExpanded = map.slidersExpanded
            map.destroy()
        }

         map = mapComponent.createObject(startPointPop);


        if (zoomLevel != null) {
            map.tilt = tilt
            map.bearing = bearing
            map.fieldOfView = fov
            map.zoomLevel = zoomLevel
            map.center = center
            map.slidersExpanded = panelExpanded
        } else {
            // Use an integer ZL to enable nearest interpolation, if possible.
            map.zoomLevel = 15
            // defaulting to 45 degrees, if possible.
            map.fieldOfView = Math.min(Math.max(45.0, map.minimumFieldOfView), map.maximumFieldOfView)
        }

        map.forceActiveFocus()

        map.center = map.currentPosition


        // Android Get GPS settings right

        if (Qt.platform.os == "android") {
            if(androidDevice.locationProviders().indexOf('GPS') === -1 ){
                androidDevice.openLocationSettings()
            }
        }

    }

}

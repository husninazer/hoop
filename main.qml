import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import QtLocation 5.9
import QtPositioning 5.8

import MobileDevice 0.1

import "Map"
import "Home"


ApplicationWindow {
    id: appWindow
    visible: true
    width: 360
    height: 640
    title: qsTr("HOOP")


    property variant map
    property variant home

    Component.onCompleted: {
        //createMap("mapbox")

    }

    MobileDevice {
        id: androidDevice
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: homeComponent
    }


//    Component {

//        id: mapComponent

//        MapComponent{
//            width: page.width
//            height: page.height
//            onFollowmeChanged: mainMenu.isFollowMe = map.followme
//           // onSupportedMapTypesChanged: mainMenu.mapTypeMenu.createMenu(map)
//            onCoordinatesCaptured: {
//                var text = "<b>" + qsTr("Latitude:") + "</b> " + Helper.roundNumber(latitude,4) + "<br/><b>" + qsTr("Longitude:") + "</b> " + Helper.roundNumber(longitude,4)
//                stackView.showMessage(qsTr("Coordinates"),text);
//            }
//            onGeocodeFinished:{
//                if (map.geocodeModel.status == GeocodeModel.Ready) {
//                    if (map.geocodeModel.count == 0) {
//                        stackView.showMessage(qsTr("Geocode Error"),qsTr("Unsuccessful geocode"))
//                    } else if (map.geocodeModel.count > 1) {
//                        stackView.showMessage(qsTr("Ambiguous geocode"), map.geocodeModel.count + " " +
//                                              qsTr("results found for the given address, please specify location"))
//                    } else {
//                        console.log("Geocode Finished")
//                       // stackView.showMessage(qsTr("Location"), geocodeMessage(),page)
//                    }
//                } else if (map.geocodeModel.status == GeocodeModel.Error) {
//                    stackView.showMessage(qsTr("Geocode Error"),qsTr("Unsuccessful geocode"))
//                }
//            }
//            onRouteError: stackView.showMessage(qsTr("Route Error"),qsTr("Unable to find a route for the given points"),page)

//            onShowGeocodeInfo: stackView.showMessage(qsTr("Location"),geocodeMessage(),page)

//            onErrorChanged: {
//                if (map.error != Map.NoError) {
//                    var title = qsTr("ProviderError")
//                    var message =  map.errorString + "<br/><br/><b>" + qsTr("Try to select other provider") + "</b>"
//                    if (map.error == Map.MissingRequiredParameterError)
//                        message += "<br/>" + qsTr("or see") + " \'mapviewer --help\' "
//                                + qsTr("how to pass plugin parameters.")
//                    stackView.showMessage(title,message);
//                }
//            }
//            onShowMainMenu: mapTypeMenu.show()
//            onShowRouteMenu: itemPopupMenu.show("Route",coordinate)
//            onShowPointMenu: itemPopupMenu.show("Point",coordinate)
//            onShowRouteList: stackView.showRouteListPage()

//            MapPin {
//                id: mapPin

//                onGetLocationText: {
//                    var currentCoordinate = map.toCoordinate(Qt.point(map.width/2, map.height/2))

//                    map.geocode(currentCoordinate)

//                }
//            }



//            MapPropertyComponent {
//                onMoveToCurrentPosition: {
//                    map.center = map.currentPosition
//                }

//                onShowMapTypeMenu: {
//                    showMainMenu()
//                }


//            }
//        }
//    }


    Component {
        id: homeComponent

        HomeComponent {
            id: home

        }
    }



    MapTypeMenu {
        id: mapTypeMenu

        function show()
        {
           // stackView.pop(page)
            mapTypeMenu.createMenu(map)
            mapTypeMenu.popup()

        }

        onItemClicked: {
            //stackView.pop(page)
            console.log(mapType)
            map.activeMapType = mapType
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

       map = mapComponent.createObject(page);


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

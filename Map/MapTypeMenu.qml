import QtQuick 2.9
import QtQuick.Controls 1.4


Menu {
    id: root
    title: qsTr("MapType")
    property var type
    signal itemClicked(variant mapType)


    function createMenu(map)
    {
        clear()
        for (var i = 0; i<map.supportedMapTypes.length; i++) {
            createMapTypeMenuItem(map.supportedMapTypes[i]).checked =
                    (map.activeMapType === map.supportedMapTypes[i]);
        }
    }

    function createMapTypeMenuItem(mapType)
    {
        var item = addItem(mapType.name);
        item.checkable = true;
        item.triggered.connect(function(){itemClicked(mapType)})
        return item;
    }
}

import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Events"
import "qrc:/Components"
import "qrc:/Contacts"
import "qrc:/Favorites"
import "qrc:/Messages"
import "qrc:/News"
import "qrc:/Preferences"
import "qrc:/Qualifications"
import "qrc:/Search"
import "qrc:/Shared"
import "qrc:/Styles"

Rectangle {
    id: mainPage
    anchors.fill: parent
    property int selectedGroupID: 0
    property int selectedIndex: 0
    property alias lblNoData: lblNoData
    property alias listGroups: menuList

	VMContactsListGrouped {
        id: menuList
        anchors.fill: parent
        onListItemPressAndHold: {
            selectedGroupID= id
            selectedIndex=index
            menuLongPress.open();
        }
        onListItemClicked: {
            mainStack.push({item:Qt.resolvedUrl("qrc:///Contacts/VContactsInGroup.qml"),destroyOnPop:true,properties:{groupID:id}})
        }
    }
    Menu {
        id: menuLongPress
        MenuItem {
            id: menuDelete
			text: enguia.tr("Delete")
            /*onClicked: {
                pageTitle.busyIndicator.visible=true;
                mContacts.removeGroup(selectedGroupID)
            }*/
        }
    }
    Label {
        id: lblNoData
		text: enguia.tr("No groups yet")
        color: "blue"
        font {pointSize: enguia.largeFontPointSize }
        anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
        visible: false
    }
}

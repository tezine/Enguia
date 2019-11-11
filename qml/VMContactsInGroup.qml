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
    property int groupID: 0

    VMPageTitle {
        id: pageTitle
		title: enguia.tr("Contacts")
        busyIndicator.visible: true
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
    }
	VMContactsList {
        id: listContacts
        anchors { top: pageTitle.bottom; left:parent.left;right: parent.right;bottom: parent.bottom }
        onListItemPressAndHold: menuLongPress.open();
        onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Contacts/VContactsDetail.qml"),destroyOnPop:true,properties:{contactID:selectedContactID}})
    }
    Menu {
        id: menuLongPress
        MenuItem {
            id: menuDelete
			text: enguia.tr("Delete from group")
            onTriggered: {
                pageTitle.busyIndicator.visible=true;
                //mContacts.removeContactFromGroup(listContacts.selectedContactID,groupID)
            }
        }
    }
    VMBanner {
        id: banner
    }
    Connections {
        target: mContacts
        onSigRespGetContactsInGroup:{
            pageTitle.busyIndicator.visible=false;
            for(var i=0;i<list.length;i++){
                var e=list[i];
                listContacts.append(e.userID,e.contactID,e.name,e.image);
            }
        }

        /*ignoreUnknownSignals: true
        onRemovedContactFromGroup: {
            pageTitle.busyIndicator.visible=false;
			if(!ok)banner.popup(enguia.tr("Unable to remove contact"));
            else mData.pop();
        }*/
    }
    Component.onCompleted: {
        mContacts.getContactsInGroup(groupID);
    }
}


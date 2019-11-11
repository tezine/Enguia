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
    id: contactsMain
    signal sigGetGroups();

    VMPageTitle {
        id: pageTitle
		title: enguia.tr("Contacts")
        busyIndicator.visible: true
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
        VMToolButton {
            id: toolMenu
            anchors.right: parent.right
            source: "qrc:///SharedImages/overflow.png"
            onSigClicked: myMenu.open()
        }
    }
    TabView {
        id: tabView
        anchors { top: pageTitle.bottom; bottom: parent.bottom }
        width: parent.width
        style: tabViewStyleAndroid
        Tab{
			title:enguia.tr("List");
            onLoaded: getContacts(mShared.userID);
			VMContacts{
                id: tabContactList
            }
        }
        Tab{
			title:enguia.tr("Grouped");
            onLoaded: mContacts.getGroups(mShared.userID)
			VMContactsGrouped{
                id: tabContactsGrouped
            }
        }
    }
    Menu {
        id: myMenu
        MenuItem {
            id: menuPictures
			text: enguia.tr("Search a user")
            //onClicked: mData.push(MData.PageTypeContactsSearchMain)
        }
        MenuItem {
            id: menuAddGroup
			text: enguia.tr("Add a group")
            //	onClicked: mData.push(MData.PageTypeContactsGroupEdit)
        }
    }
    VMBanner {
        id: banner
    }
    Connections {
        target: mContacts
        onSigRespGetGroups:{
            //if(list.length===0) tabGroupsList.lblNoData.visible=true;
            pageTitle.busyIndicator.visible=false;
            for(var i=0;i<list.length;i++){
                var e=list[i];
                tabView.getTab(1).item.listGroups.append(e.name,e.id, e.image);//	image era 'qrc:/Images/'+mData.getImageNameFromIconID(list[i].iconID)
            }
        }
        /*		ignoreUnknownSignals: true
        onRemovedGroup: {
            pageTitle.busyIndicator.visible=false
            if(ok)tabGroupsList.listGroups.listModel.remove(tabGroupsList.selectedIndex)
            else  banner.popup(qsTr('Failed to remove group'));
        }
        onContactRemoved: {
            if(ok)tabContactList.listContacts.listModel.remove(tabContactList.selectedIndex)
            else banner.popup(qsTr('Failed to remove contact'));
        }
        onAnswerAddToGroup: {
            banner.popup(qsTr("Contact added to group"));
        }*/
    }    
    function getContacts(currentUserID){
        mContacts.getContacts(currentUserID,function(list){
            //if(list.length===0) tabContactList.lblNoData.visible=true;
            pageTitle.busyIndicator.visible=false;
            for(var i=0;i<list.length;i++){
                var e=list[i];
                tabView.getTab(0).item.listContacts.append(e.userID, e.contactID, e.login,e.image)
            }
        })
    }
}





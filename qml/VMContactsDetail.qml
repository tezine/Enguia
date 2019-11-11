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

VMTopWindow {
    id: topWindow
    property int userID: 0
    property string userName: ""
    property int contactID: 0
    property bool newsEnabled: false

	VMPageTitle{
        id: pageTitle
		title: enguia.tr("Detail")
        busyIndicator.visible:true
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		VMToolButton {
            id: toolMenu
            anchors.right: parent.right
            source: "qrc:///Images/overflow.png"
            onSigClicked: menu.open()
        }
    }
    ListModel{
        id: listModel
    }
    ListView{
        anchors{top: pageTitle.bottom; bottom:parent.bottom;}
        clip: true
        width: parent.width
        id: list
        model: listModel
        delegate: VSampleDelegate{}
        cacheBuffer: 1
        //interactive:false
    }
    Menu{
        id: menu
        MenuItem{
            id: menuSendMessage
			text: enguia.tr("Send message")
            //onClicked: mData.push(MData.PageTypeMessagesAddEdit,{toUserID:userID, toUserName:userName})
        }
        MenuItem{
            id: menuDelete
			text: enguia.tr("Delete")
			//onClicked:dlgDelete.popup(enguia.tr("Contact Removal"), enguia.tr("Are you sure you want to delete the contact?"))
        }
        MenuItem{
            id: menuNews
            /*onClicked: {
                if(newsEnabled)mContacts.enableNews(contactID,false);
                else mContacts.enableNews(contactID,true)
            }*/

        }
        MenuItem{
            id: menuAddToGroup
			text: enguia.tr("Add to group...")
            //onClicked: dlgGroups.popup()
        }
    }
	VMBanner{
        id: banner
    }
	VDlgQuery{
        id: dlgDelete
        onSigConfirmed: {
            pageTitle.busyIndicator.visible=true;
            //mContacts.removeContact(contactID)
        }
    }
	VMDlgGroups{
        id: dlgGroups
        //onSigGroupSelected: mContacts.addToGroup(contactID,groupID)
    }
    Connections{
        target: mContacts
        onSigRespGetDetail:{
            pageTitle.busyIndicator.visible=false;
            topWindow.userID=e.userID;
            topWindow.userName=e.name;
            topWindow.contactID=e.contactID;
			if(newsEnabled)menuNews.text=enguia.tr("Disable News");
			else menuNews.text=enguia.tr("Enable News");
			if(e.name && e.name.length>0)listModel.append({title:enguia.tr("Name"),description:e.name})
			if(e.homePhone && e.homePhone.length>0)listModel.append({title:enguia.tr("Home Phone"),description: e.homePhone})
			if(e.mobilePhone &&e.mobilePhone.length>0)listModel.append({title:enguia.tr("Mobile Phone"),description: e.mobilePhone})
			if(e.email1 &&e.email1.length>0)listModel.append({title:enguia.tr("Email"),description:e.email1})
			if(e.homeAddress &&e.homeAddress.length>0)listModel.append({title:enguia.tr("Address"),description:e.homeAddress})
			if(e.homePostalCode &&e.homePostalCode.length>0)listModel.append({title:enguia.tr("Zipcode"),description:e.homePostalCode})
			if(e.bornDate &&e.bornDate.length>0)listModel.append({title:enguia.tr("Birthday"),description: Qt.formatDate(e.bornDate,Qt.DefaultLocaleShortDate)})
        }

        /*ignoreUnknownSignals: true
        onAnswerAddToGroup:{
			if(!ok) banner.popup(enguia.tr('Failed to add to group'));
            else mData.pop()
        }
        onContactRemoved: {
            pageTitle.busyIndicator.visible=false;
			if(!ok) banner.popup(enguia.tr('Failed to remove contact'));
            else mData.pop();
        }
        onAnswerEnableNews: {
			if(!ok)banner.popup(enguia.tr("Failed to toogle News"));
            else {
                if(newsEnabled){
					banner.popup(enguia.tr("News disabled"));
                    newsEnabled=false;
					menuNews.text=enguia.tr("Enable News");
                    }else{
						banner.popup(enguia.tr("News enabled"));
                        newsEnabled=true;
						menuNews.text=enguia.tr("Disable News");
                    }
                }
            }*/
    }
    Component.onCompleted:{
        mContacts.getDetail(contactID);
    }
}

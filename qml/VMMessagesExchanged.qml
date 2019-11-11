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

Rectangle{
    id: mainPage
    property int otherUserID: 0
    property string otherUserName: ""
    property int selectedMsgID: 0
    property int selectedMsgIndex: 0
    property int fromUsrID: 0
    property int toUsrID: 0

    VMPageTitle{
        id: pageTitle
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
    }
	VMMessagesHistoryList{
        id: menuList
        anchors{top: pageTitle.bottom;left: parent.left;right: parent.right;bottom: parent.bottom}
        onListItemPressAndHold:{
            selectedMsgID= id;
            selectedMsgIndex = index;
            fromUsrID=fromUserID;
            toUsrID=toUserID;
            menuLongPress.open();
        }
    }
    Menu{
        id: menuLongPress
        MenuItem{
            id: menuDelete
			text: enguia.tr("Delete")
            //onClicked: mMessages.removeMessage(selectedMsgID)
        }
        MenuItem{
            id: menuDeleteAll
			text: enguia.tr("Delete all")
            /*onClicked:{
                if(mData.userID===toUsrID)mMessages.removeMessagesWithUser(fromUsrID)
                else mMessages.removeMessagesWithUser(toUsrID)
            }*/
        }
    }
    /*InfoBanner{
        id: banner
        timeout: 3000
    }*/
    Connections{
        id: messagesConnection
        /*ignoreUnknownSignals: true
        onMessageRemoved:{
            if(!ok){
                banner.text=qsTr('Failed to remove message');
                banner.open();
                }else{
                    menuList.listModel.remove(selectedMsgIndex)
                }
            }
            onAllMessagesWithUserRemoved:{
                if(ok)mData.push(MData.PageTypeMessagesMain);
                else{
                    banner.text=qsTr('Failed to remove messages');
                    banner.open();
                }
            }*/
        }

        function setup(status){
            /*		if(status===MData.PageStatusCreatedWithParameters){
                mMessages=mData.mMessages;
                messagesConnection.target=mMessages
                menuList.listModel.clear()
                mMessages.getMessagesExchanged(otherUserID)
                return
            }
            if(status!==PageStatus.Active)return*/
        }
        function appendMsg(id, content, dateInserted, fromUserID, toUserID, msgType){
            menuList.append(id,content, dateInserted, fromUserID, toUserID, msgType);
        }
    }

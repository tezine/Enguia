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
    id: tabMessagesList
    anchors.fill: parent
    property alias listNews: listNews
    property alias lblNoData: lblNoData
    property int selectedContactID: 0
    property int selectedNewsID: 0
    property int selectedUserID: 0
    property int selectedIndex: 0

	VMNewsList{
        id: listNews
        anchors.fill: parent
        /*onListItemPressAndHold:{
            selectedContactID=contactID;
            if(userID===mData.userID)return;
            myMenu.open();
        }
        onListItemClicked:{
            selectedNewsID=id;
            selectedUserID=userID;
            selectedIndex=index;
            if(userID===mData.userID){
                menuRemove.visible=true;
                menuLike.visible=false;
                menu1.open();
                }else{
                    menuRemove.visible=false;
                    menuLike.visible=true;
                    menu1.open();
                }
            }
			*/
        }
        Menu{
            id: myMenu
            MenuItem{
                id: menuToday
				text: enguia.tr("Unsubscribe")
                //onClicked: dlgQuery.popup(qsTr("Unsubscribe News"), qsTr("Are you sure you want to unsubscribe to all news from the selected contact?"),"qrc:/Images/question.png",1)
            }
        }
        Menu	{
            id: menu1
            MenuItem{
                id: menuComment
				text: enguia.tr("Comment")
                //onClicked: mData.push( MData.PageTypeNewsCommentAdd,{newsID:selectedNewsID,userID: selectedUserID})
            }
            MenuItem{
                id: menuViewComments
				text: enguia.tr("View Comments")
                //onClicked: mData.push(MData.PageTypeNewsComments,{newsID: selectedNewsID, userID: selectedUserID})
            }
            MenuItem{
                id: menuRemove
				text: enguia.tr("Delete")
                //onClicked: dlgQueryDeleteNews.popup(qsTr("Delete News"),qsTr("Are you sure you want to remove the News? It will remove all comments associated with it."),"qrc:/Images/question.png",1)
            }
            MenuItem{
                id: menuLike
				text: enguia.tr("Like it")
                //onClicked: mNews.likeNews(selectedUserID,selectedNewsID)
            }
        }
		VDlgQuery{
            id: dlgQuery
            //onSigConfirmed: mNews.unsubscribe(selectedContactID)
        }
        VMDlgQuery{
            id: dlgQueryDeleteNews
            //onSigConfirmed: mNews.removeNews(selectedNewsID)
        }
        Label{
            id: lblNoData
            anchors{horizontalCenter: parent.horizontalCenter;verticalCenter: parent.verticalCenter}
            font{pointSize: enguia.largeFontPointSize}
			text: enguia.tr("No news available")
            color: "blue"
            visible: false
        }
    Component.onCompleted:{
        if(enguia.isPreview()){
            listNews.append(1,1,1,1,'Rockover','','Novo show','2014-01-01',3);
        }
    }
}




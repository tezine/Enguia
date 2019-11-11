import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
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
import "qrc:/"

Rectangle {

	VMPageTitle{
		id:pageTitle
		title:enguia.tr("Search")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
	}
	ColumnLayout{
		id: columnLayout
		anchors{top: pageTitle.bottom;topMargin: enguia.mediumMargin;left:parent.left; leftMargin: enguia.smallMargin;right:parent.right; rightMargin: enguia.smallMargin;}
		spacing: enguia.smallMargin
		VMTextField{
			id: txtSearch
			Layout.fillWidth:true
			placeholderText: enguia.tr("Subject or content")
			onAccepted: btnSearchClicked()
		}
		VMButton{
			id: btnSearch
			Layout.alignment: Qt.AlignCenter
			Layout.fillWidth:true
			text:enguia.tr("Search");
			onClicked: btnSearchClicked();
		}
	}
	VMMessagesSearchList{
		id: messagesList
		anchors{left:parent.left;right:parent.right;bottom:parent.bottom;top:columnLayout.bottom; topMargin:enguia.mediumMargin}
		onSigEndOfListReached: searchMessages(txtSearch.text)
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Messages/VMMessagesDetail.qml"),destroyOnPop:true,immediate:true, properties:{msgID:id, markAsRead:false, displayReplyButton:false}})
	}
	function btnSearchClicked(){
		Qt.inputMethod.commit();
		if(txtSearch.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		statusBar.visible=false;
		Qt.inputMethod.hide();
		messagesList.clear()
		messagesList.loading=true;
		searchMessages(txtSearch.text)
	}
	function searchMessages(txt){
		mSVC.metaInvoke(MSDefines.SUserMessages,"SearchUserMessages",function(list){
			messagesList.loading=false;
			if(list.length>=0)messagesList.pageNumber++;
			if(list.length===0){statusBar.displayError(enguia.tr("Nothing found"));return;}
			for(var i=0;i<list.length;i++){
				var eMessage=list[i];
				messagesList.append(eMessage);
			}
		},txt,mShared.userID,enguia.listCount,messagesList.pageNumber);
	}	
}


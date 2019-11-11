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

	VMMessagesList{
		id: sentList
		anchors.fill: parent
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Messages/VMMessagesDetail.qml"),destroyOnPop:true,immediate:true, properties:{msgID:id, markAsRead:false, displayReplyButton:false}})
		onListItemPressAndHold: showDelete(id);
		onSigBtnDeleteClicked:removeMsg(id);
		onSigEndOfListReached: getSentMsgs();
	}
	function removeMsg(id){
		mSVC.metaInvoke(MSDefines.SUserMessages,"RemoveMsg",function(ok){
			if(ok)sentList.remove(id);
			else statusBar.displayError(enguia.tr("Unable to remove message"));
		},id)
	}
	function getSentMsgs(){
		sentList.loading=true;
		mSVC.metaInvoke(MSDefines.SUserMessages,"GetMsgsUserSent",function(list){
			sentList.loading=false;
			if(list.length>=0)sentList.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eMessage=list[i];
				sentList.append("sent", eMessage);
			}
		},mShared.userID,enguia.listCount,sentList.pageNumber);
	}
	function refresh(){
		sentList.clear();
		sentList.clearBackColor();
		getSentMsgs();
	}
	Component.onCompleted: {
		refresh();
	}
}


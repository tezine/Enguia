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
	property alias listView: receivedList

	VMMessagesList{
		anchors.fill: parent
		id: receivedList
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Messages/VMMessagesDetail.qml"),destroyOnPop:true,immediate:true, properties:{msgID:id, markAsRead:true, displayReplyButton:true}})
		onListItemPressAndHold: showDelete(id)
		onSigBtnDeleteClicked:removeMsg(id);
		onSigEndOfListReached: refresh();
	}
	function removeMsg(id){
		mSVC.metaInvoke(MSDefines.SUserMessages,"RemoveMsg",function(ok){
			if(ok)receivedList.remove(id);
			else statusBar.displayError(enguia.tr("Unable to remove message"));
		},id)
	}
	function refresh(){
		receivedList.loading=true;
		mSVC.metaInvoke(MSDefines.SUserMessages,"GetMsgsUserReceived",function(list){
			receivedList.loading=false;
			if(list.length>=0)receivedList.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eMessage=list[i];
				receivedList.append("received", eMessage);
			}
		},mShared.userID,enguia.listCount,receivedList.pageNumber);
	}
	function clear(){
		receivedList.clear();
	}
	Component.onCompleted: {
		receivedList.clear();
		refresh();
	}
}


import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/BlockSchedule"

Rectangle {
	property var today:new Date();
	property int professionalID:0
	property string professionalName:""
	property bool canSendMsgToClients:false
	property int selectedUserID:0
	property int selectedClientID:0
	property string selectedClientName:""
	property int selectedServiceID:0
	property date selectedDate:new Date();
	property int selectedQueueID:0

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Waiting queue")
		btnDoneVisible: false
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolHelp
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///SharedImages/help.png"
				onSigClicked: dlgHelp.setup(MSDefines.HelpTypeMobileBlockScheduleProQueue);
			}
		}
	}
	VMBlockScheduleProQueueList{
		id: queueList
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		onListItemPressAndHold: {
			console.debug("selected:",userID)
			selectedQueueID=id;
			selectedUserID=userID;
			selectedClientID=clientID;
			selectedClientName=name;
			selectedDate=dt;
			selectedServiceID=serviceID
			contextMenu.popup();
		}
	}
	Menu {
		id: contextMenu
		MenuItem{
			text: enguia.tr("Send message...")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///Messages/VMMessagesEdit.qml"),destroyOnPop:true,properties:{toUserID:selectedUserID}})
			visible: canSendMsgToClients
		}
		MenuItem{
			text: enguia.tr("Create appointment...")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProAgendaEdit.qml"),destroyOnPop:true,immediate:true, properties:{scheduleID:0,selectedClientName:selectedClientName, selectedClientID:selectedClientID,  serviceID:selectedServiceID, professionalID:professionalID, professionalName:professionalName, selectedDate:selectedDate}})
		}
		MenuItem{
			text: enguia.tr("Remove")
			onTriggered: removeSelectedQueue()
		}
	}
	function removeSelectedQueue(){
		mSVC.metaInvoke(MSDefines.SPlaceScheduleQueue,"RemoveQueue",function(ok){
			statusBar.displayResult(ok,enguia.tr("Removed successfully"),enguia.tr("Unable to remove"))
			if(ok)refresh();
		},selectedQueueID);
	}
	function refresh(){
		queueList.clear();
		queueList.loading=true;
		mSVC.metaInvoke(MSDefines.SPlaceScheduleQueue, "GetProfessionalQueue",function(list){
			queueList.loading=false;
			if(list===undefined)return;
			for(var i=0;i<list.length;i++){
				var eScheduleQueue=list[i];
				queueList.append(eScheduleQueue)
			}
		},professionalID,enguia.convertToDateISOString(today));
	}
	Component.onCompleted: {
		refresh();
	}
}


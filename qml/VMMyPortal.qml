import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/MyPortal"
import "qrc:/"

Rectangle {	

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("My portal")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolAdd
				source: "qrc:///Images/add.png"
				Layout.fillHeight: true
				Layout.preferredWidth: height
				onSigClicked: btnAddClicked();
			}
			VMToolButton{
				id: toolMenu
				source: "qrc:///SharedImages/overflow.png"
				Layout.fillHeight: true
				Layout.preferredWidth: height
				onSigClicked: menu.popup();
			}
		}
	}
	VSharedList3{
		id: listView
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		onListItemClicked: itemClicked(id,type);
		onListItemPressAndHold: showDelete(id)
		onSigBtnDeleteClicked: removeBlock(type,id)
	}
	VMMyPortalBlocksAvailableDlg{
		id: blocksAvailableDlg
		onSigAddClicked: addBlock(blockType)
	}
	Menu{
		id: menu
		MenuItem{
			text:enguia.tr("Management")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///MyPortal/VMMyPortalMng.qml"),immediate:true, destroyOnPop:true })
		}
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileMyPortal);
		}
	}
	function itemClicked(id, blockType){
		switch(blockType){
			case MSDefines.UserBlockTypeWelcome:
				mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockWelcome/VMUserBlockWelcomeEdit.qml"),immediate:true, destroyOnPop:true, properties:{blockID:id} })
				return;
			case MSDefines.UserBlockTypeMenu:
				mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockMenu/VMUserBlockMenuEdit.qml"),immediate:true, destroyOnPop:true, properties:{blockID:id} })
				return;
			case MSDefines.UserBlockTypePictures:
				mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockPictures/VMUserBlockPicturesEdit.qml"),immediate:true, destroyOnPop:true, properties:{blockID:id} })
				return;
			case MSDefines.UserBlockTypeProducts:
				mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsEdit.qml"),immediate:true, destroyOnPop:true, properties:{blockID:id} })
				return;
			case MSDefines.UserBlockTypeSchedule:
				mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleEdit.qml"),immediate:true, destroyOnPop:true, properties:{blockID:id} })
				return;
			case MSDefines.UserBlockTypeText:
				mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockText/VMUserBlockTextEdit.qml"),immediate:true, destroyOnPop:true, properties:{blockID:id} })
				return;
		}
	}
	function removeBlock(blockType,blockID){
		mSVC.metaInvoke(MSDefines.SUserBlocks,"RemoveBlock",function(ok){
			statusBar.displayResult(ok,enguia.tr("Block removed successfully"),enguia.tr("Unable to removed block"));
			if(ok)refresh();
		},mShared.userID, blockType, blockID);
	}
	function btnAddClicked(){
		if(listView.listModel.count>0)blocksAvailableDlg.setup(mShared.userID)
		else addBlock(MSDefines.UserBlockTypeWelcome)
	}
	function addBlock(blockType){
		mSVC.metaInvoke(MSDefines.SUserBlocks,"AddBlock",function(id){
			statusBar.displayResult(id,enguia.tr("Block added successfully"),enguia.tr("Unable to add block"));
			if(id>0)refresh();
		},mShared.userID,blockType);
	}
	function refresh(){
		listView.clear();
		var imgUrl="qrc:///Images/blocks.png"
		listView.loading=true;
		mSVC.metaInvoke(MSDefines.SUserBlocks,"GetUserBlocks",function(list){
			listView.loading=false;
			for(var i=0;i<list.length;i++){
				var eUserBlock=list[i];
				listView.append(eUserBlock.id,mSBlocks.getUserBlockTypeName(eUserBlock.blockType),imgUrl, eUserBlock.name,eUserBlock.blockType)
			}
		},mShared.userID);
	}
	Stack.onStatusChanged: {
		if(Stack.status!==Stack.Activating)return;
		refresh();
	}
}


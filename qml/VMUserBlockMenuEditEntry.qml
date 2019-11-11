import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockMenu"
import "qrc:/"

Rectangle {
	property int blockID:0
	property int id:0
	property var eUserMenu: enguia.createEntity("EUserMenu")
	color: enguia.backColor

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Menu")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolSave
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/save.png"
				onSigClicked: save();
			}
		}
	}
	ColumnLayout{
		anchors{top:pageTitle.bottom;left:parent.left;right:parent.right;}
		anchors.margins: enguia.smallMargin
		spacing: 0
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Title")
		}
		VMTextField{
			id:txtName
			maximumLength: 50
			Layout.fillWidth: true
		}
		Item{
			height: enguia.mediumMargin
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Subtitle")
		}
		VMTextField{
			id:txtSubtitle
			Layout.fillWidth: true
		}
		Item{
			height: enguia.mediumMargin
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Next block")
		}
		VMComboBox{
			id: comboNextBlock
			Layout.fillWidth: true
		}
		Item{
			height: enguia.mediumMargin
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Visibility")
		}
		VMButton{
			id: btnVisibility
			Layout.fillWidth: true
			onClicked: visibilityDlg.open();
		}
		Item{
			height: enguia.mediumMargin
		}
	}
	VMUserBlockVisibilityDlg{
		id: visibilityDlg
		onSigItemsSelected: {
			eUserMenu.visibility=0;
			for(var i=0;i<selectedList.length;i++){
				var item=selectedList[i];
				if(item.id === MSDefines.BlockVisibilityMyself)eUserMenu.visibility|=MSDefines.BlockVisibilityMyself;
				else if(item.id === MSDefines.BlockVisibilityBestFriends)eUserMenu.visibility|=MSDefines.BlockVisibilityBestFriends;
				else if(item.id === MSDefines.BlockVisibilityFamily)eUserMenu.visibility|=MSDefines.BlockVisibilityFamily;
				else if(item.id === MSDefines.BlockVisibilityFellowWorker)eUserMenu.visibility|=MSDefines.BlockVisibilityFellowWorker;
				else if(item.id === MSDefines.BlockVisibilityFriends)eUserMenu.visibility|=MSDefines.BlockVisibilityFriends;
				else if(item.id === MSDefines.BlockVisibilityOthers)eUserMenu.visibility|=MSDefines.BlockVisibilityOthers;
			}
			btnVisibility.text=mMobile.getVisibilityName(eUserMenu.visibility);
		}
	}
	function save(){
		Qt.inputMethod.commit();
		if(txtName.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		Qt.inputMethod.hide();
		eUserMenu.blockID=blockID;
		eUserMenu.id=id;
		eUserMenu.title=txtName.text;
		eUserMenu.subTitle=txtSubtitle.text
		eUserMenu.targetBlockType=comboNextBlock.getSelected();
		eUserMenu.targetBlockID=comboNextBlock.getSelectedValue();		
		mSVC.metaInvoke(MSDefines.SUserMenus,"SaveUserMenu",function(id){
			statusBar.displayResult(id, enguia.tr("Menu saved successfully"),enguia.tr("Unable to save menu"));
			mainWindow.popWithoutClear();
		},enguia.convertObjectToJson(eUserMenu));
	}
	function getEntry(id){
		mSVC.metaInvoke(MSDefines.SUserMenus,"GetUserMenu",function(e){
			enguia.copyValues(e,eUserMenu);
			txtName.text=eUserMenu.title;
			txtSubtitle.text=eUserMenu.subTitle;
			if(eUserMenu.targetBlockID>0)comboNextBlock.selectByTypeAndValue(eUserMenu.targetBlockType, eUserMenu.targetBlockID);
			btnVisibility.text=mMobile.getVisibilityName(eUserMenu.visibility);
		},id);
	}
	Component.onCompleted: {
		mSVC.metaInvoke(MSDefines.SUserBlocks,"GetUserBlocks",function(list){
			for(var i=0;i<list.length;i++){
				var eUserBlock=list[i];
				if(eUserBlock.blockType===MSDefines.UserBlockTypeWelcome)continue;
				if(eUserBlock.blockType===MSDefines.UserBlockTypeMenu && eUserBlock.id===blockID)continue;
				var name=mSBlocks.getUserBlockTypeName(eUserBlock.blockType);
				if(eUserBlock.name!==undefined && eUserBlock.name.length>0)name=eUserBlock.name;
				comboNextBlock.append(eUserBlock.blockType,name,eUserBlock.id);
			}
			if(id>0)getEntry(id)
		},mShared.userID);
	}
}


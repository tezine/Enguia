import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockMenu"

Rectangle {
	property int blockID:0

	VMPageTitle{
		id:pageTitle
		title: enguia.tr("Menu")
		btnBackVisible:true
		onSigBtnBackClicked:  mainWindow.popOneLevel();
		btnDoneVisible: false
	}
	VMBlockMenuList{
		id: menuList
		anchors{top:pageTitle.bottom;left:parent.left;right:parent.right;bottom:parent.bottom;}
		onListItemClicked:{
			var nextBlock=mSBlocks.getUrlFromPageType(targetBlockType);
			if(nextBlock.length<1)return;//no more blocks
			mainStack.push({item:Qt.resolvedUrl(nextBlock),destroyOnPop:true, immediate:true, properties:{blockID:targetBlockID} })
		}
	}
	Component.onCompleted: {
		menuList.loading=true;
		mSVC.metaInvoke(MSDefines.SPlaceMenus,"GetAll", function(list){
			menuList.loading=false;
			for(var i=0;i<list.length;i++){
				var ePlaceMenu=list[i];
				menuList.append(ePlaceMenu.id, ePlaceMenu.title, ePlaceMenu.subtitle, ePlaceMenu.targetBlockType, ePlaceMenu.targetBlockID)
			}
		},blockID)
	}
}


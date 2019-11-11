import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/UserBlockMenu"
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
			if(!mMobile.testVisibility(mMobile.currentUserVisibility,nextBlockVisibility)){console.debug("visibility not allowed:",mMobile.currentUserVisibility+":"+nextBlockVisibility); return;}
			var nextBlock=mSBlocks.getUrlFromUserBlockType(targetBlockType);
			if(nextBlock.length<1)return;//no more blocks
			mainStack.push({item:Qt.resolvedUrl(nextBlock),destroyOnPop:true, immediate:true, properties:{blockID:targetBlockID} })
		}
	}
	Component.onCompleted: {
		menuList.loading=true;
		mSVC.metaInvoke(MSDefines.SUserMenus,"GetUserMenus", function(list){
			menuList.loading=false;
			for(var i=0;i<list.length;i++){
				var eUserMenu=list[i];
				if(!mMobile.testVisibility(mMobile.currentUserVisibility,eUserMenu.visibility))continue;
				menuList.append(eUserMenu.id, eUserMenu.title, eUserMenu.subTitle, eUserMenu.targetBlockType, eUserMenu.targetBlockID,"", eUserMenu.nextBlockVisibility)
			}
		},blockID)
		mSVC.metaInvoke(MSDefines.SUserBlockMenu,"GetUserBlockMenuByID",function(e){
			if(e.name.length>0)pageTitle.title=e.name;
		},blockID);
	}
}


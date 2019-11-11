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
				id: toolMenu
				source: "qrc:///SharedImages/overflow.png"
				Layout.fillHeight: true
				Layout.preferredWidth: height
				onSigClicked: menu.popup();
			}
		}
	}
	VSharedList2{
		id:listView
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl(mMobile.getUrlFromMyPortalMngMenu(id)),destroyOnPop:true, immediate:true})
	}
	Menu{
		id: menu
		MenuItem{
			text: enguia.tr("Edit blocks")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///MyPortal/VMMyPortal.qml"),immediate:true, destroyOnPop:true })
		}
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileMyPortalMng);
		}
	}
	Component.onCompleted: {
		listView.append(MMobile.MyPortalMngClients,enguia.tr("My clients"),enguia.tr("Client management"))
		listView.loading=true;
		mSVC.metaInvoke(MSDefines.SUserBlocks,"GetUserBlocks",function(list){
			listView.loading=false;
			for(var i=0;i<list.length;i++){
				var eUserBlock=list[i];
				switch(eUserBlock.blockType){
					case MSDefines.UserBlockTypeSchedule:
						listView.append(MMobile.MyPortalMngAgenda,enguia.tr("My agenda"),enguia.tr("Manage appointments"))
						break;
					case MSDefines.UserBlockTypeProducts:
						listView.append(MMobile.MyPortalMngOrders,enguia.tr("My orders"),enguia.tr("Manage orders"))
						break;
				}
			}
		},mShared.userID);
	}
}


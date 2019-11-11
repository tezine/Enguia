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
		title: enguia.tr("Clients")
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
				onSigClicked: overFlowMenu.popup();
			}
		}
	}
	VSharedList2{
		id:listView
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Clients/VMClientsDetail.qml"),immediate:true, destroyOnPop:true, properties:{clientID:id} })
		onSigEndOfListReached: getClients();
	}
	Menu{
		id: overFlowMenu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileClients);
		}
	}
	function getClients(){
		listView.loading=true;
		mSVC.metaInvoke(MSDefines.SUserClients,"GetAllUserClients",function(list){
			listView.loading=false;
			if(list.length>=0)listView.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eUserClient=list[i];
				listView.append(eUserClient.id, eUserClient.name, eUserClient.mobilePhone)
			}
		},mShared.userID,enguia.listCount,listView.pageNumber);
	}
	Component.onCompleted: {
		getClients();
	}
}


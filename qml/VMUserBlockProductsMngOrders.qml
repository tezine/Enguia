import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockProducts"
import "qrc:/BlockProducts"
import "qrc:/"

Rectangle {
	id: topWindow

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("My orders")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolMenu
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///SharedImages/overflow.png"
				onSigClicked: overflowMenu.popup();
			}
		}
	}
	Menu{
		id: overflowMenu
//		MenuItem{
//			id: menuItemEditService
//			text: enguia.tr("Reports")
//			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockProducts/VMBlockProductsProReports.qml"),destroyOnPop:true,immediate:true})
//			visible: true
//		}
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileUserBlockProductsMng);
		}
	}
	VMBlockProductsProOrdersList{
		id: listMenu
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		onSigEndOfListReached: getOrders();
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsMngOrderDetail.qml"),destroyOnPop:true,immediate:true, properties:{orderID:id, visualID:visualID, orderClientID:clientID, orderType:orderType, orderStatus:status}})
	}
	function getOrders(){
		listMenu.loading=true;
		mSVC.metaInvoke(MSDefines.SUserOrders,"GetUserOrdersReceived",function(list){
			listMenu.loading=false;
			if(list.length>=0)listMenu.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eBaseOrder=list[i];
				listMenu.append(eBaseOrder);
			}
		},mShared.userID,enguia.listCount, listMenu.pageNumber);
	}
	Stack.onStatusChanged: {//required to refresh the list after pop. Also called on Component.onCompleted
		if(Stack.status!==Stack.Activating)return;
		listMenu.clear();
		getOrders();
	}
}


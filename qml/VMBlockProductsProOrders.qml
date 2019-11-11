import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"

Rectangle {
	id: topWindow	

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("My orders")
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			/*VMToolButton{
				id: toolAdd
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/add.png"
				onSigClicked: btnAddClicked();
				visible: false
			}*/
			VMToolButton{
				id: toolMenu
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///SharedImages/overflow.png"
				onSigClicked: overflowMenu.popup();
			}
		}
	}
	VMBlockProductsProOrdersList{
		id: listMenu
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockProducts/VMBlockProductsProOrderDetail.qml"),destroyOnPop:true,immediate:true, properties:{orderID:id, visualID:visualID, orderClientID:clientID, orderType:orderType, orderStatus:status}})
	}
	Menu{
		id: overflowMenu
		MenuItem{
			id: menuItemEditService
			text: enguia.tr("Reports")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockProducts/VMBlockProductsProReports.qml"),destroyOnPop:true,immediate:true})
			visible: true
		}
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileBlockProductsProOrders);
		}
	}
	MSTimer {
		id: timer
		onTriggered: getNewOrders()
	}
	function getNewOrders(){
		var lastDateInserted=listMenu.getLastOrderDateInserted();
		if(lastDateInserted===0){getOrders(mShared.placeID);return;}
		lastDateInserted=enguia.convertToUTCDateTimeString(lastDateInserted);
		console.debug("get new orders after dateInserted:",lastDateInserted,"hora atual:",Qt.formatTime(new Date(),Qt.ISODate))
		mSVC.metaInvoke(MSDefines.SPlaceOrders,"GetAllOrdersReceived",function(list){
			for(var i=0;i<list.length;i++){
				var eBaseOrder=list[i];
				listMenu.prepend(eBaseOrder);
			}
		},mShared.placeID,1000,0,lastDateInserted);
	}
	function getOrders(){
		listMenu.loading=true;
		mSVC.metaInvoke(MSDefines.SPlaceOrders,"GetAllOrdersReceived",function(list){
			listMenu.loading=false;
			if(list.length>=0)listMenu.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eBaseOrder=list[i];
				listMenu.append(eBaseOrder);
			}
		},mShared.placeID,enguia.listCount, listMenu.pageNumber);
	}
	Stack.onStatusChanged: {//required to refresh the list after pop. Also called on Component.onCompleted
		if(Stack.status!==Stack.Activating)return;
		listMenu.clear();
		getOrders();
		timer.startNoSingleShot(60000);//refreshes the list every 60 seconds
	}
}


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
import "qrc:/"

Rectangle {

	VSharedList2{
		id:listView
		anchors.fill: parent
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsEditEntry.qml"),immediate:true, destroyOnPop:true, properties:{productID:id} })
		onListItemPressAndHold: showDelete(id)
		onSigDeleteClicked: removeProduct(id)
	}
	function saveFields(){
		return true;
	}
	function removeProduct(id){
		mSVC.metaInvoke(MSDefines.SUserProducts,"DeleteUserProduct",function(ok){
			statusBar.displayResult(ok,enguia.tr("Product removed successfully"),enguia.tr("Unable to remove product"));
			if(ok)listView.remove(id);
		},id);
	}
	function getProducts(pageNumber){
		listView.loading=true;
		mSVC.metaInvoke(MSDefines.SUserProducts,"GetUserProducts",function(list){
			listView.loading=false;
			for(var i=0;i<list.length;i++){
				var eUserProduct=list[i];
				listView.append(eUserProduct.id, eUserProduct.name, eUserProduct.brief, "",0)
			}
		},mShared.userID,enguia.listCount,pageNumber)
	}
	function btnAddClicked(){
		mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsEditEntry.qml"),immediate:true, destroyOnPop:true, properties:{productID:0} })
	}
	function refresh(){
		listView.clear();
		getProducts(0);
	}
}


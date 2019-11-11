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

	ColumnLayout{
		id: grid
		anchors{left:parent.left;right:parent.right;top:parent.top;}
		anchors.margins: enguia.smallMargin
		spacing: 0
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Name")
		}
		VMTextField{
			id: txtName
			maximumLength: 50
			Layout.fillWidth: true
			text: eUserProduct.addOnName
		}
		Item{
			height: enguia.mediumMargin
		}
	}
	VSharedList2{
		id:listView
		anchors{left:parent.left;right:parent.right;top:grid.bottom;bottom:parent.bottom;}
		onListItemPressAndHold: showDelete(id);
		onSigDeleteClicked: removeOption(id)
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsEditEntryAddonsEdit.qml"),immediate:true, destroyOnPop:true, properties:{id:id,productID:eUserProduct.id} })
	}
	function removeOption(id){
		mSVC.metaInvoke(MSDefines.SUserProductsAddons,"RemoveUserAddon",function(ok){
			statusBar.displayResult(ok,enguia.tr("Addon removed successfully"),enguia.tr("Unable to remove addon"));
			if(ok)listView.remove(id)
		},id);
	}
	function saveFields(){
		eUserProduct.addOnName=txtName.text;
		return true;
	}
	function btnAddClicked(){
		mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsEditEntryAddonsEdit.qml"),immediate:true, destroyOnPop:true, properties:{id:0,productID:eUserProduct.id} })
	}
	function refresh(){
		listView.clear();
		listView.loading=true;
		mSVC.metaInvoke(MSDefines.SUserProductsAddons,"GetUserProductAddons",function(list){
			listView.loading=false;
			for(var i=0;i<list.length;i++){
				var ePlaceProductAddon=list[i];
				listView.append(ePlaceProductAddon.id, ePlaceProductAddon.name, ePlaceProductAddon.price.toString())
			}
		},productID);
	}
	Component.onCompleted: {
		refresh();
	}
}


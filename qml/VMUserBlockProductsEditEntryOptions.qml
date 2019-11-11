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
	property int level:0	

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
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsEditEntryOptionsEdit.qml"),immediate:true, destroyOnPop:true, properties:{id:id,level:level, productID:eUserProduct.id} })
	}	
	function removeOption(id){
		mSVC.metaInvoke(MSDefines.SUserProductsOptions,"RemoveUserOption",function(ok){
			statusBar.displayResult(ok,enguia.tr("Option removed successfully"),enguia.tr("Unable to remove option"));
			if(ok)listView.remove(id)
		},id);
	}
	function saveFields(){
		switch(level){
			case 1:
				eUserProduct.option1Name=txtName.text;
				break;
			case 2:
				eUserProduct.option2Name=txtName.text;
				break;
			case 3:
				eUserProduct.option3Name=txtName.text;
				break;
		}
		return true;
	}
	function btnAddClicked(){
		mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsEditEntryOptionsEdit.qml"),immediate:true, destroyOnPop:true, properties:{id:0,level:level, productID:eUserProduct.id} })
	}
	function refresh(){
		listView.clear();
		listView.loading=true;
		mSVC.metaInvoke(MSDefines.SUserProductsOptions,"GetUserProductOptions",function(list){
			listView.loading=false;
			for(var i=0;i<list.length;i++){
				var ePlaceProductOption=list[i];
				listView.append(ePlaceProductOption.id, ePlaceProductOption.name, ePlaceProductOption.price.toString())
			}
		},productID, level);
	}
	Component.onCompleted: {
		switch(level){
			case 1:
				txtName.text=eUserProduct.option1Name;
				break;
			case 2:
				txtName.text=eUserProduct.option2Name;
				break;
			case 3:
				txtName.text=eUserProduct.option3Name;
				break;
		}
		refresh();
	}
}


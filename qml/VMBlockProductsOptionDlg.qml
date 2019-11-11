import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"

Dialog {
	id: dlg
	visible:false
	modality: Qt.NonModal
	signal sigItemSelected(int id, string name, double price)

	contentItem: Rectangle {
		implicitWidth:enguia.width*0.8
		implicitHeight:enguia.height*0.4//se remover nao aparece no android
		VMBlockProductsOptionList{
			id: sharedList
			anchors.fill: parent
			onListItemClicked: {sigItemSelected(id,name,price);close();}
		}
	}
	function getProductOptions(level,productID){
		sharedList.clear();
		sharedList.loading=true;
		mSVC.metaInvoke(MSDefines.SPlaceProducts,"GetProductOptions",function(list){
			sharedList.loading=false;
			for(var i=0;i<list.length;i++){
				var ePlaceProductOption=list[i]
				sharedList.append(ePlaceProductOption.id, ePlaceProductOption.name, ePlaceProductOption.price)
			}
		},productID,level)
	}
	function getUserProductOptions(level,productID){
		sharedList.clear();
		sharedList.loading=true;
		mSVC.metaInvoke(MSDefines.SUserProductsOptions,"GetUserProductOptions",function(list){
			sharedList.loading=false;
			for(var i=0;i<list.length;i++){
				var eUserProductOption=list[i]
				sharedList.append(eUserProductOption.id, eUserProductOption.name, eUserProductOption.price)
			}
		},productID,level)
	}
	function setup(level, productID, isUserProduct){
		if(!isUserProduct)getProductOptions(level,productID);
		else getUserProductOptions(level,productID);
		open();
	}
}

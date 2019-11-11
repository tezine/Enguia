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
	signal sigItemsSelected(var selectedList)

	contentItem: Rectangle {
		implicitWidth:enguia.width*0.8
		implicitHeight:enguia.height*0.4
		VMBlockProductsAddonsList{
			id: sharedList
			anchors{top:parent.top;left:parent.left;right:parent.right;bottom:rectCancel.top;}
			onListItemClicked: {sigItemSelected(id,name,price);close();}
		}
		Rectangle{
			id: rectCancel
			border.color: "lightgray"
			border.width: 1
			anchors{left:parent.left;bottom:parent.bottom;}
			height: enguia.height*0.08
			width: (parent.width/2)
			Label{
				text:enguia.tr("Cancel")
				anchors.fill: parent
				font.pointSize: enguia.largeFontPointSize
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
			}
			MouseArea{
				anchors.fill: parent
				onClicked: close();
			}
		}
		Rectangle{
			id: rectAccept
			border.color: "lightgray"
			border.width: 1
			anchors{left:rectCancel.right;bottom:parent.bottom;}
			height: enguia.height*0.08
			width: (parent.width/2)
			Label{
				text:enguia.tr("Ok")
				anchors.fill: parent
				font.pointSize: enguia.largeFontPointSize
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
			}
			MouseArea{
				anchors.fill: parent
				onClicked: {
					var listModel=sharedList.listModel;
					var selectedList=[]
					for(var i=0;i<listModel.count;i++){
						if(listModel.get(i).itemSelected){
							var itemSelected={id:listModel.get(i).id, name:listModel.get(i).name, price:listModel.get(i).price};
							selectedList[selectedList.length]=itemSelected;
						}
					}
					sigItemsSelected(selectedList)
					close();
				}
			}
		}
	}
	function getProductAddons(productID){
		sharedList.clear();
		sharedList.loading=true;
		mSVC.metaInvoke(MSDefines.SPlaceProducts,"GetProductAddons",function(list){
			sharedList.loading=false;
			for(var i=0;i<list.length;i++){
				var ePlaceProductAddon=list[i];
				sharedList.append(ePlaceProductAddon.id, ePlaceProductAddon.name, ePlaceProductAddon.price)
			}
		},productID)
	}
	function getUserProductAddons(productID){
		sharedList.clear();
		sharedList.loading=true;
		mSVC.metaInvoke(MSDefines.SUserProductsAddons,"GetUserProductAddons",function(list){
			sharedList.loading=false;
			for(var i=0;i<list.length;i++){
				var eUserProductAddon=list[i];
				sharedList.append(eUserProductAddon.id, eUserProductAddon.name, eUserProductAddon.price)
			}
		},productID)
	}
	function setup(productID,isUserProduct){
		if(isUserProduct)getUserProductAddons(productID);
		else getProductAddons(productID);
		open();
	}
}

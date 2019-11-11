import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"

Rectangle {
	id: rect
	border.color: "lightgray"
	border.width: 1
	height: enguia.height*0.06
	property int productID:0
	property var selectedIDs:[]
	property double addOnsPrice:0
	property bool isUserProduct:false

	RowLayout{
		id:rowLayout
		anchors{left:parent.left;leftMargin: enguia.mediumMargin;right:parent.right;rightMargin: enguia.mediumMargin;verticalCenter: parent.verticalCenter}
		Label{
			id: lblAddOnName
			font{pointSize: enguia.hugeFontPointSize}
			color:"black"
			Layout.fillHeight: true
			Layout.alignment: Qt.AlignLeft
		}
		Label{
			id: lblSelected
			font{pointSize: enguia.largeFontPointSize}
			color:"gray"
			Layout.fillWidth: true
			horizontalAlignment: Text.AlignRight
			Layout.alignment: Qt.AlignRight
			elide:  Text.ElideRight
			visible: text.length>0
		}
	}
	VMBlockProductsAddonDlg{
		id: dlgAddons
		onSigItemsSelected: {
			lblSelected.text=""
			selectedIDs=[];//to clear the array
			addOnsPrice=0;
			for(var i=0;i<selectedList.length;i++){
				selectedIDs[i]=selectedList[i].id
				addOnsPrice+=selectedList[i].price;
				if(i===selectedList.length-1)lblSelected.text+=selectedList[i].name;
				else lblSelected.text+=selectedList[i].name+","
			}
		}
	}
	MouseArea{
		anchors.fill: parent
		onClicked: dlgAddons.setup(productID,isUserProduct)
	}
	function getSelectedAddonsNames(){
		return lblAddOnName.text+" "+lblSelected.text
	}
	function setup(addOnName, productID,isUserProduct){
		rect.productID=productID;
		lblAddOnName.text=addOnName;
		rect.isUserProduct=isUserProduct;
	}
}


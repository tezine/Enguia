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
	property int level:0
	property int productID:0
	property int selectedID:0
	property double selectedPrice:0
	property bool isUserProduct:false
	signal sigSelected()

	RowLayout{
		id:rowLayout
		anchors{left:parent.left;leftMargin: enguia.mediumMargin;right:parent.right;rightMargin: enguia.mediumMargin;verticalCenter: parent.verticalCenter}
		Label{
			id: lblOptionName
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
			visible: text.length>0
		}
	}
	VMBlockProductsOptionDlg{
		id: dlgOptions
		onSigItemSelected: {
			if(price>0)lblSelected.text=name+" ("+price.toString()+")"
			else lblSelected.text=name;
			selectedPrice=price;
			selectedID=id;
			sigSelected()
		}
	}
	MouseArea{
		anchors.fill: parent
		onClicked: dlgOptions.setup(level, productID,isUserProduct)
	}
	function getSelectedOption(){
		return lblOptionName.text+" "+lblSelected.text
	}
	function setup(level, optionName, productID,isUserProduct){
		lblOptionName.text=optionName
		rect.level=level;
		rect.productID=productID;
		rect.isUserProduct=isUserProduct;
	}
}


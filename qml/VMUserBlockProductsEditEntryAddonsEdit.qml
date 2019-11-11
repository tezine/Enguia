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
	color: enguia.backColor
	property int id:0
	property int productID:0
	property var eUserProductAddon:enguia.createEntity("EUserProductAddon")

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Addon")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolSave
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/save.png"
				onSigClicked: save();
			}
		}
	}
	ColumnLayout{
		anchors{top:pageTitle.bottom;left:parent.left;right:parent.right;}
		anchors.margins: enguia.smallMargin
		spacing: 0
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Name")
		}
		VMTextField{
			id:txtName
			maximumLength: 45
			Layout.fillWidth: true
		}
		Item{
			height: enguia.mediumMargin
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Price")
		}
		VMTextField{
			id: txtPrice
			inputMethodHints: Qt.ImhFormattedNumbersOnly
			Layout.fillWidth: true
		}
		Item{
			height: enguia.mediumMargin
		}
	}
	function save(){
		Qt.inputMethod.commit();
		if(txtName.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		var price=0;
		if(txtPrice.text.length>0){
			price=parseFloat(txtPrice.text);
			if(isNaN(price)|| price<0){statusBar.displayError(enguia.tr("Invalid price"));return false;}
		}
		Qt.inputMethod.hide();
		eUserProductAddon.name=txtName.text;
		eUserProductAddon.price=price;
		eUserProductAddon.productID=productID;
		mSVC.metaInvoke(MSDefines.SUserProductsAddons,"SaveUserAddon",function(id){
			statusBar.displayResult(id,enguia.tr("Addon saved successfully"),enguia.tr("Unable to save addon"));
			mainWindow.popWithoutClear();
		},enguia.convertObjectToJson(eUserProductAddon));
	}
	Component.onCompleted: {
		if(id<1)return;
		mSVC.metaInvoke(MSDefines.SUserProductsAddons,"GetUserAddon",function(e){
			txtName.text=e.name;
			enguia.copyValues(e,eUserProductAddon)
			if(e.price>0)txtPrice.text=e.price.toString();
		},id);
	}
}


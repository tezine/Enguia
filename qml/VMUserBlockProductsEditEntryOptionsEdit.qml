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
	property int level:0
	property int productID:0
	property var eUserProductOption: enguia.createEntity("EUserProductOption")

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Option")
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
		eUserProductOption.level=level;
		eUserProductOption.name=txtName.text;
		eUserProductOption.price=price;
		eUserProductOption.productID=productID;
		mSVC.metaInvoke(MSDefines.SUserProductsOptions,"SaveUserOption",function(id){
			statusBar.displayResult(id,enguia.tr("Option saved successfully"),enguia.tr("Unable to save option"));
			mainWindow.popWithoutClear();
		},enguia.convertObjectToJson(eUserProductOption));
	}
	Component.onCompleted: {
		if(id<1)return;
		mSVC.metaInvoke(MSDefines.SUserProductsOptions,"GetUserOption",function(e){
			enguia.copyValues(e,eUserProductOption);
			txtName.text=e.name;
			if(e.price>0)txtPrice.text=e.price.toString();
		},id);
	}
}


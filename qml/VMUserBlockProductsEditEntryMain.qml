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
	property string completeLocalPicturePath: ""

	Flickable {
		id: flickable
		clip: true
		width: parent.width;
		height: parent.height
		contentWidth: parent.width
		contentHeight: grid.height+enguia.height*0.02+enguia.mediumMargin
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
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Brief")
			}
			VMTextField{
				id: txtBrief
				maximumLength: 100
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
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Category")
			}
			VMComboBox{
				id: comboCategory
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Image")
			}
			VMPictureSelect{
				id: pictureSelect
				Layout.fillWidth: true
				Layout.preferredHeight: enguia.height*0.3
				onSigBtnFileSelected: {
					imgURL=enguia.convertFileToURL(completeLocalPath);
					completeLocalPicturePath=completeLocalPath;
				}
			}
			Item{
				height: enguia.mediumMargin
			}
		}
	}
	VMListEmptyRect{
		id: loadingRect
		anchors{left:parent.left;right:parent.right;top:parent.top;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	function saveFields(){
		var price=0;
		if(txtPrice.text.length>0){
			price=parseFloat(txtPrice.text);
			if(isNaN(price)|| price<0){statusBar.displayError(enguia.tr("Invalid price"));return false;}
		}
		eUserProduct.name=txtName.text
		eUserProduct.brief=txtBrief.text
		eUserProduct.userID=mShared.userID;
		eUserProduct.price=price
		eUserProduct.categoryID=comboCategory.getSelected();
		eUserProduct.categoryName=comboCategory.getSelectedName();
		return true;
	}
	function getProduct(){
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserProducts,"GetUserProductByID",function(e){
			loadingRect.visible=false;
			enguia.copyValues(e,eUserProduct);
			pageTitle.title=e.name;
			txtName.text=e.name;
			txtBrief.text=e.brief;
			txtPrice.text=e.price;
			comboCategory.select(e.categoryID)
		},productID)
	}
	function getCategories(){
		comboCategory.clear();
		comboCategory.append(0,"")
		mSVC.metaInvoke(MSDefines.SUserProductsCategories, "GetAllUserCategories",function(list){
			for(var i=0;i<list.length;i++){
				var ePlaceProductCategory=list[i];
				comboCategory.append(ePlaceProductCategory.id, ePlaceProductCategory.name);
			}
			if(list.length>0) comboCategory.select(eUserProduct.categoryID)//we have to add it here too
		},mShared.userID);
	}
	Component.onCompleted: {
		getCategories();
		getProduct();
	}
}


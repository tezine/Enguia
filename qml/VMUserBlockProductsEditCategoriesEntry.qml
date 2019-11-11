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
	property int categoryID:0
	property string categoryName:""
	property var eUserProductCategory: enguia.createEntity("EUserProductCategory");

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Category")
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
			text:categoryName
		}
		Item{
			height: enguia.mediumMargin
		}
	}
	function save(){
		Qt.inputMethod.commit();
		if(txtName.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		Qt.inputMethod.hide();
		eUserProductCategory.id=categoryID;
		eUserProductCategory.name=txtName.text;
		eUserProductCategory.userID=mShared.userID;
		mSVC.metaInvoke(MSDefines.SUserProductsCategories,"SaveUserCategory",function(id){
			statusBar.displayResult(id, enguia.tr("Category saved successfully"),enguia.tr("Unable to save category"));
			mainWindow.popWithoutClear();
		},enguia.convertObjectToJson(eUserProductCategory));
	}
}


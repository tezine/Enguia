import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockPictures"
import "qrc:/"

Rectangle {
	id:top
	property int blockID:0
	property int id:0
	property var eUserPicture: enguia.createEntity("EUserPicture")
	color: enguia.backColor
	property string completeLocalPath:""

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Picture")
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
			text:enguia.tr("Title")
		}
		VMTextField{
			id:txtName
			maximumLength: 50
			Layout.fillWidth: true
		}
		Item{
			height: enguia.mediumMargin
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Description")
		}
		VMTextField{
			id:txtDescription
			Layout.fillWidth: true
		}
		Item{
			height: enguia.mediumMargin
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("File")
		}
		VMPictureSelect{
			id: pictureSelect
			Layout.fillWidth: true
			Layout.preferredHeight: enguia.height*0.3
			onSigBtnFileSelected: {
				imgURL=enguia.convertFileToURL(completeLocalPath);
				top.completeLocalPath=completeLocalPath;
			}
		}
		Item{
			height: enguia.mediumMargin
		}
	}
	function save(){
		Qt.inputMethod.commit();
		if(txtName.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		if(completeLocalPath.length<3){statusBar.displayError(enguia.tr("Invalid file"));return;}
		Qt.inputMethod.hide();
		eUserPicture.id=id;
		eUserPicture.blockID=blockID;
		eUserPicture.userID=mShared.userID;
		eUserPicture.name=txtName.text;
		eUserPicture.description=txtDescription.text;
		mSVC.metaInvoke(MSDefines.SUserPictures,"SaveUserPicture",function(id){
			statusBar.displayResult(id, enguia.tr("Picture saved successfully"),enguia.tr("Unable to save picture"));
			mainWindow.popWithoutClear();
		},enguia.convertObjectToJson(eUserPicture),mSFiles.getPictureBase64(completeLocalPath));
	}
	Component.onCompleted: {
		if(id===0)return;
		mSVC.metaInvoke(MSDefines.SUserPictures,"GetUserPicture",function(e){
			enguia.copyValues(e,eUserPicture);
			txtName.text=eUserPicture.name;
			txtDescription.text=eUserPicture.description;
			pictureSelect.imgURL=mSFiles.getUserPictureUrl(mShared.userID,blockID,id);
		},id);
	}
}

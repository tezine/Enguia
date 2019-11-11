import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockWelcome"
import "qrc:/"

Rectangle {

	ColumnLayout{
		id:columnLayout
		spacing: 0
		anchors{left:parent.left;right:parent.right;top:parent.top;bottom:parent.bottom}
		VMPictureSelect{
			id: pictureSelect
			Layout.fillWidth: true
			Layout.preferredHeight: enguia.height*0.3
			onSigBtnFileSelected: sendPicture(completeLocalPath)
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Brief")
		}
		VMTextField{
			id: txtBrief
			maximumLength: 50
			Layout.fillWidth: true
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Description")
		}
		TextArea{
			id: textArea
			font{pointSize: enguia.largeFontPointSize}
			Layout.fillWidth: true
			Layout.fillHeight: true
		}
	}
	Menu{
		id: menu
		MenuItem{
			id: menuTakePicture
			text: enguia.tr("Take a picture")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///Tourism/VMTourismEditTakePicture.qml"),destroyOnPop:true,immediate:true})
			visible: enguia.isAndroid()||enguia.isIOS()
		}
		MenuItem{
			id: menuGallery
			text: enguia.tr("Set picture")
			onTriggered: dlgFiles.setup("*.jpg",true);
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
		eUserBlockWelcome.brief=txtBrief.text;
		eUserBlockWelcome.description=textArea.text;
		return true;
	}
	function sendPicture(localPath){
		mSVC.metaInvoke(MSDefines.SUserBlockWelcome,"SavePicture",function(ok){
			statusBar.displayResult(ok,enguia.tr("Picture saved successfully"),enguia.tr("Unable to save picture"));
			if(ok)pictureSelect.imgURL=mSFiles.getUserBannerUrl(mShared.userID);
		},mShared.userID, blockID, mSFiles.getPictureBase64(localPath));
	}
	Component.onCompleted:{
		pictureSelect.imgURL=mSFiles.getUserBannerUrl(mShared.userID);
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserBlockWelcome,"GetUserBlockWelcomeByID",function(e){
			loadingRect.visible=false;
			enguia.copyValues(e, eUserBlockWelcome);
			txtBrief.text=eUserBlockWelcome.brief;
			textArea.text=eUserBlockWelcome.description;
		},blockID);
	}
}


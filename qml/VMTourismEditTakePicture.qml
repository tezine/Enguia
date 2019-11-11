import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import QtMultimedia 5.4
import com.tezine.enguia 1.0
import "qrc:/Events"
import "qrc:/Components"
import "qrc:/Contacts"
import "qrc:/Favorites"
import "qrc:/Messages"
import "qrc:/News"
import "qrc:/Preferences"
import "qrc:/Qualifications"
import "qrc:/Search"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/Tourism"

Rectangle {
	property string picturePath:""

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Camera")
		titleLayout.anchors.right: pageTitle.right
		btnBackVisible: true
		btnDoneVisible: false
		onSigBtnBackClicked: mainWindow.popOneLevel();
		onDone: save();
	}
	Camera {
		id: camera
		imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
		exposure {
			exposureCompensation: -1.0
			exposureMode: Camera.ExposureAuto
		}
		flash.mode: Camera.FlashRedEyeReduction
		imageCapture {
			onImageCaptured: {
				photoPreview.source = preview  // Show the preview in an Image
			}
			onImageSaved: {
				console.debug("image saved into:",path)
				picturePath=path;
				pageTitle.btnDoneVisible=true;
			}
		}
	}
	VideoOutput {
		source: camera
		autoOrientation: true
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		focus : visible // to receive focus and capture key events when visible
	}
	Image {
		id: photoPreview
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:btnTakePicture.top;}
	}
	VSharedButton{
		id: btnTakePicture
		text:enguia.tr("Take picture")
		anchors{left:parent.left;right:parent.right;bottom:parent.bottom;}
		anchors.margins: enguia.mediumMargin;
		onClicked: {
			camera.imageCapture.capture();
		}
	}
	function save(){
		mMobile.emitPictureChanged(picturePath);
		mainWindow.popWithoutClear();
	}
}


import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
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

Rectangle {

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Notifications")
		titleLayout.anchors.right: btnDone.left
		btnDoneVisible: true
		onDone: save()
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
	}
	ColumnLayout{
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;}
		anchors.margins: enguia.mediumMargin
		spacing: enguia.smallMargin
		CheckBox{
			id: checkMessages
			style: checkStyleAndroid
			text: enguia.tr("Messages")
		}
		CheckBox{
			id: checkQualifications
			style: checkStyleAndroid
			text:enguia.tr("Qualifications")
		}
		CheckBox{
			id: checkOrderStatus
			style: checkStyleAndroid
			text: enguia.tr("Order status changes")
		}
		CheckBox{
			id: checkAppointmentStatus
			style: checkStyleAndroid
			text: enguia.tr("Appointment status changes")
		}
		CheckBox{
			id: checkNews
			style: checkStyleAndroid
			text: enguia.tr("News")
		}
	}
	function save(){
		var pushTypes=0;
		if(checkMessages.checked)pushTypes|=MSDefines.PushTypeMessage;
		if(checkQualifications.checked)pushTypes|=MSDefines.PushTypeQualification;
		if(checkOrderStatus.checked)pushTypes|=MSDefines.PushTypeOrderStatusChanged;
		if(checkAppointmentStatus.checked)pushTypes|=MSDefines.PushTypeAppointmentStatusChanged;
		if(checkNews.checked)pushTypes|=MSDefines.PushTypeNews;
		mSVC.metaInvoke(MSDefines.SUsers, "SavePushTypes",function(ok){
			statusBar.displayResult(ok,enguia.tr("Notifications saved successfully"),enguia.tr("Unable to save notifications"));
			mainWindow.popWithoutClear();
		},mShared.userID,pushTypes);
	}
	Component.onCompleted: {
		mSVC.metaInvoke(MSDefines.SUsers,"GetAllFieldsByID",function(eUser){
			if(eUser.pushTypes & MSDefines.PushTypeMessage)checkMessages.checked=true;
			if(eUser.pushTypes & MSDefines.PushTypeQualification)checkQualifications.checked=true;
			if(eUser.pushTypes & MSDefines.PushTypeOrderStatusChanged)checkOrderStatus.checked=true;
			if(eUser.pushTypes & MSDefines.PushTypeAppointmentStatusChanged)checkAppointmentStatus.checked=true;
			if(eUser.pushTypes & MSDefines.PushTypeNews)checkNews.checked=true;
		},mShared.userID);
	}
}


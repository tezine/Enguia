import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockSchedule"

Rectangle {
	id:top
	property var eAgenda:enguia.createEntity("EAgenda")
	property int scheduleID:0
	color: enguia.backColor

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Rejection message")
		btnDoneVisible: true
		subtitle: Qt.formatDate(selectedDate, Qt.SystemLocaleShortDate)
		onDone: save();
	}
	VSharedLabelRect{
		id: lblTitle
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;}
		horizontalAlignment: Text.AlignHCenter
		text: enguia.tr("Type the rejection message below")
	}
	TextArea{
		id: txtArea
		font{pointSize: enguia.largeFontPointSize;}
		anchors{left:parent.left;right:parent.right;top:lblTitle.bottom;bottom:parent.bottom;}
		anchors.margins: enguia.mediumMargin
	}
	function save(){
		Qt.inputMethod.commit();
		if(txtArea.text.length<3){statusBar.displayError(enguia.tr("Invalid text"));return;}
		var title=enguia.tr("Appointment")+" "+eAgenda.visualID.toString()+" " + enguia.tr("was rejected");
		var content=enguia.tr("Service name")+": "+eAgenda.serviceName+".\n"+enguia.tr("Professional")+": "+eAgenda.professionalName+".\n"
				+enguia.tr("Date/time")+": "+Qt.formatDate(enguia.convertToDateOnly(eAgenda.dt),Qt.SystemLocaleShortDate)+" "+enguia.convertToTimeString(eAgenda.tm);
		mSVC.metaInvoke(MSDefines.SPlaceSchedules,"RejectAppointment",function(ok){
			if(ok===false){statusBar.displayError(enguia.tr("Unable to change status"));return;}
			statusBar.displaySuccess(enguia.tr("Status changed successfully"));
			mainWindow.popWithoutClear();
		},eAgenda.id,eAgenda.placeID,eAgenda.userID,title, txtArea.text,content);
	}
	Component.onCompleted: {
		mSVC.metaInvoke(MSDefines.SPlaceSchedules,"GetByID",function(eAgenda){
			enguia.copyValues(eAgenda,top.eAgenda);
		},scheduleID);
	}
}


import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockSchedule"
import "qrc:/BlockSchedule"
import "qrc:/"

Rectangle {
	id:topWindow
	color: enguia.backColor
	property var eConfirmation:enguia.createEntity("EUserScheduleConfirmation");
	property date dt:new Date();
	property string tm:""
	property int serviceID:0
	property bool confirmed:false
	property string labelColor:"#484B4E"

	VSharedPageTitle{
		id:pageTitle
		title:enguia.tr("Confirmation")
		subtitle: enguia.tr("Please confirm the appointment below")
		btnBackVisible:true
		onSigBtnBackClicked: {
			if(confirmed)mainWindow.popToMenu();
			else mainWindow.popOneLevel();
		}
	}
	ColumnLayout{
		id: columnLayout
		anchors{top: pageTitle.bottom;topMargin: enguia.mediumMargin;leftMargin: enguia.mediumMargin;rightMargin: enguia.mediumMargin;right: parent.right;left: parent.left}
		VSharedLabel{
			id: lblProfessionalName
			Layout.fillWidth: true;
			font{pointSize: enguia.hugeFontPointSize;bold:true}
			wrapMode: Text.Wrap
			color: labelColor
		}
		VSharedLabel{
			id: lblProfessionalAddress
			Layout.fillWidth: true;
			wrapMode: Text.Wrap
			color: labelColor
		}
		VSharedLabel{
			id: lblServiceName
			Layout.fillWidth: true;
			wrapMode: Text.Wrap
			color: labelColor
		}
		VSharedLabel{
			id: lblServicePrice
			Layout.fillWidth: true;
			wrapMode: Text.Wrap
			color: labelColor
		}
		VSharedLabel{
			id: lblDt
			Layout.fillWidth: true;
			wrapMode: Text.Wrap
			color: labelColor
		}
		VSharedLabel{
			id: lblTm
			Layout.fillWidth: true;
			wrapMode: Text.Wrap
			color: labelColor
		}
		Label{
			id:lbl
			font{pointSize: enguia.mediumFontPointSize;bold:true;}
			text:enguia.tr("Warning: If you confirm the appointment, the professional will receive your Enguia profile (name, address, phone...).")
			Layout.fillWidth: true
			color: labelColor
			wrapMode: Text.Wrap
		}
		VSharedButton{
			id: btn
			text:enguia.tr("Confirm")
			Layout.fillWidth: true
			onClicked: confirmAppointment();
		}
	}
	VMListEmptyRect{
		id: emptyRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	Keys.onPressed:  {//call forceActiveFocus on completed
		if(event.key!==Qt.Key_Back)return;
		if(topWindow.confirmed){
			event.accepted = true;
			mainWindow.popToMenu();
		}
	}
	function confirmAppointment(){
		mSVC.metaInvoke(MSDefines.SUserSchedules,"ConfirmAppointment",function(ok){
			topWindow.confirmed=true;
			btn.visible=false;
			statusBar.displayResult(ok,enguia.tr("Appointment confirmed"),enguia.tr("Unable to confirm"));
		},mShared.userID, eConfirmation)
	}
	Component.onCompleted: {
		topWindow.forceActiveFocus();
		emptyRect.visible=true
		mSVC.metaInvoke(MSDefines.SUserSchedules,"GetUserAppointmentConfirmation",function(eScheduleConfirmation){
			emptyRect.visible=false;
			enguia.copyValues(eScheduleConfirmation, eConfirmation)
			lblProfessionalName.text=enguia.tr("Professional")+": "+eScheduleConfirmation.professionalUserName;
			lblProfessionalAddress.text=enguia.tr("Address")+": "+ eScheduleConfirmation.professionalAddress;
			lblServiceName.text=enguia.tr("Service")+": "+eScheduleConfirmation.serviceName;
			if(eScheduleConfirmation.servicePrice===0)lblServicePrice.visible=false;
			else lblServicePrice.text=enguia.tr("Price")+":"+mSOrder.getCurrencySymbolFromType(eScheduleConfirmation.currencyType)+eScheduleConfirmation.servicePrice
			lblDt.text=enguia.tr("Date")+": "+ Qt.formatDate(eScheduleConfirmation.dt, Qt.SystemLocaleLongDate);
			lblTm.text=enguia.tr("Time")+": "+ Qt.formatTime(eScheduleConfirmation.tm,"HH:mm")
		},mShared.otherUserID,serviceID,enguia.convertToDateISOString(dt),tm);
	}
}


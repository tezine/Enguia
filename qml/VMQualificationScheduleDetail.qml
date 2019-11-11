import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
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
	property int agendaID:0
	property int visualID:0
	property string placeName:""
	property alias comment:lblComment.text
	color: enguia.backColor
	property string fontColor:  "#484B4E"

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Schedule")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
	}
	ColumnLayout{
		id: columnLayout
		anchors{top: pageTitle.bottom;topMargin: enguia.mediumMargin;leftMargin: enguia.mediumMargin;rightMargin: enguia.mediumMargin;right: parent.right;left: parent.left}
		VSharedLabel{
			id: lblPlaceName
			font{pointSize: enguia.hugeFontPointSize;bold:true;}
			Layout.fillWidth: true;
			color: fontColor
			text:placeName
		}
		VSharedLabel{
			id: lblComment
			Layout.fillWidth: true;
			wrapMode: Text.Wrap
			color: "#484B4E"
		}
		VSharedLabel{
			id: lblScheduleID
			Layout.fillWidth: true;
			text: enguia.tr("Appointment")+ ": "+visualID
			color: fontColor
		}
		VSharedLabel{
			id: lblPlaceAddress
			Layout.fillWidth: true;
			wrapMode: Text.Wrap
			color: fontColor
		}
		VSharedLabel{
			id: lblPlacePhone
			Layout.fillWidth: true;
			wrapMode: Text.Wrap
			color: fontColor
		}
		VSharedLabel{
			id: lblProfessionalName
			Layout.fillWidth: true;
			wrapMode: Text.Wrap
			color: fontColor
		}
		VSharedLabel{
			id: lblServiceName
			Layout.fillWidth: true;
			wrapMode: Text.Wrap
			color: fontColor
		}
		VSharedLabel{
			id: lblServicePrice
			Layout.fillWidth: true;
			visible: false
			color: fontColor
		}
		VSharedLabel{
			id: lblDt
			Layout.fillWidth: true;
			color: fontColor
		}
		VSharedLabel{
			id: lblTm
			Layout.fillWidth: true;
			color: fontColor
		}
	}
	VMListEmptyRect{
		id: emptyRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	Component.onCompleted: {
		emptyRect.visible=true;
		mSVC.metaInvoke(MSDefines.SPlaceSchedules, "GetAppointmentDetail", function(eScheduleConfirmation){
			emptyRect.visible=false;
			lblPlaceAddress.text=enguia.tr("Address")+": "+ eScheduleConfirmation.placeAddress;
			lblPlacePhone.text=enguia.tr("Phone")+": "+eScheduleConfirmation.placePhone
			lblProfessionalName.text=enguia.tr("Professional")+": "+eScheduleConfirmation.professionalName;
			lblServiceName.text=enguia.tr("Service")+": "+ eScheduleConfirmation.serviceName;
			if(eScheduleConfirmation.servicePrice>0){lblServicePrice.text=enguia.tr("Price")+": "+ eScheduleConfirmation.servicePrice;lblServicePrice.visible=true;}
			lblDt.text=enguia.tr("Date")+": "+ Qt.formatDate(enguia.convertToDateOnly(eScheduleConfirmation.dt),Qt.SystemLocaleShortDate);
			lblTm.text=enguia.tr("Time")+": "+Qt.formatTime(eScheduleConfirmation.tm,Qt.SystemLocaleShortDate);
		},agendaID);
	}
}


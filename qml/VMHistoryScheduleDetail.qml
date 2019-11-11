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
import "qrc:/History"

Rectangle {
    property int scheduleID:0
	property int visualID:0
    property int placeID:0
    property string name:""
    property string fontColor:"#484B4E"
	color: enguia.backColor

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Schedule")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
    }
	VSharedLabelRect{
		id: rectStatus
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;}
		horizontalAlignment: Text.AlignHCenter
	}
    Rectangle{
        id: rect
		anchors{top:rectStatus.bottom; left:parent.left;right:parent.right;}
        height: columnLayout.height+2*enguia.mediumMargin
		color:"transparent"
        ColumnLayout{
            id: columnLayout
            anchors{verticalCenter: parent.verticalCenter;leftMargin: enguia.mediumMargin;rightMargin: enguia.mediumMargin;right: parent.right; left: parent.left}
            VSharedLabel{
                id: lblPlaceName
				font{pointSize: enguia.hugeFontPointSize; bold: true}
                Layout.fillWidth: true;
                color: fontColor
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
                color: fontColor
                wrapMode: Text.Wrap
            }
			VSharedLabel{
				id: lblPlacePhone
				Layout.fillWidth: true;
				color: fontColor
				wrapMode: Text.Wrap
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
    }
	VMButton{
		id: btnCancel
		text:enguia.tr("Cancel appointment")
		anchors{left:parent.left;right:parent.right;bottom:parent.bottom;}
		visible: false
		onClicked: cancelAppointment();
	}
	VMListEmptyRect{
		id: emptyRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	function cancelAppointment(){
		mSVC.metaInvoke(MSDefines.SPlaceSchedules,"ChangeStatus",function(ok){
			statusBar.displayResult(ok,enguia.tr("Appointment cancelled successfully"), enguia.tr("Unable to cancel appointment"));
			mainWindow.popWithoutClear();
		},scheduleID,MSDefines.AppointmentStatusCanceledByClient);
	}
    Component.onCompleted: {
		emptyRect.visible=true;
		mSVC.metaInvoke(MSDefines.SPlaceSchedules, "GetAppointmentDetail", function(eScheduleConfirmation){
			emptyRect.visible=false;
            lblPlaceName.text= eScheduleConfirmation.placeName;
            lblPlaceAddress.text=enguia.tr("Address")+": "+ eScheduleConfirmation.placeAddress;
			lblPlacePhone.text=enguia.tr("Phone")+": "+ eScheduleConfirmation.placePhone;
			lblProfessionalName.text=enguia.tr("Professional")+": "+eScheduleConfirmation.professionalName;
            lblServiceName.text=enguia.tr("Service")+": "+ eScheduleConfirmation.serviceName;			
            if(eScheduleConfirmation.servicePrice>0){lblServicePrice.text=enguia.tr("Price")+": "+ eScheduleConfirmation.servicePrice;lblServicePrice.visible=true;}
			lblDt.text=enguia.tr("Date")+": "+ Qt.formatDate(enguia.convertToDateOnly(eScheduleConfirmation.dt),Qt.SystemLocaleShortDate);
			lblTm.text=enguia.tr("Time")+": "+Qt.formatTime(eScheduleConfirmation.tm,"HH:mm");
			rectStatus.text=mSAgenda.getAppointmentStatusName(eScheduleConfirmation.status)
			rectStatus.color=mSAgenda.getAppointmentStatusColor(eScheduleConfirmation.status);
			var hoursAvailable=enguia.getAvailableHoursUntilAppointment(eScheduleConfirmation.dt, eScheduleConfirmation.tm)
			if(eScheduleConfirmation.clientsMayCancel){
				if(eScheduleConfirmation.status===MSDefines.AppointmentStatusCanceledByClient || eScheduleConfirmation.status===MSDefines.AppointmentStatusRejectedByPlace)return;
				if(hoursAvailable===-1)return;
				if(eScheduleConfirmation.minimumCancelTime<1){btnCancel.visible=true;return;}
				if(hoursAvailable>=eScheduleConfirmation.minimumCancelTime){btnCancel.visible=true;return;}
			}
        },scheduleID);
    }
}


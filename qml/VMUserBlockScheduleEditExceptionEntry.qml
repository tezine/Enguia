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
	color:enguia.backColor
	property int exceptionID:0
	property var eUserServiceException: enguia.createEntity("EUserServiceException")

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Service")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolBarRowLayout.left
		z:10
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
	Flickable {
		id: flickable
		clip: true
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		contentWidth: parent.width
		contentHeight: grid.height+enguia.height*0.02+enguia.mediumMargin
		ColumnLayout{
			id: grid
			anchors{left:parent.left;right:parent.right;top:parent.top;}
			anchors.margins: enguia.mediumMargin
			spacing: 0
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Date")
			}
			VMButton{
				id: btnDt
				Layout.fillWidth: true
				onClicked: dlgDate.launchDate(btnDt.dt,1)
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Status")
			}
			VMComboBox{
				id:comboStatus
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
		}
	}
	Rectangle {
		id: scrollbar
		anchors.right: flickable.right
		y: flickable.visibleArea.yPosition * flickable.height
		width: enguia.scrollWidth
		height: flickable.visibleArea.heightRatio * flickable.height
		color: "#BDBDBD"
	}
	VMDlgDate{
		id: dlgDate
		onSigDateSelected: btnDt.fillDate(dt)
	}
	function save(){
		Qt.inputMethod.commit();
		eUserServiceException.professionalUserID=mShared.userID;
		eUserServiceException.exceptionDate=btnDt.dt;
		eUserServiceException.id=exceptionID;
		eUserServiceException.status=comboStatus.getSelected();
		Qt.inputMethod.hide();
		mSVC.metaInvoke(MSDefines.SUserServicesExceptions,"SaveUserException",function(id){
			statusBar.displayResult(id,enguia.tr("Exception saved successfully"),enguia.tr("Unable to save exception"));
			if(id>0)mainWindow.popWithoutClear();
		},enguia.convertObjectToJson(eUserServiceException));
	}
	Component.onCompleted: {
		btnDt.fillDate(enguia.convertToDateOnly(btnDt.dt)	);
		comboStatus.append(MSDefines.ScheduleStatusClosed,enguia.tr("Closed"));
		comboStatus.append(MSDefines.ScheduleStatusOpen,enguia.tr("Open"));
		comboStatus.append(MSDefines.ScheduleStatusGetInTouch,enguia.tr("Get in touch"));
		if(exceptionID<1)return;
		mSVC.metaInvoke(MSDefines.SUserServicesExceptions,"GetUserExceptionByID",function(e){
			btnDt.fillDate(e.exceptionDate);
			comboStatus.select(e.status);
		},exceptionID);
	}
}


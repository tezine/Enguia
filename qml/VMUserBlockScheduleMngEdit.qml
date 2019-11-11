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
	id:top
	property var eUserSchedule:enguia.createEntity("EUserSchedule")
	property int scheduleID:0
	property int serviceID:0
	property date selectedDate:new Date()
	property int selectedUserID:0
	property int selectedClientID:0
	property alias selectedClientName: txtName.text
	color: enguia.backColor

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Appointment")
		btnDoneVisible: false
		subtitle: Qt.formatDate(selectedDate, Qt.SystemLocaleShortDate)
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
				visible: true
			}
			VMToolButton{
				id: toolMenu
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///SharedImages/overflow.png"
				onSigClicked: overflowMenu.popup();
			}
		}
	}
	ColumnLayout{
		id: grid
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		anchors.margins: enguia.largeMargin;
		spacing: 0
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Service")
		}
		VMComboBox{
			id: comboService
			Layout.fillWidth: true
			onCurrentIndexChanged: getAvailableTime(comboService.getSelected(),selectedDate)
		}
		Item{
			height: enguia.mediumMargin
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Time")
		}
		VMComboBox{
			id: comboTime
			Layout.fillWidth: true
		}
		Item{
			height: enguia.mediumMargin
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Client")
		}
		RowLayout{
			Layout.fillWidth: true
			Layout.preferredHeight: comboTime.height
			spacing: 0
			VMTextField{
				id: txtName
				maximumLength: 50
				Layout.fillWidth: true
				placeholderText: enguia.tr("Client name, login, email or phone")
			}
			VMImageButton{
				id: btnSearch
				color: enguia.buttonNormalColor
				width: txtName.height
				height: txtName.height
				Layout.preferredWidth: txtName.height
				Layout.maximumHeight: txtName.height
				source:"qrc:///SharedImages/search.png"
				onSigBtnClicked: searchClient();
				visible: scheduleID===0;
			}
		}
		Item{
			height: enguia.mediumMargin
		}
		VSharedLabelRectCompact{
			id: rectMsgToSend
			Layout.fillWidth: true
			text:enguia.tr("Message to send to client")
			visible: txtMsg.visible
		}
		TextArea{
			id:txtMsg
			Layout.fillWidth: true
			Layout.fillHeight: true
			font{pointSize: enguia.largeFontPointSize;}
			visible:  (!clientList.visible)&& selectedUserID!==0
		}
		VMBlockScheduleClientList{
			id: clientList
			Layout.fillWidth: true
			Layout.fillHeight: true
			visible: false
			onListItemClicked: {
				selectedUserID=userID;
				selectedClientID=clientID;
				txtName.text=name;
				clientList.visible=false;
				txtName.readOnly=true;
			}
		}
		Label{
			id: spacingLabel
			Layout.fillWidth: true
			Layout.fillHeight: true
			visible: (!txtMsg.visible)&&(!clientList.visible)&&(!rectMsgToSend.visible)
		}
	}
	VMListEmptyRect{
		id: loadingRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	Menu{
		id: overflowMenu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileUserBlockScheduleMngEdit);
		}
	}
	function save(){
		Qt.inputMethod.commit();
		if(comboService.getSelected()===0){statusBar.displayError(enguia.tr("Invalid service"));return;}
		if(comboTime.getSelectedName().length<1){statusBar.displayError(enguia.tr("Invalid time"));return;}
		if(txtName.text.length<2){statusBar.displayError(enguia.tr("Invalid client"));return;}
		if(selectedUserID>0 && txtMsg.text.length<3){statusBar.displayError(enguia.tr("Invalid message"));return;}
		Qt.inputMethod.hide();
		eUserSchedule.clientID=selectedClientID
		eUserSchedule.clientUserName=txtName.text;
		if(txtName.readOnly)eUserSchedule.clientUserID=selectedUserID;
		else eUserSchedule.userID=MSDefines.SpecialUserUnknown;
		eUserSchedule.serviceID=comboService.getSelected();
		eUserSchedule.professionalUserID=mShared.userID;
		eUserSchedule.professionalUserName=mShared.userName;
		eUserSchedule.comment=txtMsg.text;
		eUserSchedule.dt=selectedDate;
		eUserSchedule.tm=comboTime.getSelectedName();
		var completeDateTime=Qt.formatDate(enguia.convertToDateOnly(selectedDate),Qt.SystemLocaleShortDate)+" "+comboTime.getSelectedName();
		var title="";
		var content=""
		if(scheduleID===0){//new appointment
			eUserSchedule.id=0;
			eUserSchedule.visualID=0;
			eUserSchedule.isNew=true;
			title=enguia.tr("A new appointment was created for you")
			content=enguia.tr("Service name")+": "+comboService.getSelectedName()+".\n"+enguia.tr("Professional")+": "+mShared.userName+".\n"+enguia.tr("Date/time")+": "+completeDateTime;
		}else {//appointment edited
			eUserSchedule.isNew=false;
			title=enguia.tr("Appointment changed")
			content=enguia.tr("Service name")+": "+comboService.getSelectedName()+".\n"+enguia.tr("Professional")+": "+mShared.userName+".\n"+enguia.tr("Date/time")+": "+completeDateTime;
		}
		mSVC.metaInvoke(MSDefines.SUserSchedules,"SaveAppointmentFromProfessional",function(id){
			statusBar.displayResult(id,enguia.tr("Appointment saved successfully"),enguia.tr("Unable to save the appointment"))
			if(id>0)mainWindow.popWithoutClear();
		},eUserSchedule,title,content);
	}
	function searchClient(){
		Qt.inputMethod.commit();
		selectedClientID=selectedUserID= 0	;
		if(txtName.readOnly){txtName.readOnly=false;txtName.text="";txtName.forceActiveFocus(); return;}
		clientList.clear();
		if(txtName.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		Qt.inputMethod.hide();
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserClients,"Search",function(list){
			loadingRect.visible=false;
			if(list.length>0){clientList.visible=true;}
			else statusBar.displayError(enguia.tr("Client not found"));
			for(var i=0;i<list.length;i++){
				var eUserClient=list[i];
				clientList.appendEUserClient(eUserClient);
			}
		},mShared.userID, txtName.text);
	}
	function getAvailableTime(serviceID, dt){
		comboTime.clear();
		loadingRect.visible=true;
		mSAgenda.getAvailableUserServiceTime(mShared.userID,serviceID, dt, function(list){
			loadingRect.visible=false
			comboTime.clear();//manter esse aqui  tambem senao dá problema na edicao
			for(var i=0;i<list.length;i++){
				var tm=list[i];
				comboTime.append(0,Qt.formatTime(tm,"HH:mm"))
			}
		});
	}
	function getServices(){
		loadingRect.visible=true;
		comboService.clear();
		mSVC.metaInvoke(MSDefines.SUserServices,"GetUserServices",function(list){
			loadingRect.visible=false;
			for(var i=0;i<list.length;i++){
				var eUserService=list[i];
				comboService.append(eUserService.id, eUserService.name,"")
			}
			if(list.length>0){
				if(scheduleID>0)comboService.select(eUserSchedule.serviceID)//in case of edit a schedule
				else if(serviceID>0)comboService.select(serviceID)//when called from pro waiting queue
				getAvailableTime(list[0].id,selectedDate)
			}
		},mShared.userID);
	}
	Component.onCompleted: {
		if(scheduleID>0){//edit appointment
			txtName.readOnly=true;
			mSVC.metaInvoke(MSDefines.SUserSchedules,"GetByID",function(eUserSchedule){
				enguia.copyValues(eUserSchedule,top.eUserSchedule);
				selectedClientID=eUserSchedule.clientID
				selectedUserID=eUserSchedule.clientUserID
				txtName.text=eUserSchedule.clientUserName
				getServices();
			},scheduleID);
		}else{//new appointment
			if(selectedUserID>0){//called from waiting queue
				txtName.readOnly=true;
				mSVC.metaInvoke(MSDefines.SUserClients,"GetUserClientByUserID",function(e){
					selectedClientID=e.id;
					getServices()
				},mShared.userID,selectedUserID);
			}else getServices();
		}
	}
}


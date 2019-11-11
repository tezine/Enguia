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
	property int professionalID:0
	property int serviceID:0
	property string professionalName:""
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
		id: emptyRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	Menu{
		id: overflowMenu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileBlockScheduleProAgendaEdit);
		}
	}
	function save(){
		Qt.inputMethod.commit();
		Qt.inputMethod.hide();
		if(comboService.getSelected()===0){statusBar.displayError(enguia.tr("Invalid service"));return;}
		if(comboTime.getSelectedName().length<1){statusBar.displayError(enguia.tr("Invalid time"));return;}
		if(txtName.text.length<2){statusBar.displayError(enguia.tr("Invalid client"));return;}
		if(selectedUserID>0 && txtMsg.text.length<3){statusBar.displayError(enguia.tr("Invalid message"));return;}
		eAgenda.clientID=selectedClientID
		eAgenda.userName=txtName.text;
		if(txtName.readOnly)eAgenda.userID=selectedUserID;
		else eAgenda.userID=MSDefines.SpecialUserUnknown;
		eAgenda.serviceID=comboService.getSelected();
		eAgenda.professionalID=professionalID;
		eAgenda.professionalName=professionalName;
		eAgenda.comment=txtMsg.text;
		eAgenda.placeID=mShared.placeID;
		eAgenda.dt=selectedDate;
		eAgenda.tm=comboTime.getSelectedName();
		var completeDateTime=Qt.formatDate(enguia.convertToDateOnly(selectedDate),Qt.SystemLocaleShortDate)+" "+comboTime.getSelectedName();
		var title="";
		var content=""
		if(scheduleID===0){//new appointment
			eAgenda.id=0;
			eAgenda.visualID=0;
			eAgenda.isNew=true;
			title=enguia.tr("A new appointment was created for you")
			content=enguia.tr("Service name")+": "+comboService.getSelectedName()+".\n"+enguia.tr("Professional")+": "+professionalName+".\n"+enguia.tr("Date/time")+": "+completeDateTime;
		}else {//appointment edited
			eAgenda.isNew=false;
			title=enguia.tr("Appointment changed")
			content=enguia.tr("Service name")+": "+comboService.getSelectedName()+".\n"+enguia.tr("Professional")+": "+professionalName+".\n"+enguia.tr("Date/time")+": "+completeDateTime;
		}
		mSVC.metaInvoke(MSDefines.SPlaceSchedules,"SaveAppointmentFromStudio",function(id){
			statusBar.displayResult(id,enguia.tr("Appointment saved successfully"),enguia.tr("Unable to save the appointment"))
			if(id>0)mainWindow.popWithoutClear();
		},eAgenda,title,content);
	}
	function searchClient(){
		Qt.inputMethod.commit();
		Qt.inputMethod.hide();
		selectedClientID=selectedUserID= 0	;
		if(txtName.readOnly){txtName.readOnly=false;txtName.text="";txtName.forceActiveFocus(); return;}
		clientList.clear();
		if(txtName.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		mSVC.metaInvoke(MSDefines.SPlaceClients,"Search",function(list){
			if(list.length>0){clientList.visible=true;}
			else statusBar.displayError(enguia.tr("Client not found"));
			for(var i=0;i<list.length;i++){
				var ePlaceClient=list[i];
				clientList.append(ePlaceClient);
			}
		},mShared.placeID, txtName.text);
	}
	function getAvailableTime(serviceID, dt){
		comboTime.clear();
		emptyRect.visible=true;
		mSAgenda.getAvailableTime(mShared.placeID,serviceID, dt, function(list){
			emptyRect.visible=false
			comboTime.clear();//manter esse aqui  tambem senao dá problema na edicao
			for(var i=0;i<list.length;i++){
				var tm=list[i];
				comboTime.append(0,Qt.formatTime(tm,"HH:mm"))
			}
		});
	}
	function getServices(professionalID){
		emptyRect.visible=true;
		comboService.clear();
		mSVC.metaInvoke(MSDefines.SPlaceServices,"GetServicesByProfessional",function(list){
			emptyRect.visible=false;
			for(var i=0;i<list.length;i++){
				var ePlaceService=list[i];
				comboService.append(ePlaceService.id, ePlaceService.name,"")
			}
			if(list.length>0){
				if(scheduleID>0)comboService.select(eAgenda.serviceID)//in case of edit a schedule
				else if(serviceID>0)comboService.select(serviceID)//when called from pro waiting queue
				getAvailableTime(list[0].id,selectedDate)
			}
		},mShared.placeID,professionalID);
	}	
	Component.onCompleted: {
		if(scheduleID>0){//edit appointment
			txtName.readOnly=true;
			mSVC.metaInvoke(MSDefines.SPlaceSchedules,"GetByID",function(eAgenda){
				enguia.copyValues(eAgenda,top.eAgenda);
				selectedClientID=eAgenda.clientID
				selectedUserID=eAgenda.userID
				console.debug("editando:",eAgenda.serviceName)
				txtName.text=eAgenda.userName
				getServices(professionalID);
			},scheduleID);
		}else{//new appointment
			getServices(professionalID)
			if(selectedClientID>0 && selectedClientName.length>0){//called from pro waiting queue
				txtName.readOnly=true;
			}
		}
	}
}


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
	property var eProfessional: enguia.createEntity("EScheduleProfessional")
	property date currentDate:new Date();
	property date today:new Date();//don't change this
	property int selectedAgendaID:0
	property int selectedStatus:0
	property int selectedUserID:0

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("My Agenda")
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolAdd
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/add.png"
				onSigClicked: btnAddClicked();
				visible: false
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
	VMCalendarToolBar{
		id: calendarToolBar
		height: enguia.height*0.07
		minimumYear: today.getFullYear();
		displayMonthOnly: true
		anchors{left:parent.left; right:parent.right;top:pageTitle.bottom}
		onSigYearChanged: {
			var dt=top.currentDate;
			dt.setFullYear(year);
			setCurrentDate(dt);
			refreshMonth(dt)
		}
		onSigNextClicked: {
			setCurrentDate(enguia.addMonths(currentDate,1));
			refreshMonth(currentDate)
		}
		onSigPreviousClicked: {
			var previous=enguia.addMonths(currentDate,-1);
			if(previous <enguia.getFirstDayOnMonth(today))return;
			setCurrentDate(previous);
			refreshMonth(currentDate)
		}
	}
	Calendar{
		id:calendar
		navigationBarVisible:false
		anchors{left:parent.left;right:parent.right;top:calendarToolBar.bottom;bottom:listView.top}
		style: calendarStyle
		onSelectedDateChanged: {
			var status=mSAgenda.getStatus(selectedDate);
			if(status===MSDefines.ScheduleStatusUnknown){//probably user clicked on the next month
				console.debug("unknown clicked:",currentDate);
				setCurrentDate(currentDate)
				return;
			}
			calendarClicked(selectedDate)
		}
	}
	VMBlockScheduleCalendarStylePro{
		id: calendarStyle
	}
	VMBlockScheduleProTimeList{
		id: listView
		anchors{left:parent.left;right:parent.right;bottom:parent.bottom;}
		height: parent.height*0.4
		onListItemPressAndHold: {
			selectedAgendaID=id;
			selectedStatus=status;
			selectedUserID=userID;
			if(selectedUserID===0)menuItemCandSendMsg.visible=false;
			else if(top.eProfessional.canSendMsgToClients)menuItemCandSendMsg.visible=true;
			if(eProfessional.canChangeStatus)contextMenu.popup();
		}
	}
	VMListEmptyRect{
		id: emptyRect
		anchors{left:parent.left;right:parent.right;top:calendarToolBar.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:15
	}
	VMListEmptyRect{
		id: emptyRectBottom
		anchors{left:parent.left;right:parent.right;top:calendar.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	Menu {
		id: contextMenu
		MenuItem{
			text: enguia.tr("Accept")
			visible: selectedStatus===MSDefines.AppointmentStatusPending
			onTriggered: acceptAppointment()
		}
		MenuItem {
			text: enguia.tr("Reject")
			onTriggered: btnRejectClicked();
			visible: top.selectedStatus==MSDefines.AppointmentStatusPending
		}
		MenuItem {
			text: enguia.tr("Finalized")
			onTriggered: changeAppointmentStatus(selectedAgendaID,MSDefines.AppointmentStatusFinalized);
			visible: top.selectedStatus===MSDefines.AppointmentStatusAccepted|| top.selectedStatus===MSDefines.AppointmentStatusPending
		}
		MenuItem {
			text: enguia.tr("Edit")
			visible: top.selectedStatus===MSDefines.AppointmentStatusPending || top.selectedStatus===MSDefines.AppointmentStatusAccepted
			onTriggered: editAppointmentClicked();
		}
		MenuItem {
			text: enguia.tr("Cancel")
			onTriggered: changeAppointmentStatus(selectedAgendaID,MSDefines.AppointmentStatusCanceledByPlace)
			visible: top.selectedStatus==MSDefines.AppointmentStatusPending || top.selectedStatus==MSDefines.AppointmentStatusAccepted
		}
		MenuItem {
			id: menuItemCandSendMsg
			text: enguia.tr("Send message to client...")
			visible: false
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///Messages/VMMessagesEdit.qml"),destroyOnPop:true,properties:{toUserID:selectedUserID}})
		}
	}
	Menu{
		id: overflowMenu
		MenuItem{
			id: menuItemEditService
			text: enguia.tr("Edit services")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProServices.qml"),destroyOnPop:true,immediate:true, properties:{professionalID:eProfessional.id}})
			visible: false
		}
		MenuItem{
			id:menuItemEditTimetable
			text: enguia.tr("Edit timetable")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProTimetable.qml"),destroyOnPop:true,immediate:true, properties:{professionalID:eProfessional.id}})
			visible: false
		}
		MenuItem{
			id:menuItemQueue
			text: enguia.tr("Waiting queue")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProQueue.qml"),destroyOnPop:true,immediate:true, properties:{professionalID:eProfessional.id,professionalName:eProfessional.name, canSendMsgToClients:top.eProfessional.canSendMsgToClients}})
		}
		MenuItem{
			id:menuItemReports
			text: enguia.tr("Reports")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProReports.qml"),destroyOnPop:true,immediate:true, properties:{professionalID:eProfessional.id}})
			visible: false
		}
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileBlockScheduleProAgenda);
		}
	}
	function btnRejectClicked(){
		mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProReject.qml"),destroyOnPop:true,immediate:true, properties:{scheduleID:selectedAgendaID}})
	}
	function editAppointmentClicked(){
		if(eProfessional.id<1){statusBar.displayError(enguia.tr("Professional id not set"));return;}
		mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProAgendaEdit.qml"),destroyOnPop:true,immediate:true, properties:{scheduleID:selectedAgendaID, professionalID:eProfessional.id, professionalName:eProfessional.name, selectedDate:top.currentDate}})
	}
	function btnAddClicked(){
		if(eProfessional.id<1){statusBar.displayError(enguia.tr("Professional id not set"));return;}
		mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProAgendaEdit.qml"),destroyOnPop:true,immediate:true, properties:{scheduleID:0, professionalID:eProfessional.id, professionalName:eProfessional.name, selectedDate:top.currentDate}})
	}
	function changeAppointmentStatus(agendaID,status){
		if(top.selectedStatus===MSDefines.AppointmentStatusRejectedByPlace){statusBar.displayError(enguia.tr("It's not allowed to change a rejected status"));return;}
		mSVC.metaInvoke(MSDefines.SPlaceSchedules,"ChangeStatus",function(ok){
			if(ok===false){statusBar.displayError(enguia.tr("Unable to change status"));return;}
			statusBar.displaySuccess(enguia.tr("Status changed successfully"));
			calendarClicked(top.currentDate)
		},agendaID,status);
	}
	function acceptAppointment(){
		var eAgenda=listView.getByID(selectedAgendaID)
		var title=enguia.tr("Appointment")+" "+eAgenda.visualID.toString()+" "+enguia.tr("was accepted");
		var content=enguia.tr("Service name")+": "+eAgenda.serviceName+".\n"+enguia.tr("Professional")+": "+eAgenda.professionalName+".\n"
				+enguia.tr("Date/time")+": "+Qt.formatDate(enguia.convertToDateOnly(eAgenda.dt),Qt.SystemLocaleShortDate)+" "+enguia.convertToTimeString(eAgenda.tm);
		mSVC.metaInvoke(MSDefines.SPlaceSchedules,"AcceptAppointment",function(ok){
			if(ok===false){statusBar.displayError(enguia.tr("Unable to change status"));return;}
			statusBar.displaySuccess(enguia.tr("Status changed successfully"));
			calendarClicked(top.currentDate)
		},eAgenda.id,mShared.placeID,eAgenda.userID,title,content);
	}
	function calendarClicked(dt){
		listView.clear();
		setCurrentDate(dt)
		emptyRectBottom.visible=true;
		mSVC.metaInvoke(MSDefines.SPlaceSchedules,"GetProfessionalAppointmentsOnDay",function(list){
			emptyRectBottom.visible=false;
			for(var i=0;i<list.length;i++){
				var eAgenda=list[i];
				listView.append(eAgenda);
			}
		},mShared.placeID,mShared.userID,enguia.convertToDateISOString(dt),true);
	}
	function setCurrentDate(dt){
		selectedAgendaID=selectedStatus=0;
		top.currentDate=dt;
		console.debug("set date:",top.currentDate)
		calendar.selectedDate=dt;
		calendarToolBar.setDate(dt);
	}
	function refreshMonth(dt){
		console.debug("refresh pro month:",dt)
		listView.clear();
		emptyRect.visible=true;
		mainIndicator.visible=true;
		mSAgenda.getAgendaStatusOnMonthForProfessional(mShared.placeID,mShared.userID,currentDate,function(list){
			emptyRect.visible=false;
			mainIndicator.visible=false;
			calendar.style=null;
			calendar.style=calendarStyle
		});
	}
	function getProfessionalID(){
		mSVC.metaInvoke(MSDefines.SPlaceScheduleProfessionals, "GetByUserID",function(eScheduleProfessional){
			if(eScheduleProfessional===null || eScheduleProfessional.id<1){statusBar.displayError(enguia.tr("Unable to retrieve info"));return;}
			enguia.copyValues(eScheduleProfessional,top.eProfessional)
			if(eScheduleProfessional.canEditAppointment)toolAdd.visible=true;
			if(eScheduleProfessional.canEditService)menuItemEditService.visible=true;
			if(eScheduleProfessional.canEditTimetable)menuItemEditTimetable.visible=true;
			if(eScheduleProfessional.canGenerateReports)menuItemReports.visible=true;
			if(eScheduleProfessional.canSendMsgToClients)menuItemCandSendMsg.visible=true;
		},mShared.placeID, mShared.userID);
	}
	Stack.onStatusChanged: {//required to refresh the list after pop. Also called on Component.onCompleted
		if(Stack.status===Stack.Activating){
			setCurrentDate(top.currentDate)
			refreshMonth(top.currentDate);
			calendarClicked(top.currentDate);
			getProfessionalID();
		}
	}
}


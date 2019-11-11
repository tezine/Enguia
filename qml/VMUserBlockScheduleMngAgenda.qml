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
	property date currentDate:new Date();
	property date today:new Date();//don't change this
	property int selectedUserScheduleID:0
	property int selectedStatus:0
	property int selectedClientUserID:0

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("My Agenda")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
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
	VMUserBlockScheduleTimeList{
		id: listView
		anchors{left:parent.left;right:parent.right;bottom:parent.bottom;}
		height: parent.height*0.4
		onListItemPressAndHold: {
			selectedUserScheduleID=id;
			selectedStatus=status;
			selectedClientUserID=clientUserID
			contextMenu.popup();
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
			onTriggered: changeAppointmentStatus(selectedUserScheduleID,MSDefines.AppointmentStatusFinalized);
			visible: top.selectedStatus===MSDefines.AppointmentStatusAccepted|| top.selectedStatus===MSDefines.AppointmentStatusPending
		}
//		MenuItem {
//			text: enguia.tr("Edit")
//			visible: top.selectedStatus===MSDefines.AppointmentStatusPending || top.selectedStatus===MSDefines.AppointmentStatusAccepted
//			onTriggered: editAppointmentClicked();
//		}
		MenuItem {
			text: enguia.tr("Cancel")
			onTriggered: changeAppointmentStatus(selectedUserScheduleID,MSDefines.AppointmentStatusCanceledByPlace)
			visible: top.selectedStatus==MSDefines.AppointmentStatusPending || top.selectedStatus==MSDefines.AppointmentStatusAccepted
		}
		MenuItem {
			id: menuItemCandSendMsg
			text: enguia.tr("Send message to client...")
			visible: true
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///Messages/VMMessagesEdit.qml"),destroyOnPop:true,properties:{toUserID:selectedClientUserID}})
		}
	}
	Menu{
		id: overflowMenu
		MenuItem{
			id:menuItemQueue
			text: enguia.tr("Waiting queue")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleMngQueue.qml"),destroyOnPop:true,immediate:true})
		}
		MenuItem{
			id:menuItemReports
			text: enguia.tr("Reports")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleMngReport.qml"),destroyOnPop:true,immediate:true})
		}
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileUserBlockScheduleMngAgenda);
		}
	}
	function btnRejectClicked(){
		mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleMngReject.qml"),destroyOnPop:true,immediate:true, properties:{scheduleID:selectedUserScheduleID}})
	}
	function editAppointmentClicked(){
		mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProAgendaEdit.qml"),destroyOnPop:true,immediate:true, properties:{scheduleID:selectedUserScheduleID, professionalID:eProfessional.id, professionalName:eProfessional.name, selectedDate:top.currentDate}})
	}
	function btnAddClicked(){
		mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleMngEdit.qml"),destroyOnPop:true,immediate:true, properties:{scheduleID:0, selectedDate:top.currentDate}})
	}
	function changeAppointmentStatus(scheduleID,status){
		if(top.selectedStatus===MSDefines.AppointmentStatusRejectedByPlace){statusBar.displayError(enguia.tr("It's not allowed to change a rejected status"));return;}
		mSVC.metaInvoke(MSDefines.SUserSchedules,"ChangeStatus",function(ok){
			if(ok===false){statusBar.displayError(enguia.tr("Unable to change status"));return;}
			statusBar.displaySuccess(enguia.tr("Status changed successfully"));
			calendarClicked(top.currentDate)
		},scheduleID,status);
	}
	function acceptAppointment(){
		var eUserSchedule=listView.getByID(selectedUserScheduleID)
		var title=enguia.tr("Appointment")+" "+eUserSchedule.visualID.toString()+" "+enguia.tr("was accepted");
		var content=enguia.tr("Service name")+": "+eUserSchedule.serviceName+".\n"+enguia.tr("Professional")+": "+eUserSchedule.professionalUserName+".\n"
				+enguia.tr("Date/time")+": "+Qt.formatDate(enguia.convertToDateOnly(eUserSchedule.dt),Qt.SystemLocaleShortDate)+" "+enguia.convertToTimeString(eUserSchedule.tm);
		mSVC.metaInvoke(MSDefines.SUserSchedules,"AcceptAppointment",function(ok){
			if(ok===false){statusBar.displayError(enguia.tr("Unable to change status"));return;}
			statusBar.displaySuccess(enguia.tr("Status changed successfully"));
			calendarClicked(top.currentDate)
		},eUserSchedule.id,mShared.userID,eUserSchedule.clientUserID,title,content);
	}
	function calendarClicked(dt){
		listView.clear();
		setCurrentDate(dt)
		emptyRectBottom.visible=true;
		mSVC.metaInvoke(MSDefines.SUserSchedules,"GetUserAppointmentsOnDay",function(list){
			emptyRectBottom.visible=false;
			for(var i=0;i<list.length;i++){
				var eUserSchedule=list[i];
				listView.append(eUserSchedule);
			}
		},mShared.userID,enguia.convertToDateISOString(dt),true);
	}
	function setCurrentDate(dt){
		selectedUserScheduleID=selectedStatus=0;
		top.currentDate=dt;
		console.debug("set date:",top.currentDate)
		calendar.selectedDate=dt;
		calendarToolBar.setDate(dt);
	}
	function refreshMonth(dt){
		console.debug("refresh user agenda month:",dt)
		listView.clear();
		emptyRect.visible=true;
		mainIndicator.visible=true;
		mSAgenda.getAgendaStatusOnMonthForUser(mShared.userID,currentDate,function(list){
			emptyRect.visible=false;
			mainIndicator.visible=false;
			calendar.style=null;
			calendar.style=calendarStyle
		});
	}
	Stack.onStatusChanged: {//required to refresh the list after pop. Also called on Component.onCompleted
		if(Stack.status===Stack.Activating){
			setCurrentDate(top.currentDate)
			refreshMonth(top.currentDate);
			calendarClicked(top.currentDate);
		}
	}
}


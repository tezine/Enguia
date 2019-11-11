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
	id: top
	property int serviceID:0
	property date currentDate:new Date();
	property date today:new Date();//don't change this
	property bool isLoading:false

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Date selection")
		subtitle: enguia.tr("Select the date/time below")
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
			if(status===MSDefines.ScheduleStatusUnknown || isLoading){//probably user clicked on the next month. isLoading is used to block user from moving fingers
				setCurrentDate(currentDate)
				return;
			}
			calendarClicked(selectedDate)
		}
	}
	VMBlockScheduleCalendarStyle2{
		id: calendarStyle
	}
	VMBlockScheduleTimeList{
		id: listView
		anchors{left:parent.left;right:parent.right;bottom:parent.bottom;}
		height: parent.height*0.4
		onListItemClicked: {
			if(status===MSDefines.ScheduleMaxReached){
				mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleDateQueue.qml"),destroyOnPop:true, immediate:true, properties:{dt:calendar.selectedDate, serviceID:serviceID}})
				return;
			}
			if(!enguia.isValidTime(name))return ;//closed, contact, ...
			mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleConfirmation.qml"),destroyOnPop:true, immediate:true, properties:{dt:calendar.selectedDate, tm:name, serviceID:serviceID}})
		}
	}
	VMListEmptyRect{
		id: emptyRect
		anchors{left:parent.left;right:parent.right;top:calendarToolBar.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	function calendarClicked(dt){
		listView.clear();
		var status=mSAgenda.getStatus(dt);
		switch(status){
			case MSDefines.ScheduleStatusNotAvailable:
				listView.append(enguia.tr("Not available"),status);
				return;
			case MSDefines.ScheduleStatusClosed:
				listView.append(enguia.tr("Closed"),status);
				return;
			case MSDefines.ScheduleStatusGetInTouch:
				listView.append(enguia.tr("Information not available. Please get in touch"),status)
				return;
			case MSDefines.ScheduleMaxReached:
				listView.append(enguia.tr("No more time available"),status)
				return;
		}
		setCurrentDate(dt)
		var clickedToday=false;
		if(Qt.formatDate(dt,Qt.ISODate)===Qt.formatDate(today,Qt.ISODate))clickedToday=true;
		mainIndicator.visible=true;
		isLoading=true;
		var list= mSAgenda.getAvailableUserServiceTime(mShared.userID, serviceID, dt, function(list){
			isLoading=false;
			mainIndicator.visible=false;
			if(list.length===0){listView.append(enguia.tr("No more time available. Enter waiting queue..."),MSDefines.ScheduleMaxReached);return;}
			for(var i=0;i<list.length;i++){
				var tm=list[i];
				if(clickedToday && (enguia.compareTimes(tm,enguia.getCurrentTime())===MSDefines.SmallerThan))continue;
				listView.append(Qt.formatTime(tm,"HH:mm"),MSDefines.ScheduleStatusOpen)
			}
		});
	}
	function setCurrentDate(dt){
		top.currentDate=dt;
		console.debug("set date:",top.currentDate)
		calendar.selectedDate=dt;
		calendarToolBar.setDate(dt);
	}
	function refreshMonth(dt){
		console.debug("refresh month:",dt)
		listView.clear();
		emptyRect.visible=true;
		mainIndicator.visible=true;
		mSAgenda.getAgendaStatusOnMonthForUser(mShared.otherUserID, dt,function(ok){
			emptyRect.visible=false;
			mainIndicator.visible=false;
			calendar.style=null;
			calendar.style=calendarStyle
		});
	}
	Component.onCompleted: {
		setCurrentDate(top.currentDate)
		refreshMonth(top.currentDate);
		calendarClicked(top.currentDate);
	}
}


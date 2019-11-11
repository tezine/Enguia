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
	property int selectedWeekday:0
	property int sameAs:0
	property var eUserServiceTimetableStatus:enguia.createEntity("EUserServiceTimetableStatus")

	VMBlockScheduleProWeekdaysList{
		id: listView
		anchors.fill: parent
		onListItemPressAndHold: {
			selectedWeekday=id;
			sameAs=0
			contextMenu.popup();
		}
		onListItemClicked: {
			mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleEditTimetableInDay.qml"),destroyOnPop:true,immediate:true, properties:{weekDay:id, weekDayName:name }})
		}
	}
	Menu {
		id: contextMenu
		MenuItem{
			text: enguia.tr("Open")
			onTriggered: save(MSDefines.ScheduleStatusOpen);
		}
		MenuItem{
			text: enguia.tr("Closed")
			onTriggered: save(MSDefines.ScheduleStatusClosed);
		}
		MenuItem{
			text: enguia.tr("Get in touch")
			onTriggered: save(MSDefines.ScheduleStatusGetInTouch);
		}
		/*MenuItem{
			text: enguia.tr("Same as...")
			onTriggered: sameAsDlg.open();
		}*/
	}
	VMBlockScheduleProSameAsDlg{
		id: sameAsDlg
		onListItemClicked: {
			sameAs=weekDay
			save(MSDefines.ScheduleStatusSameAsOther)
		}
	}
	MouseArea{
		anchors.fill: topWindow
		propagateComposedEvents: true
		z: 1000000000
		onPressed: {
			enguia.closeDialogs(topWindow)
			mouse.accepted = false;
		}
	}
	function save(status){
		eUserServiceTimetableStatus.professionalUserID=mShared.userID;
		eUserServiceTimetableStatus.weekDay=selectedWeekday;
		eUserServiceTimetableStatus.sameAsWeekDay=sameAs;
		eUserServiceTimetableStatus.status=status;
		mSVC.metaInvoke(MSDefines.SUserServicesTimetableStatus,"SaveUserTimetableStatusOnDay",function(ok){
			statusBar.displayResult(ok,enguia.tr("Saved successfully"), enguia.tr("Unable to save"));
			if(ok)refresh();
		},enguia.convertObjectToJson(eUserServiceTimetableStatus));
	}
	function getOtherStatus(list, sameAsOther){
		for(var i=0;i<list.length;i++){
			var eUserServiceTimetableStatus=list[i];
			if(eUserServiceTimetableStatus.weekDay===sameAsOther)return eUserServiceTimetableStatus.status;
		}
		return MSDefines.ScheduleStatusUnknown;//not found. It shouldn't get here
	}
	function refresh(){
		mSVC.metaInvoke(MSDefines.SUserServicesTimetableStatus,"GetUserTimetableStatusEntireWeek",function(list){
			for(var i=0;i<list.length;i++){
				var status=MSDefines.ScheduleStatusUnknown;
				var eUserServiceTimetableStatus=list[i];
				var isSameAsOther=false;
				if(eUserServiceTimetableStatus.status===MSDefines.ScheduleStatusSameAsOther){status=getOtherStatus(list,eUserServiceTimetableStatus.sameAsWeekDay);isSameAsOther=true;}
				else status=eUserServiceTimetableStatus.status;
				listView.setStatus(eUserServiceTimetableStatus.weekDay,status,isSameAsOther,eUserServiceTimetableStatus.sameAsWeekDay);
			}
		},mShared.userID);
	}
	Component.onCompleted: {
		refresh();
	}
}


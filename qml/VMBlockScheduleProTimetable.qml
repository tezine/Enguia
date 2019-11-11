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
	id:topWindow
	property int professionalID:0
	property int selectedWeekday:0
	property int sameAs:0
	property var ePlaceServiceTimetableStatus:enguia.createEntity("EPlaceServiceTimetableStatus")

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Timetable")
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolMenu
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///SharedImages/overflow.png"
				onSigClicked: overflowMenu.popup();
			}
		}
	}
	VMBlockScheduleProWeekdaysList{
		id: listView
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}		
		onListItemPressAndHold: {
			selectedWeekday=id;
			sameAs=0
			contextMenu.popup();
		}
		onListItemClicked: {
			mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProTimetableInDay.qml"),destroyOnPop:true,immediate:true, properties:{professionalID:professionalID, weekDay:id, weekDayName:name }})
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
		MenuItem{
			text: enguia.tr("Same as...")
			onTriggered: sameAsDlg.open();
		}
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
	Menu{
		id: overflowMenu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileBlockScheduleProTimetable);
		}
	}
	function save(status){
		ePlaceServiceTimetableStatus.placeID=mShared.placeID;
		ePlaceServiceTimetableStatus.professionalID=professionalID;
		ePlaceServiceTimetableStatus.weekDay=selectedWeekday;
		ePlaceServiceTimetableStatus.sameAsWeekDay=sameAs;
		ePlaceServiceTimetableStatus.status=status;
		mSVC.metaInvoke(MSDefines.SPlaceServicesTimetableStatus,"SaveTimetableStatusOnDay",function(ok){
			statusBar.displayResult(ok,enguia.tr("Saved successfully"), enguia.tr("Unable to save"));
			if(ok)refresh();
		},enguia.convertObjectToJson(ePlaceServiceTimetableStatus));
	}
	function getOtherStatus(list, sameAsOther){
		for(var i=0;i<list.length;i++){
			var ePlaceServiceTimetableStatus=list[i];
			if(ePlaceServiceTimetableStatus.weekDay===sameAsOther)return ePlaceServiceTimetableStatus.status;
		}
		return MSDefines.ScheduleStatusUnknown;//not found. It shouldn't get here
	}
	function refresh(){
		mSVC.metaInvoke(MSDefines.SPlaceServicesTimetableStatus,"GetTimetableStatusEntireWeek",function(list){
			for(var i=0;i<list.length;i++){
				var status=MSDefines.ScheduleStatusUnknown;
				var ePlaceServiceTimetableStatus=list[i];
				var isSameAsOther=false;
				if(ePlaceServiceTimetableStatus.status===MSDefines.ScheduleStatusSameAsOther){status=getOtherStatus(list,ePlaceServiceTimetableStatus.sameAsWeekDay);isSameAsOther=true;}
				else status=ePlaceServiceTimetableStatus.status;
				listView.setStatus(ePlaceServiceTimetableStatus.weekDay,status,isSameAsOther,ePlaceServiceTimetableStatus.sameAsWeekDay);
			}
		},mShared.placeID,professionalID);
	}
	Stack.onStatusChanged: {//carregado no onCodeCompleted e pop
		if(Stack.status!==Stack.Activating)return;
		refresh();
	}
}


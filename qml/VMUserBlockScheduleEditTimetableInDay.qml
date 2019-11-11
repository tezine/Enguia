import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockSchedule"
import "qrc:/UserBlockSchedule"

Rectangle {
	property var eUserServiceTimetable: enguia.createEntity("EUserServiceTimetable");
	property int weekDay:0
	property string weekDayName:""
	color: enguia.backColor

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Timetable")
		btnDoneVisible: false
		subtitle: weekDayName
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
	Flickable {
		id: flickable
		clip: true
		width: parent.width;
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		contentWidth: parent.width
		contentHeight: grid.height+enguia.height*0.02+enguia.mediumMargin
		ColumnLayout{
			id: grid
			anchors{left:parent.left;right:parent.right;top:parent.top;}
			anchors.margins: enguia.largeMargin;
			spacing: enguia.mediumMargin
			VMBlockScheduleProTimePeriod{
				id: period1
				title: enguia.tr("Period 1")
				Layout.fillWidth: true
			}
			VMBlockScheduleProTimePeriod{
				id: period2
				title: enguia.tr("Period 2")
				Layout.fillWidth: true
				visible: period1.startString!=="..." && period1.endString!=="..."
			}
			VMBlockScheduleProTimePeriod{
				id: period3
				title: enguia.tr("Period 3")
				Layout.fillWidth: true
				visible: period2.startString!=="..." && period2.endString!=="..."
			}
			VMBlockScheduleProTimePeriod{
				id: period4
				title: enguia.tr("Period 4")
				Layout.fillWidth: true
				visible: period3.startString!=="..." && period3.endString!=="..."
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
	Menu{
		id: overflowMenu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileBlockScheduleProTimetableInDay);
		}
	}
	VMListEmptyRect{
		id: loadingRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	function save(){
		eUserServiceTimetable.weekDay=weekDay;
		if(period1.startString!=="...") eUserServiceTimetable.period1Start=period1.startString;
		if(period1.endString!=="...") eUserServiceTimetable.period1End=period1.endString;

		if(period2.startString!=="...") eUserServiceTimetable.period2Start=period2.startString;
		if(period2.endString!=="...") eUserServiceTimetable.period2End=period2.endString;

		if(period3.startString!=="...") eUserServiceTimetable.period3Start=period3.startString;
		if(period3.endString!=="...") eUserServiceTimetable.period3End=period3.endString;

		if(period4.startString!=="...") eUserServiceTimetable.period4Start=period4.startString;
		if(period4.endString!=="...") eUserServiceTimetable.period4End=period4.endString;
		mSVC.metaInvoke(MSDefines.SUserServicesTimetable, "SetDefaultUserTimetable", function(ok){
			statusBar.displayResult(ok,enguia.tr("Timetable saved successfully"),enguia.tr("Unable to save timetable"))
			if(ok)mainWindow.popWithoutClear();
		},mShared.userID,enguia.convertObjectToJson(eUserServiceTimetable));
	}
	Component.onCompleted: {
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserServicesTimetable,"GetFirstServiceTimetableForUser",function(e){
			loadingRect.visible=false;
			if(e===undefined)return;
			period1.setup(e.period1Start, e.period1End);
			period2.setup(e.period2Start, e.period2End);
			period3.setup(e.period3Start, e.period3End);
			period4.setup(e.period4Start, e.period4End);
		},mShared.userID,weekDay);
	}
}


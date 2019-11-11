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
	property date dt: new Date();
	property int serviceID: 0

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Waiting queue")
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
				source: "qrc:///SharedImages/help.png"
				onSigClicked: dlgHelp.setup(MSDefines.HelpTypeMobileBlockScheduleQueue);
			}
		}
	}
	VSharedLabelRect{
		id: lblRect1
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;}
		horizontalAlignment: Text.AlignHCenter
		text: enguia.tr("Select up to 5 days of your interest")
	}
	Rectangle{
		id:rectDays
		anchors{left:parent.left;right:parent.right;top:lblRect1.bottom;}
		height: enguia.height*0.2
		GridLayout{
			columns: 5
			anchors.fill: parent
			rowSpacing: 0
			columnSpacing: 0
			VMDayRect{
				id: day0
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
			VMDayRect{
				id: day1
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
			VMDayRect{
				id: day2
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
			VMDayRect{
				id: day3
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
			VMDayRect{
				id: day4
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
			VMDayRect{
				id: day5
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
			VMDayRect{
				id: day6
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
			VMDayRect{
				id: day7
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
			VMDayRect{
				id: day8
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
			VMDayRect{
				id: day9
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
		}
	}
	VSharedLabelRect{
		id: lblRect2
		anchors{left:parent.left;right:parent.right;top:rectDays.bottom;}
		horizontalAlignment: Text.AlignHCenter
		text: enguia.tr("Indicate the periods and comments below")
	}
	TextArea{
		id: textArea
		anchors{left:parent.left;right:parent.right;top:lblRect2.bottom;bottom:parent.bottom}
		font{pointSize: enguia.largeFontPointSize;}
	}
	function getSelectedCount(){
		var count=0;
		if(day0.selected)count++;
		if(day1.selected)count++;
		if(day2.selected)count++;
		if(day3.selected)count++;
		if(day4.selected)count++;
		if(day5.selected)count++;
		if(day6.selected)count++;
		if(day7.selected)count++;
		if(day8.selected)count++;
		if(day9.selected)count++;
		return count;
	}
	function fillDates(eScheduleQueue){
		if(day0.selected)fillNext(eScheduleQueue,day0.dt)
		if(day1.selected)fillNext(eScheduleQueue,day1.dt)
		if(day2.selected)fillNext(eScheduleQueue,day2.dt)
		if(day3.selected)fillNext(eScheduleQueue,day3.dt)
		if(day4.selected)fillNext(eScheduleQueue,day4.dt)
		if(day5.selected)fillNext(eScheduleQueue,day5.dt)
		if(day6.selected)fillNext(eScheduleQueue,day6.dt)
		if(day7.selected)fillNext(eScheduleQueue,day7.dt)
		if(day8.selected)fillNext(eScheduleQueue,day8.dt)
		if(day9.selected)fillNext(eScheduleQueue,day9.dt)
	}
	function fillNext(eScheduleDate, dt){
		if(!enguia.isValidDate(eScheduleDate.dt1))eScheduleDate.dt1=dt;
		else if(!enguia.isValidDate(eScheduleDate.dt2))eScheduleDate.dt2=dt;
		else if(!enguia.isValidDate(eScheduleDate.dt3))eScheduleDate.dt3=dt;
		else if(!enguia.isValidDate(eScheduleDate.dt4))eScheduleDate.dt4=dt;
		else if(!enguia.isValidDate(eScheduleDate.dt5))eScheduleDate.dt5=dt;
	}
	function save(){
		Qt.inputMethod.commit();
		if(getSelectedCount()<1){statusBar.displayError(enguia.tr("Select at least one day"));return;}
		if(getSelectedCount()>5){statusBar.displayError(enguia.tr("Up to 5 days maximum"));return;}
		if(textArea.text.length>=200){statusBar.displayError(enguia.tr("Maximum 200 characters"));return;}
		Qt.inputMethod.hide();
		var eUserScheduleQueue=enguia.createEntity("EUserScheduleQueue");
		eUserScheduleQueue.professionalUserID=mShared.otherUserID;
		eUserScheduleQueue.clientUserID=mShared.otherUserID;
		eUserScheduleQueue.serviceID=serviceID;
		eUserScheduleQueue.comment=textArea.text;
		fillDates(eUserScheduleQueue)
		mSVC.metaInvoke(MSDefines.SUserScheduleQueue,"AddToUserQueue",function(ok){
			statusBar.displayResult(ok,enguia.tr("Added to waiting queue successfully"),enguia.tr("Unable to add to waiting queue"))
			if(ok)mainWindow.popToMenu();
		}, enguia.convertObjectToJson(eUserScheduleQueue));
	}
	Component.onCompleted: {
		var dt1=dt;
		mSVC.metaInvoke(MSDefines.SUserBlockSchedule,"GetNextTenDaysOpen",function(list){
			for(var i=0;i<list.length;i++){
				var eScheduleDateStatus=list[i];
				var dx=eScheduleDateStatus.dt;
				switch(i){
					case 0:
						day0.dt=dx;
						break;
					case 1:
						day1.dt=dx;
						break;
					case 2:
						day2.dt=dx;
						break;
					case 3:
						day3.dt=dx;
						break;
					case 4:
						day4.dt=dx;
						break;
					case 5:
						day5.dt=dx;
						break;
					case 6:
						day6.dt=dx;
						break;
					case 7:
						day7.dt=dx;
						break;
					case 8:
						day8.dt=dx;
						break;
					case 9:
						day9.dt=dx;
						break;
				}
			}
		},mShared.otherUserID,serviceID,enguia.convertToDateISOString(dt));
	}
}


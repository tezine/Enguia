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
import "qrc:/"

Rectangle {
	property int blockID:0
	property var eUserBlockSchedule: enguia.createEntity("EUserBlockSchedule")

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Schedule")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolSave
				source: "qrc:///Images/save.png"
				Layout.fillHeight: true
				Layout.preferredWidth: height
				onSigClicked: save();
				visible: tabView.currentIndex!==0 && tabView.currentIndex!==1&& tabView.currentIndex!==2
			}
			VMToolButton{
				id: toolAdd
				source: "qrc:///Images/add.png"
				Layout.fillHeight: true
				Layout.preferredWidth: height
				onSigClicked: tabView.getTab(tabView.currentIndex).item.btnAddClicked();
				visible: tabView.currentIndex===0||tabView.currentIndex===2
			}
			VMToolButton{
				id: toolMenu
				source: "qrc:///SharedImages/overflow.png"
				Layout.fillHeight: true
				Layout.preferredWidth: height
				onSigClicked: menu.popup();
			}
		}
	}
	TabView{
		id: tabView
		anchors{top:pageTitle.bottom; bottom:parent.bottom; left:parent.left; right:parent.right;}
		style: tabViewStyleAndroid
		Tab{
			title:enguia.tr("Services")
			VMUserBlockScheduleEditServices{
				id: tabServices
			}
		}
		Tab{
			title:enguia.tr("Timetable")
			VMUserBlockScheduleEditTimetable{
				id: tabTimetable
			}
		}
		Tab{
			title:enguia.tr("Exceptions")
			VMUserBlockScheduleEditExceptions{
				id: tabExceptions
			}
		}
		Tab{
			title:enguia.tr("Options")
			VMUserBlockScheduleEditConfig{
				id: tabConfig
			}
		}
	}
	Menu{
		id: menu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileUserBlockScheduleEdit);
		}
	}
	function save(){
		Qt.inputMethod.commit();
		var tabConfig=tabView.getTab(3).item;
		if(tabConfig){if(!tabConfig.saveFields())return;}
		Qt.inputMethod.hide();
		eUserBlockSchedule.id=blockID;
		eUserBlockSchedule.userID=mShared.userID;
		mSVC.metaInvoke(MSDefines.SUserBlockSchedule,"SaveUserBlockSchedule",function(id){
			statusBar.displayResult(id,enguia.tr("Block saved successfully"),enguia.tr("Unable to save block"));
			if(id>0)mainWindow.popWithoutClear();
		},enguia.convertObjectToJson(eUserBlockSchedule));
	}
	Stack.onStatusChanged: {
		if(Stack.status!==Stack.Activating)return;
		switch(tabView.currentIndex){
			case 0://services
				tabView.getTab(tabView.currentIndex).item.refresh();
				break;
			case 1://timetable
				tabView.getTab(tabView.currentIndex).item.refresh();
				break;
			case 2://exceptions
				tabView.getTab(tabView.currentIndex).item.refresh();
				break;
		}
	}
	Component.onCompleted: {
		mSVC.metaInvoke(MSDefines.SUserBlockSchedule,"GetUserBlockScheduleByID",function(e){
			enguia.copyValues(e,eUserBlockSchedule);
		},blockID);
	}
}

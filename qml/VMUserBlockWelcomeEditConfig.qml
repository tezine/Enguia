import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/UserBlockWelcome"

Rectangle {
	color: enguia.backColor

	Flickable {
		id: flickable
		clip: true
		width: parent.width;
		height: parent.height
		contentWidth: parent.width
		contentHeight: grid.height+enguia.height*0.02+enguia.mediumMargin
		ColumnLayout{
			id: grid
			anchors{left:parent.left;right:parent.right;top:parent.top;}
			anchors.margins: enguia.smallMargin
			spacing: 0
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Block name")
			}
			VMTextField{
				id: txtName
				maximumLength: 50
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}						
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Next block")
			}
			VMComboBox{
				id: comboNextBlock
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Display info")
			}
			VMButton{
				id: btnVisibility
				Layout.fillWidth: true
				onClicked: visibilityDlg.open();
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Display working hours")
			}
			VMComboBox{
				id: comboDisplayWorkingHours
				Layout.fillWidth: true
				onCurrentIndexChanged: {
					if(comboDisplayWorkingHours.getSelected()===2)columnLayoutWorkingHours.visible=true;
					else columnLayoutWorkingHours.visible=false;
				}
			}
			Item{
				height: enguia.mediumMargin
			}
			ColumnLayout{
				id: columnLayoutWorkingHours
				visible: false
				Layout.fillWidth: true
				spacing: 0
				Layout.preferredHeight: rectMonday.height+btnMonday.height+spacingMonday.height+
										rectTuesday.height+btnTuesday.height+spacingTuesday.height+
										rectWednesday.height+btnWednesday.height+spacingWednesday.height+
										rectThursday.height+btnThursday.height+spacingThursday.height+
										rectFriday.height+btnFriday.height+spacingFriday.height+
										rectSaturday.height+btnSaturday.height+spacingSaturday.height+
										rectSunday.height+btnSunday.height+spacingSunday.height
				VSharedLabelRectCompact{
					id: rectMonday
					Layout.fillWidth: true
					text:enguia.tr("Monday")
				}
				VMButton{
					id: btnMonday
					Layout.fillWidth: true
					onClicked: timeDlg.setup(Qt.Monday,eUserBlockWelcome.mondayStart,eUserBlockWelcome.mondayEnd)
				}
				Item{
					id: spacingMonday
					height: enguia.mediumMargin
				}
				VSharedLabelRectCompact{
					id: rectTuesday
					Layout.fillWidth: true
					text:enguia.tr("Tuesday")
				}
				VMButton{
					id: btnTuesday
					Layout.fillWidth: true
					onClicked: timeDlg.setup(Qt.Tuesday,eUserBlockWelcome.tuesdayStart,eUserBlockWelcome.tuesdayEnd)
				}
				Item{
					id:spacingTuesday
					height: enguia.mediumMargin
				}
				VSharedLabelRectCompact{
					id: rectWednesday
					Layout.fillWidth: true
					text:enguia.tr("Wednesday")
				}
				VMButton{
					id: btnWednesday
					Layout.fillWidth: true
					onClicked: timeDlg.setup(Qt.Wednesday,eUserBlockWelcome.wednesdayStart,eUserBlockWelcome.wednesdayEnd)
				}
				Item{
					id:spacingWednesday
					height: enguia.mediumMargin
				}
				VSharedLabelRectCompact{
					id: rectThursday
					Layout.fillWidth: true
					text:enguia.tr("Thursday")
				}
				VMButton{
					id: btnThursday
					Layout.fillWidth: true
					onClicked: timeDlg.setup(Qt.Thursday,eUserBlockWelcome.thursdayStart,eUserBlockWelcome.thursdayEnd)
				}
				Item{
					id: spacingThursday
					height: enguia.mediumMargin
				}
				VSharedLabelRectCompact{
					id: rectFriday
					Layout.fillWidth: true
					text:enguia.tr("Friday")
				}
				VMButton{
					id: btnFriday
					Layout.fillWidth: true
					onClicked: timeDlg.setup(Qt.Friday,eUserBlockWelcome.fridayStart,eUserBlockWelcome.fridayEnd)
				}
				Item{
					id: spacingFriday
					height: enguia.mediumMargin
				}
				VSharedLabelRectCompact{
					id: rectSaturday
					Layout.fillWidth: true
					text:enguia.tr("Saturday")
				}
				VMButton{
					id: btnSaturday
					Layout.fillWidth: true
					onClicked: timeDlg.setup(Qt.Saturday,eUserBlockWelcome.saturdayStart,eUserBlockWelcome.saturdayEnd)
				}
				Item{
					id: spacingSaturday
					height: enguia.mediumMargin
				}
				VSharedLabelRectCompact{
					id: rectSunday
					Layout.fillWidth: true
					text:enguia.tr("Sunday")
				}
				VMButton{
					id: btnSunday
					Layout.fillWidth: true
					onClicked: timeDlg.setup(Qt.Sunday,eUserBlockWelcome.sundayStart,eUserBlockWelcome.sundayEnd)
				}
				Item{
					id:spacingSunday
					height: enguia.mediumMargin
				}
			}
		}
	}
	VMTimeStartEndDlg{
		id: timeDlg
		onSigBtnSaveClicked: {
			switch(type){
				case Qt.Monday:
					eUserBlockWelcome.mondayStart=enguia.convertToTime(hourStart, minuteStart);
					eUserBlockWelcome.mondayEnd=enguia.convertToTime(hourEnd,minuteEnd);
					btnMonday.text=Qt.formatTime(eUserBlockWelcome.mondayStart,"hh:mm")+enguia.tr(" until ")+Qt.formatTime(eUserBlockWelcome.mondayEnd,"hh:mm")
					break;
				case Qt.Tuesday:
					eUserBlockWelcome.tuesdayStart=enguia.convertToTime(hourStart, minuteStart);
					eUserBlockWelcome.tuesdayEnd=enguia.convertToTime(hourEnd,minuteEnd);
					btnTuesday.text=Qt.formatTime(eUserBlockWelcome.tuesdayStart,"hh:mm")+enguia.tr(" until ")+Qt.formatTime(eUserBlockWelcome.tuesdayEnd,"hh:mm")
					break;
				case Qt.Wednesday:
					eUserBlockWelcome.wednesdayStart=enguia.convertToTime(hourStart, minuteStart);
					eUserBlockWelcome.wednesdayEnd=enguia.convertToTime(hourEnd,minuteEnd);
					btnWednesday.text=Qt.formatTime(eUserBlockWelcome.wednesdayStart,"hh:mm")+enguia.tr(" until ")+Qt.formatTime(eUserBlockWelcome.wednesdayEnd,"hh:mm")
					break;
				case Qt.Thursday:
					eUserBlockWelcome.thursdayStart=enguia.convertToTime(hourStart, minuteStart);
					eUserBlockWelcome.thursdayEnd=enguia.convertToTime(hourEnd,minuteEnd);
					btnThursday.text=Qt.formatTime(eUserBlockWelcome.thursdayStart,"hh:mm")+enguia.tr(" until ")+Qt.formatTime(eUserBlockWelcome.thursdayEnd,"hh:mm")
					break;
				case Qt.Friday:
					eUserBlockWelcome.fridayStart=enguia.convertToTime(hourStart, minuteStart);
					eUserBlockWelcome.fridayEnd=enguia.convertToTime(hourEnd,minuteEnd);
					btnFriday.text=Qt.formatTime(eUserBlockWelcome.fridayStart,"hh:mm")+enguia.tr(" until ")+Qt.formatTime(eUserBlockWelcome.fridayEnd,"hh:mm")
					break;
				case Qt.Saturday:
					eUserBlockWelcome.saturdayStart=enguia.convertToTime(hourStart, minuteStart);
					eUserBlockWelcome.saturdayEnd=enguia.convertToTime(hourEnd,minuteEnd);
					btnSaturday.text=Qt.formatTime(eUserBlockWelcome.saturdayStart,"hh:mm")+enguia.tr(" until ")+Qt.formatTime(eUserBlockWelcome.saturdayEnd,"hh:mm")
					break;
				case Qt.Sunday:
					eUserBlockWelcome.sundayStart=enguia.convertToTime(hourStart, minuteStart);
					eUserBlockWelcome.sundayEnd=enguia.convertToTime(hourEnd,minuteEnd);
					btnSunday.text=Qt.formatTime(eUserBlockWelcome.sundayStart,"hh:mm")+enguia.tr(" until ")+Qt.formatTime(eUserBlockWelcome.sundayEnd,"hh:mm")
					break;
			}
		}
	}
	VMUserBlockVisibilityDlg{
		id: visibilityDlg
		onSigItemsSelected: {
			eUserBlockWelcome.infoVisibility=0;
			for(var i=0;i<selectedList.length;i++){
				var item=selectedList[i];
				if(item.id === MSDefines.BlockVisibilityMyself)eUserBlockWelcome.infoVisibility|=MSDefines.BlockVisibilityMyself;
				else if(item.id === MSDefines.BlockVisibilityBestFriends)eUserBlockWelcome.infoVisibility|=MSDefines.BlockVisibilityBestFriends;
				else if(item.id === MSDefines.BlockVisibilityFamily)eUserBlockWelcome.infoVisibility|=MSDefines.BlockVisibilityFamily;
				else if(item.id === MSDefines.BlockVisibilityFellowWorker)eUserBlockWelcome.infoVisibility|=MSDefines.BlockVisibilityFellowWorker;
				else if(item.id === MSDefines.BlockVisibilityFriends)eUserBlockWelcome.infoVisibility|=MSDefines.BlockVisibilityFriends;
				else if(item.id === MSDefines.BlockVisibilityOthers)eUserBlockWelcome.infoVisibility|=MSDefines.BlockVisibilityOthers;
			}
			btnVisibility.text=mMobile.getVisibilityName(eUserBlockWelcome.infoVisibility);
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
	function saveFields(){
		eUserBlockWelcome.name=txtName.text;
		if(comboNextBlock.count>0){
			eUserBlockWelcome.nextBlockType=comboNextBlock.getSelected();
			eUserBlockWelcome.nextBlockID=comboNextBlock.getSelectedValue();
		}
		if(comboDisplayWorkingHours.getSelected()===2)eUserBlockWelcome.displayStatus=true;
		else eUserBlockWelcome.displayStatus=false;
		return true;
	}
	Component.onCompleted: {
		comboDisplayWorkingHours.append(1,enguia.tr("No"));
		comboDisplayWorkingHours.append(2,enguia.tr("Yes"));
		txtName.text=eUserBlockWelcome.name;
		btnVisibility.text=mMobile.getVisibilityName(eUserBlockWelcome.infoVisibility);
		mSVC.metaInvoke(MSDefines.SUserBlocks,"GetUserBlocks",function(list){
			for(var i=0;i<list.length;i++){
				var eUserBlock=list[i];
				if(eUserBlock.blockType===MSDefines.UserBlockTypeWelcome)continue;
				var name=mSBlocks.getUserBlockTypeName(eUserBlock.blockType);
				if(eUserBlock.name!==undefined && eUserBlock.name.length>0)name=eUserBlock.name;
				comboNextBlock.append(eUserBlock.blockType,name,eUserBlock.id);
			}
			if(eUserBlockWelcome.nextBlockID>0)comboNextBlock.selectByTypeAndValue(eUserBlockWelcome.nextBlockType, eUserBlockWelcome.nextBlockID);
		},mShared.userID);
	}
}


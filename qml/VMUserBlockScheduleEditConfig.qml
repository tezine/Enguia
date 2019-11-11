import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/UserBlockSchedule"

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
				text:enguia.tr("Name")
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
				text:enguia.tr("Visibility")
			}
			VMButton{
				id: btnVisibility
				Layout.fillWidth: true
				onClicked: visibilityDlg.open();
			}
			Item{
				height: enguia.mediumMargin
			}
		}
	}
	VMUserBlockVisibilityDlg{
		id: visibilityDlg
		onSigItemsSelected: {
			eUserBlockSchedule.visibility=0;
			for(var i=0;i<selectedList.length;i++){
				var item=selectedList[i];
				if(item.id === MSDefines.BlockVisibilityMyself)eUserBlockSchedule.visibility|=MSDefines.BlockVisibilityMyself;
				else if(item.id === MSDefines.BlockVisibilityBestFriends)eUserBlockSchedule.visibility|=MSDefines.BlockVisibilityBestFriends;
				else if(item.id === MSDefines.BlockVisibilityFamily)eUserBlockSchedule.visibility|=MSDefines.BlockVisibilityFamily;
				else if(item.id === MSDefines.BlockVisibilityFellowWorker)eUserBlockSchedule.visibility|=MSDefines.BlockVisibilityFellowWorker;
				else if(item.id === MSDefines.BlockVisibilityFriends)eUserBlockSchedule.visibility|=MSDefines.BlockVisibilityFriends;
				else if(item.id === MSDefines.BlockVisibilityOthers)eUserBlockSchedule.visibility|=MSDefines.BlockVisibilityOthers;
			}
			btnVisibility.text=mMobile.getVisibilityName(eUserBlockSchedule.visibility);
		}
	}
	function saveFields(){
		eUserBlockSchedule.name=txtName.text;
		return true;
	}
	Component.onCompleted: {
		txtName.text=eUserBlockSchedule.name;
		btnVisibility.text=mMobile.getVisibilityName(eUserBlockSchedule.visibility);
	}
}


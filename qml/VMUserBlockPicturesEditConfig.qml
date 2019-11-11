import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/UserBlockPictures"

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
			eUserBlockPictures.visibility=0;
			for(var i=0;i<selectedList.length;i++){
				var item=selectedList[i];
				if(item.id === MSDefines.BlockVisibilityMyself)eUserBlockPictures.visibility|=MSDefines.BlockVisibilityMyself;
				else if(item.id === MSDefines.BlockVisibilityBestFriends)eUserBlockPictures.visibility|=MSDefines.BlockVisibilityBestFriends;
				else if(item.id === MSDefines.BlockVisibilityFamily)eUserBlockPictures.visibility|=MSDefines.BlockVisibilityFamily;
				else if(item.id === MSDefines.BlockVisibilityFellowWorker)eUserBlockPictures.visibility|=MSDefines.BlockVisibilityFellowWorker;
				else if(item.id === MSDefines.BlockVisibilityFriends)eUserBlockPictures.visibility|=MSDefines.BlockVisibilityFriends;
				else if(item.id === MSDefines.BlockVisibilityOthers)eUserBlockPictures.visibility|=MSDefines.BlockVisibilityOthers;
			}
			btnVisibility.text=mMobile.getVisibilityName(eUserBlockPictures.visibility);
		}
	}
	function saveFields(){
		eUserBlockPictures.name=txtName.text;
		return true;
	}
	Component.onCompleted: {
		txtName.text=eUserBlockPictures.name;
		btnVisibility.text=mMobile.getVisibilityName(eUserBlockPictures.visibility);
	}
}


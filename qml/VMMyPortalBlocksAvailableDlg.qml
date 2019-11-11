import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/MyPortal"

Dialog {
	id: dlg
	visible:false
	modality: Qt.NonModal
	property alias title: titlebar.title
	property alias titleBar:titlebar
	signal sigAddClicked(int blockType)

	contentItem: Rectangle {
		implicitWidth:enguia.width
		implicitHeight: enguia.height
		z:2
		VSharedTitleBar{
			id: titlebar
			anchors{top:parent.top}
			width: parent.width;
			title: enguia.tr("Blocks available")
			cancelText: enguia.tr("Cancel");
			saveVisible: false
			onSigCancelClicked: close();
		}
		VSharedList{
			id: listView
			anchors{top:titleBar.bottom;bottom:parent.bottom;}
			width: parent.width
			onListItemClicked: {sigAddClicked(id);close();}
		}
		VMListEmptyRect{
			id: loadingRect
			anchors{left:parent.left;right:parent.right;top:titlebar.bottom;bottom:parent.bottom}
			visible: false
			title: enguia.tr("Loading...")
			z:10
		}
	}
	function setup(userID){
		listView.clear();
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserBlocks, "GetBlocksAvailable",function(list){
			loadingRect.visible=false;
			for(var i=0;i<list.length;i++){
				var eUserBlock=list[i];
				listView.append(mSBlocks.getUserBlockTypeName(eUserBlock.blockType),"",eUserBlock.blockType);
			}
		},userID);
		open();
	}
}


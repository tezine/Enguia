import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockPictures"
import "qrc:/"

Rectangle {
	id:top

	VSharedList3{
		id: listView
		anchors.fill: parent
		onListItemPressAndHold: showDelete(id);
		onSigBtnDeleteClicked: removePicture(id)
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockPictures/VMUserBlockPicturesEditEntry.qml"),immediate:true, destroyOnPop:true, properties:{blockID:blockID,id:id} })
	}
	function saveFields(){
		return true;
	}
	function removePicture(id){
		mSVC.metaInvoke(MSDefines.SUserPictures,"DeleteUserPicture",function(ok){
			statusBar.displayResult(ok,enguia.tr("Picture removed successfully"),enguia.tr("Unable to remove picture"));
			if(ok)refresh();
		},id);
	}
	function refresh(){
		listView.clear();
		listView.loading=true;
		mSVC.metaInvoke(MSDefines.SUserPictures,"GetUserPictures",function(list){
			listView.loading=false;
			for(var i=0;i<list.length;i++){
				var eUserPicture=list[i];
				var imgUrl=mSFiles.getUserPictureThumbUrl(mShared.userID,blockID,eUserPicture.id);
				listView.append(eUserPicture.id, eUserPicture.name,imgUrl,eUserPicture.description)
			}
		},blockID);
	}
	Component.onCompleted: {
		mSVC.metaInvoke(MSDefines.SUserBlockPictures,"GetUserBlockPictureByID",function(e){
			enguia.copyValues(e,eUserBlockPictures);
		},blockID);
	}
}


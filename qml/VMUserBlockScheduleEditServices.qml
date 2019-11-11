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

	VSharedList2{
		id:listView
		anchors.fill: parent
		onListItemPressAndHold: showDelete(id);
		onSigDeleteClicked: removeService(id);
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleEditServiceEntry.qml"),immediate:true, destroyOnPop:true, properties:{serviceID:id} })
	}
	function removeService(id){
		mSVC.metaInvoke(MSDefines.SUserServices,"RemoveUserService",function(ok){
			statusBar.displayResult(ok,enguia.tr("Service removed successfully"),enguia.tr("Unable to remove service"));
			if(ok)listView.remove(id);
		},id);
	}
	function btnAddClicked(){
		mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleEditServiceEntry.qml"),immediate:true, destroyOnPop:true, properties:{serviceID:0} })
	}
	function refresh(){
		listView.clear();
		listView.loading=true;
		mSVC.metaInvoke(MSDefines.SUserServices,"GetUserServices",function(list){
			listView.loading=false;
			for(var i=0;i<list.length;i++){
				var eUserService=list[i];
				listView.append(eUserService.id, eUserService.name, eUserService.brief, "",0)
			}
		},mShared.userID);
	}
}


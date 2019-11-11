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

	VSharedList2{
		id:listView
		anchors.fill: parent
		onListItemPressAndHold: showDelete(id);
		onSigDeleteClicked: removeException(id)
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleEditExceptionEntry.qml"),immediate:true, destroyOnPop:true, properties:{exceptionID:id} })
	}
	function removeException(id){
		mSVC.metaInvoke(MSDefines.SUserServicesExceptions,"RemoveUserException",function(ok){
			statusBar.displayResult(ok,enguia.tr("Exception removed successfully"),enguia.tr("Unable to remove exception"));
			if(ok)listView.remove(id);
		},id);
	}
	function btnAddClicked(){
		mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleEditExceptionEntry.qml"),immediate:true, destroyOnPop:true, properties:{exceptionID:0} })
	}
	function refresh(){
		listView.clear();
		listView.loading=true;
		mSVC.metaInvoke(MSDefines.SUserServicesExceptions,"GetUserExceptions",function(list){
			listView.loading=false;
			for(var i=0;i<list.length;i++){
				var eUserServiceException=list[i];
				listView.append(eUserServiceException.id, Qt.formatDate(eUserServiceException.exceptionDate,Qt.SystemLocaleShortDate),mSAgenda.getScheduleStatusName(eUserServiceException.status) )
			}
		},mShared.userID);
	}
	Component.onCompleted: {
		refresh();
	}
}


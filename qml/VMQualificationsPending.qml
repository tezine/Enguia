import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Events"
import "qrc:/Components"
import "qrc:/Contacts"
import "qrc:/Favorites"
import "qrc:/Messages"
import "qrc:/News"
import "qrc:/Preferences"
import "qrc:/Qualifications"
import "qrc:/Search"
import "qrc:/Shared"
import "qrc:/Styles"

Rectangle {

	VMQualificationsPendingList{
		id: listPending
		anchors.fill: parent
		onSigEndOfListReached: getQualificationsPending();
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Qualifications/VMQualificationsNew.qml"),destroyOnPop:true,immediate:true,  properties:{id:id, placeID:placeID, placeName:placeName, historyType:historyType, title:title, dateInserted:dateInserted}})
	}
	function refresh(){
		listPending.clear();
		getQualificationsPending();
	}
	function getQualificationsPending(){
		listPending.loading=true;
		mSVC.metaInvoke(MSDefines.SUserQualifications,"GetPending",function(list){
			listPending.loading=false;
			if(list.length>=0)listPending.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eUserHistory=list[i];
				listPending.append(eUserHistory)
			}
		},mShared.userID,enguia.listCount,listPending.pageNumber);
	}
	Component.onCompleted: {
		getQualificationsPending();
	}
}


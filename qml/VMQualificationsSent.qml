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

Rectangle{
    anchors.fill:parent

	VMQualificationsList{
        id: listSent
        anchors.fill: parent
		onSigEndOfListReached: getQualificationsSent();
		onListItemClicked: {
			if(agendaID>0)mainStack.push({item:Qt.resolvedUrl("qrc:///Qualifications/VMQualificationScheduleDetail.qml"),destroyOnPop:true,immediate:true, properties:{visualID:visualID, agendaID:agendaID, placeName:placeName,comment:comment}})
			else if(orderID>0)mainStack.push({item:Qt.resolvedUrl("qrc:///Qualifications/VMQualificationOrderDetail.qml"),destroyOnPop:true,immediate:true, properties:{visualID:visualID, orderID:orderID, placeName:placeName,comment:comment}})
		}
	}
	function getQualificationsSent(){
		listSent.loading=true;
		mSVC.metaInvoke(MSDefines.SUserQualifications,"GetQualificationsUserSent",function(list){
			listSent.loading=false;
			if(list.length>=0)listSent.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eQualification=list[i];
				listSent.append(eQualification);
			}
		},mShared.userID,enguia.listCount,listSent.pageNumber);
	}
	function refresh(){
		listSent.clear();
		getQualificationsSent();
	}
	Component.onCompleted:{
		refresh()
	}
}


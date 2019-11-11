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
    anchors.fill: parent

	VMQualificationsList{
        id: listReceived
        anchors.fill: parent
		onSigEndOfListReached: getQualificationsReceived();
		onListItemClicked: {
			if(agendaID>0)mainStack.push({item:Qt.resolvedUrl("qrc:///Qualifications/VMQualificationScheduleDetail.qml"),destroyOnPop:true, immediate:true, properties:{agendaID:agendaID, visualID:visualID, placeName:placeName,comment:comment}})
			else if(orderID>0)mainStack.push({item:Qt.resolvedUrl("qrc:///Qualifications/VMQualificationOrderDetail.qml"),destroyOnPop:true, immediate:true, properties:{orderID:orderID, visualID:visualID, placeName:placeName,comment:comment}})
		}
    }
	function getQualificationsReceived(){
		listReceived.loading=true;
		mSVC.metaInvoke(MSDefines.SUserQualifications,"GetQualificationsUserReceived", function(list){
			listReceived.loading=false;
			if(list.length>=0)listReceived.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eQualification=list[i];
				listReceived.append(eQualification);
			}
		},mShared.userID,enguia.listCount,listReceived.pageNumber,true);//limpa o qualifications count
	}
	Component.onCompleted:{
		listReceived.clear();
		getQualificationsReceived();
	}
}


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
    id: topWindow
    property int placeID: 0
	property string placeName:""

    VMPageTitle{
        id: pageTitle
		title: placeName
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolMenu.left
		VMToolButton{
			id: toolMenu
			source: "qrc:///SharedImages/overflow.png"
			anchors.right: parent.right
			onSigClicked: menu.popup();
		}
    }
	VMNewsFromPlaceList{
        id: listNews
        anchors{top: pageTitle.bottom;bottom: parent.bottom;left: parent.left;right: parent.right}
		onSigEndOfListReached: getNewsFromPlace();
    }
	Menu{
		id: menu
		MenuItem{
			id: menuCancel
			text: enguia.tr("Cancel subscription")
			onTriggered: cancelSubscription();
		}
		MenuItem{
			id: menuAbuse
			text: enguia.tr("Report abuse")
			onTriggered: reportAbuse();
		}
	}
	function cancelSubscription(){
		mSVC.metaInvoke(MSDefines.SUserNews,"CancelSubscription",function(ok){
			statusBar.displayResult(ok,enguia.tr("Subscription cancelled successfully"),enguia.tr("Unable to cancel"));
		},mShared.userID,placeID);
	}
	function reportAbuse(){
		mSVC.metaInvoke(MSDefines.SUserNews,"ReportAbuse",function(ok){
			statusBar.displayResult(ok,enguia.tr("Abuse reported successfully"),enguia.tr("Unable to report abuse"))
		},mShared.userID,placeID);
	}
	function getNewsFromPlace(){
		var dt=new Date();
		listNews.loading=true;
		mSVC.metaInvoke(MSDefines.SPlaceNews,"GetValidNewsFromPlace",function(list){
			listNews.loading=false;
			if(list.length>=0)listNews.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eNew=list[i];
				listNews.append(eNew);
			}
		},placeID,enguia.convertToDateISOString(dt),enguia.listCount,listNews.pageNumber);
	}
    Component.onCompleted: {
		getNewsFromPlace();
		mSVC.metaInvoke(MSDefines.SUserNews,"MarkNewsAsRead",function(ok){
			if(!ok)statusBar.displayError(enguia.tr("Unable to mark news as read"))
		},mShared.userID,placeID)
    }
}



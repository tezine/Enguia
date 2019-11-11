import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
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
import "qrc:/History"

Rectangle {

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("History")
        btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popWithoutClear();
		titleLayout.anchors.right: toolMenu.left
		VMToolButton{
			id: toolMenu
			source: "qrc:///SharedImages/overflow.png"
			anchors.right: parent.right
			onSigClicked: menu.popup();
		}
    }
	VMHistoryList{
        id: historyList
        anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		onSigEndOfListReached: getHistory();
		onListItemClicked: {
			switch(type){
				case MMobile.HistoryTypeOrder:
					mainStack.push({item:Qt.resolvedUrl("qrc:///History/VMHistoryOrderDetail.qml"),destroyOnPop:true, immediate:true, properties:{visualID:visualID, orderID:id, name:name, placeID:placeID}})
					break;
				case MMobile.HistoryTypeSchedule:
					mainStack.push({item:Qt.resolvedUrl("qrc:///History/VMHistoryScheduleDetail.qml"),destroyOnPop:true, immediate:true, properties:{visualID:visualID, scheduleID:id, name:name,placeID:placeID}})
					break;
				case MMobile.HistoryTypeUserSchedule:
					mainStack.push({item:Qt.resolvedUrl("qrc:///History/VMHistoryUserScheduleDetail.qml"),destroyOnPop:true, immediate:true, properties:{visualID:visualID, scheduleID:id, name:name,professionalUserID:placeID}})
					break;
			}
		}
    }
	Menu{
		id: menu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileHistory);
		}
	}
	function getHistory(){
		historyList.loading=true;
		mSVC.metaInvoke(MSDefines.SUserHistory,"GetHistory",function(list){
			historyList.loading=false;
			if(list.length>=0)historyList.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eUserHistory=list[i];
				historyList.append(eUserHistory);
			}
		},mShared.userID,enguia.listCount,historyList.pageNumber)
	}
    Component.onCompleted: {
		historyList.clear();
		getHistory();
    }
}


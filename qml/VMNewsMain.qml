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
    id: mainPage

    VMPageTitle {
        id: pageTitle
		title: enguia.tr("News")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
//			VMToolButton{
//				id: toolAdd
//				Layout.fillHeight: true
//				Layout.preferredWidth: height
//				source: "qrc:///Images/add.png"
//				onSigClicked: btnAddClicked();
//				visible: false
//			}
			VMToolButton{
				id: toolMenu
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///SharedImages/overflow.png"
				onSigClicked: overflowMenu.popup();
			}
		}
    }
	VMNewsGroupedList{
        id: newsList
        anchors{ top:pageTitle.bottom; bottom: parent.bottom;left:parent.left;right:parent.right }
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///News/VMNewsFromPlace.qml"),destroyOnPop:true,immediate:true, properties:{placeID:placeID,placeName:placeName}})
		onSigEndOfListReached: getGroups();
    }
	Menu{
		id: overflowMenu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileNews);
		}
	}
	function getGroups(){
		var dt=new Date();
		newsList.loading=true;
		mSVC.metaInvoke(MSDefines.SUserNews,"GetNewsGrouped",function(list){
			newsList.loading=false;
			if(list.length>=0)newsList.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eNewGrouped=list[i];
				newsList.append(eNewGrouped);
			}
		},mShared.userID,enguia.convertToDateISOString(dt), enguia.listCount,newsList.pageNumber);
	}
    Component.onCompleted: {
		newsList.clear();
		getGroups();
    }
}



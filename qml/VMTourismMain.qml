import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
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
import "qrc:/Tourism"

Rectangle{
	id: topWindow

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("My places")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolAdd.left
		VMToolButton{
			id: toolAdd
			anchors.right: toolMenu.left
			source: "qrc:///Images/add.png"
			onSigClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Tourism/VMTourismEdit.qml"),destroyOnPop:true,immediate:true})
		}
		VMToolButton{
			id: toolMenu
			source: "qrc:///SharedImages/overflow.png"
			anchors.right: parent.right
			onSigClicked: menu.popup();
		}
	}
	VMTourismList{
		id: listView
		anchors{top: pageTitle.bottom;bottom: parent.bottom}
		width: parent.width
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Tourism/VMTourismEdit.qml"),destroyOnPop:true,immediate:true, properties:{placeID:id}})
		onSigEndOfListReached: getMyTourism();
		onListItemPressAndHold: showDelete(id)
		onSigBtnDeleteClicked: removeFun(id)
	}
	Menu{
		id: menu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileMyPlaces);
		}
	}
	Stack.onStatusChanged: {//necessário para atualizar a lista depois de adicionar um ponto
		if(Stack.status===Stack.Activating){
			listView.clear();
			getMyTourism();
		}
	}
	function removeFun(funID){
		mSVC.metaInvoke(MSDefines.SPlaces,"RemoveFun",function(ok){
			statusBar.displayResult(ok,enguia.tr("Place removed successfully"),enguia.tr("Unable to remove place"));
			if(ok)listView.remove(funID)
		},funID);
	}
	function getMyTourism(){
		mSVC.metaInvoke(MSDefines.SPlaces,"GetMyFun",function(list){
			listView.loading=false;
			if(list.length>=0)listView.pageNumber++;
			for(var i=0;i<list.length;i++){
				var ePlace=list[i];
				listView.append(ePlace)
			}
		},mShared.userID,enguia.listCount,listView.pageNumber);
	}
	Component.onCompleted: {
		listView.clear()
		listView.loading=true;
	}
}



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
import "qrc:/BlockWelcome"

Rectangle{
	id:topWindow
    anchors.fill: parent

	VMFavoritesList{
        id: menuList
        anchors.fill: parent
		onListItemClicked: itemClicked(userID,placeID)
        onListItemPressAndHold: showDelete(id);
		onSigBtnDeleteClicked: removeFavorite(id)
		onSigEndOfListReached: getFavorites();
    }
	function removeFavorite(id){
		mSVC.metaInvoke(MSDefines.SUserFavorites, "RemoveFavorite",function(ok){
			if(ok===true)menuList.remove(id)
			else statusBar.displayError(enguia.tr("Unable to remove"));
		},id);
	}
	function itemClicked(userID, placeID){
		if(placeID>0)mainStack.push({item:Qt.resolvedUrl("qrc:///BlockWelcome/VMBlockWelcome.qml"),destroyOnPop:true,immediate:true, properties:{placeID:placeID}})
		else if(userID>0)mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockWelcome/VMUserBlockWelcome.qml"),destroyOnPop:true,immediate:true, properties:{otherUserID:userID}})
	}
	function getFavorites(){
		menuList.loading=true;
		mSVC.metaInvoke(MSDefines.SUserFavorites,"GetFavorites", function(list){
			menuList.loading=false;
			if(list.length>=0)menuList.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eUserFavorite=list[i];
				menuList.append(eUserFavorite.id, eUserFavorite.otherUserID,eUserFavorite.placeID,eUserFavorite.name, eUserFavorite.brief, eUserFavorite.enabled);
			}
		},mShared.userID,enguia.listCount,menuList.pageNumber);
	}	
	Component.onCompleted: {
		menuList.clear();
		getFavorites();
	}
}


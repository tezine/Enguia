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
    id: mainPage
    property string categoryName: ""
    property int categoryID: 0

    VMPageTitle{
        id: pageTitle
        title: categoryName
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
    }
	VMFavoritesList{
        id: menuList
        anchors{top: pageTitle.bottom;left: parent.left;right: parent.right;bottom: parent.bottom}
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockWelcome/VMBlockWelcome.qml"),destroyOnPop:true,immediate:true, properties:{placeID:placeID}})
        onListItemPressAndHold: showDelete(id);
		onSigBtnDeleteClicked: removeFavorite(placeID);
    }
	function removeFavorite(placeID){
		mSVC.metaInvoke(MSDefines.SUserFavorites, "RemoveFavoriteByPlaceID",function(ok){
			if(ok===true)menuList.removeCurrent();
			else statusBar.displayError(enguia.tr("Unable to remove"));
		},mShared.userID,placeID);
    }
    Component.onCompleted:{
		menuList.loading=true;
		mSVC.metaInvoke(MSDefines.SUserFavorites,"GetPlacesByCategory",function(list){
			menuList.loading=false;
			for(var i=0;i<list.length;i++){
				var ePlace=list[i];
				menuList.append(ePlace.id,0,ePlace.id, ePlace.name,ePlace.brief,ePlace.enabled);
			}
		},mShared.userID,categoryID)
    }
}

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

	VMFavoritesListGrouped{
        id: menuList
        anchors.fill: parent
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Favorites/VMFavoritesInCategory.qml"),destroyOnPop:true,immediate:true, properties:{categoryName:name, categoryID:id}})
    }	
	function getCategories(){
		menuList.loading=true;
		mSVC.metaInvoke(MSDefines.SUserFavorites,"GetCategories",function(list){
			menuList.loading=false;
			if(list.length>=0)menuList.pageNumber++;
			for(var i=0;i<list.length;i++){
				var ePlaceCategory=list[i];
				menuList.append(ePlaceCategory.ptBr,ePlaceCategory.id,'')//imagem era assim 'qrc:/Images/'+mData.getImageNameFromCategoryID(list[i].id)
			}
		},mShared.userID,enguia.listCount,menuList.pageNumber);
	}
	Component.onCompleted: {
		menuList.clear();
		getCategories()
	}
}

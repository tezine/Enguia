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
	property int categoryID:0

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Search by category")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
    }
	VMListMenuWithoutMargin{
        id: menuList
        anchors{top: pageTitle.bottom;left: parent.left;right: parent.right;bottom: parent.bottom}
		onListItemClicked: listClicked(id)
    }
	function listClicked(categoryID){
		mSVC.metaInvoke(MSDefines.SPlaceCategories,"ContainsSubCategory",function(b){
			if(b)mainStack.push({item:Qt.resolvedUrl("qrc:///Search/VMSearchByCategory.qml"),destroyOnPop:true,immediate:true, properties:{categoryID:categoryID}})
			else search(categoryID)
		},categoryID);
	}
	function getCategories(categoryID){
		menuList.clear();
		menuList.loading=true;
		mSVC.metaInvoke(MSDefines.SPlaceCategories,"GetCategories",function(list){
			menuList.loading=false;
			for(var i=0;i<list.length;i++){
				var ePlaceCategory=list[i];
				if(ePlaceCategory.id===MSDefines.MainCategoryTypeEvents)continue;//we don't show it here
				menuList.append(ePlaceCategory.id, ePlaceCategory.ptBr)
			}
		},categoryID);
	}
	function search(categoryID){
		mSVC.metaInvoke(MSDefines.SPlaces, "SearchByCategory", function(list){
			if(list.length===0){statusBar.displayError(enguia.tr("Nothing found"));return;}
			mainStack.push({item:Qt.resolvedUrl("qrc:///Search/VMSearchResult.qml"),destroyOnPop:true, immediate:true, properties:{searchType:MMobile.SearchTypeCategory, resultList:list, categoryID:categoryID}})
		},mMobile.cityID, categoryID,enguia.listCount,0);
	}
    Component.onCompleted: {
		getCategories(categoryID);
    }
}



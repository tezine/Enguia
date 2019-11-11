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
    property int searchType: 0
    property string searchName: ""
    property string searchUser: ""
    property string searchAddress: ""
    property int categoryID: 0
	property int priceRange:0
	property int ageRange:0
	property var resultList:null
	property alias titleName:pageTitle.title

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Search result")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
    }
	VMSearchResultList{
        id: listResult
        anchors{top: pageTitle.bottom;left: parent.left;right: parent.right;bottom: parent.bottom}
		onListItemClicked:mainStack.push({item:Qt.resolvedUrl("qrc:///BlockWelcome/VMBlockWelcome.qml"),destroyOnPop:true,immediate:true, properties:{placeID:id}})
		onSigEndOfListReached: search(pageNumber)
    }
    function search(pageNumber){
		switch(searchType){
			case MMobile.SearchTypePrice:{
				mSVC.metaInvoke(MSDefines.SPlaces,"SearchByPrice",function(list){
					if(list.length>=0)listResult.pageNumber++;
					displayList(list)
				},mMobile.cityID, priceRange,enguia.listCount,pageNumber);
				break;
			}
			case MMobile.SearchTypeAge:{
				mSVC.metaInvoke(MSDefines.SPlaces,"SearchByAge",function(list){
					if(list.length>=0)listResult.pageNumber++;
					displayList(list)
				},mMobile.cityID,ageRange,enguia.listCount,pageNumber);
				break;
			}
			case MMobile.SearchTypeCategory:{
				mSVC.metaInvoke(MSDefines.SPlaces, "SearchByCategory", function(list){
					if(list.length>=0)listResult.pageNumber++;
					displayList(list)
				},mMobile.cityID, categoryID,enguia.listCount,pageNumber);
				break;
			}
		}
    }	
	function displayList(list){
		switch(searchType){
			case MMobile.SearchTypePrice:
				for(var n=0;n<list.length;n++){
					var ePlace=list[n];
					listResult.append(ePlace.id, ePlace.name, ePlace.brief, ePlace.categoryID, ePlace.rating, ePlace.viewCount,ePlace.cityName);
				}
				break;
			case MMobile.SearchTypeAge:
				for(var q=0;q<list.length;q++){
					var r=list[q];
					listResult.append(r.id, r.name, r.brief, r.categoryID, r.rating, r.viewCount,r.cityName);
				}
				break;
			case MMobile.SearchTypeCategory:
				for(var s=0;s<list.length;s++){
					var t=list[s];
					listResult.append(t.id, t.name, t.brief, t.categoryID, t.rating, t.viewCount,t.cityName);
				}
				break;
		}
	}
    Component.onCompleted: {
		displayList(resultList)//mostra a primeira pagina
		listResult.pageNumber++;
    }
}


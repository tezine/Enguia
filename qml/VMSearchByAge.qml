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

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Search by age")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
    }
	VMSearchList{
        id: listAge
        anchors{top: pageTitle.bottom;left: parent.left;right: parent.right;bottom: parent.bottom}
		onListItemClicked: search(range);
    }	
	function search(searchRange){
		mSVC.metaInvoke(MSDefines.SPlaces,"SearchByAge",function(list){
			if(list.length===0){statusBar.displayError(enguia.tr("Nothing found"));return;}
			mainStack.push({item:Qt.resolvedUrl("qrc:///Search/VMSearchResult.qml"),destroyOnPop:true,immediate:true, properties:{searchType:MMobile.SearchTypeAge, resultList:list, ageRange:searchRange}})
		},mMobile.cityID,searchRange,enguia.listCount,0);
	}
    Component.onCompleted:{
		listAge.listModel.append({"title":mShared.getAgeRangeName(MSDefines.AgeRangeUpTo5),"range":MSDefines.AgeRangeUpTo5, "image":"qrc:///SharedImages/baby.png"})
		listAge.listModel.append({"title":mShared.getAgeRangeName(MSDefines.AgeRangeUpTo10),"range":MSDefines.AgeRangeUpTo10, "image":"qrc:///SharedImages/child.png"})
		listAge.listModel.append({"title":mShared.getAgeRangeName(MSDefines.AgeRangeUpTo17),"range":MSDefines.AgeRangeUpTo17, "image":"qrc:///SharedImages/teen.png"})
		listAge.listModel.append({"title":mShared.getAgeRangeName(MSDefines.AgeRangeAfter18),"range":MSDefines.AgeRangeAfter18, "image":"qrc:///SharedImages/ageafter18.png"})
		listAge.listModel.append({"title":mShared.getAgeRangeName(MSDefines.AgeRangeUpTo30),"range":MSDefines.AgeRangeUpTo30, "image":"qrc:///SharedImages/manTo30.png"})
		listAge.listModel.append({"title":mShared.getAgeRangeName(MSDefines.AgeRangeUpTo40),"range":MSDefines.AgeRangeUpTo40, "image":"qrc:///SharedImages/manTo40.png"})
		listAge.listModel.append({"title":mShared.getAgeRangeName(MSDefines.AgeRangeUpTo50),"range":MSDefines.AgeRangeUpTo50, "image":"qrc:///SharedImages/manTo50.png"})
		listAge.listModel.append({"title":mShared.getAgeRangeName(MSDefines.AgeRangeAfter50),"range":MSDefines.AgeRangeAfter50, "image":"qrc:///SharedImages/manFrom51.png"})
    }
}

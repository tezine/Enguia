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
		title: enguia.tr("Search by price")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
	}
	VMSearchList{
		id: listByPrice
		anchors{top: pageTitle.bottom;left: parent.left;right: parent.right;bottom: parent.bottom}
		onListItemClicked: search(range);
	}
	Component.onCompleted:{
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeFree),"range":MSDefines.PriceRangeFree})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo10),"range":MSDefines.PriceRangeUpTo10})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo20),"range":MSDefines.PriceRangeUpTo20})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo30),"range":MSDefines.PriceRangeUpTo30})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo40),"range":MSDefines.PriceRangeUpTo40})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo50),"range":MSDefines.PriceRangeUpTo50})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo60),"range":MSDefines.PriceRangeUpTo60})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo70),"range":MSDefines.PriceRangeUpTo70})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo80),"range":MSDefines.PriceRangeUpTo80})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo90),"range":MSDefines.PriceRangeUpTo90})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo100),"range":MSDefines.PriceRangeUpTo100})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo150),"range":MSDefines.PriceRangeUpTo150})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo200),"range":MSDefines.PriceRangeUpTo200})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo250),"range":MSDefines.PriceRangeUpTo250})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo300),"range":MSDefines.PriceRangeUpTo300})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo350),"range":MSDefines.PriceRangeUpTo350})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeUpTo400),"range":MSDefines.PriceRangeUpTo400})
		listByPrice.listModel.append({"title":mShared.getPriceRangeName(MSDefines.PriceRangeBeyond400),"range":MSDefines.PriceRangeBeyond400})
	}
	function search(range){
		mSVC.metaInvoke(MSDefines.SPlaces,"SearchByPrice",function(list){
			if(list.length===0){statusBar.displayError(enguia.tr("Nothing found"));return;}
			mainStack.push({item:Qt.resolvedUrl("qrc:///Search/VMSearchResult.qml"),destroyOnPop:true, properties:{searchType:MMobile.SearchTypePrice, resultList:list, priceRange:range}})
		},mMobile.cityID, range,enguia.listCount,0);
	}
}



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
    id: placesSearchByAddress

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Search by address")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
    }
    Column{
        id: column
		spacing: enguia.smallMargin
        anchors{top: pageTitle.bottom;topMargin: enguia.mediumMargin;leftMargin: enguia.mediumMargin;rightMargin: enguia.mediumMargin;right: parent.right;left: parent.left}
        VMTextField{
            id: txtAddress
			placeholderText: enguia.tr("Address")
			inputMethodHints: Qt.ImhNoPredictiveText
            width: parent.width
            maximumLength: 100
			onAccepted: btnSearchClicked();
        }
		VMButton{
            id: btnCleanDB
			text: enguia.tr("Search")
            width: parent.width
			onClicked:btnSearchClicked();
        }
    }
	VMSearchResultList{
		id: listResult
		anchors{top: column.bottom;topMargin: enguia.mediumMargin; left: parent.left;right: parent.right;bottom: parent.bottom}
		onListItemClicked:mainStack.push({item:Qt.resolvedUrl("qrc:///BlockWelcome/VMBlockWelcome.qml"),destroyOnPop:true,immediate:true, properties:{placeID:id}})
		onSigEndOfListReached: searchByAddress();
	}
	Stack.onStatusChanged: {
		if(Stack.status!==Stack.Active)return;
		txtAddress.text=""
	}
	function btnSearchClicked(){
		Qt.inputMethod.commit();
		statusBar.visible=false;
		Qt.inputMethod.hide();
		listResult.clear();
		if(txtAddress.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		listResult.loading=true;
		searchByAddress();
    }
	function searchByAddress(){
		mSVC.metaInvoke(MSDefines.SPlaces, "SearchByAddress", function(list){
			listResult.loading=false;
			if(list.length>=0)listResult.pageNumber++;
			if(list.length===0){statusBar.displayError(enguia.tr("Nothing found"));return;}
			for(var j=0;j<list.length;j++){
				var k=list[j];
				listResult.append(k.id, k.name, k.address, k.categoryID, k.rating, k.viewCount,k.cityName);
			}
		},mMobile.cityID,txtAddress.text,enguia.listCount,listResult.pageNumber);
	}
}


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

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Search by user")
        btnDoneVisible: false
        btnCancelVisible: false
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
    }
	ColumnLayout {
        id: grid
		anchors{top: pageTitle.bottom;topMargin: enguia.mediumMargin;leftMargin: enguia.mediumMargin;rightMargin: enguia.mediumMargin;right: parent.right;left: parent.left}
		spacing: enguia.smallMargin
        VMTextField{
            id: txtLogin
			Layout.fillWidth: true
			placeholderText: enguia.tr("User login")
			inputMethodHints: Qt.ImhNoPredictiveText
            maximumLength: 50
			onAccepted: btnSearchClicked();
        }
        VMButton{
            id: btnSearch
			text: enguia.tr("Search")
			Layout.fillWidth: true
			onClicked:btnSearchClicked();
        }
    }
	VMSearchResultList{
		id: listResult
		anchors{top: grid.bottom;topMargin: enguia.mediumMargin; left: parent.left;right: parent.right;bottom: parent.bottom}
		onListItemClicked:mainStack.push({item:Qt.resolvedUrl("qrc:///BlockWelcome/VMBlockWelcome.qml"),destroyOnPop:true,immediate:true, properties:{placeID:id}})
		onSigEndOfListReached: searchByUser();
	}
	Stack.onStatusChanged: {
		if(Stack.status!==Stack.Active)return;
		txtLogin.text=""
	}
	function btnSearchClicked(){
		Qt.inputMethod.commit();
		statusBar.visible=false;
		Qt.inputMethod.hide();
		listResult.clear();
		if(txtLogin.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		listResult.loading=true;
		searchByUser();
    }
	function searchByUser(){
		mSVC.metaInvoke(MSDefines.SPlaces,"SearchByUser",function(list){
			listResult.loading=false;
			if(list.length>=0)listResult.pageNumber++;
			if(list.length===0){statusBar.displayError(enguia.tr("Nothing found"));return;}
			for(var l=0;l<list.length;l++){
				var m=list[l];
				listResult.append(m.id, m.name, m.brief, m.categoryID, m.rating, m.viewCount,m.cityName);
			}
		},txtLogin.text,enguia.listCount,listResult.pageNumber)
	}
}


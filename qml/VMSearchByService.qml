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

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Search by service")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
	}
	ColumnLayout {
		id: grid
		anchors{top: pageTitle.bottom;topMargin: enguia.mediumMargin;leftMargin:enguia.mediumMargin;rightMargin:enguia.mediumMargin;right: parent.right;left: parent.left}
		spacing: enguia.smallMargin
		TextField{
			id: txtName
			style: textFieldStyleAndroid
			Layout.fillWidth: true
			inputMethodHints: Qt.ImhNoPredictiveText
			placeholderText: enguia.tr("Service name")
			maximumLength: 50
			onAccepted: btnSearchClicked();
		}
		Button{
			id: btnSearch
			Layout.fillWidth: true
			style: buttonStyleAndroid
			text: enguia.tr("Search")
			width: parent.width
			onClicked: btnSearchClicked();
		}
	}
	VMSearchResultList{
		id: listResult
		anchors{top: grid.bottom;topMargin: enguia.mediumMargin; left: parent.left;right: parent.right;bottom: parent.bottom}
		onListItemClicked:mainStack.push({item:Qt.resolvedUrl("qrc:///BlockWelcome/VMBlockWelcome.qml"),immediate:true, destroyOnPop:true,properties:{placeID:id}})
		onSigEndOfListReached: searchByService();
	}
	Stack.onStatusChanged: {
		if(Stack.status!==Stack.Active)return;
		txtName.text=""
	}
	function btnSearchClicked(){
		Qt.inputMethod.commit();
		listResult.clear();
		statusBar.visible=false;
		Qt.inputMethod.hide();
		if(txtName.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		listResult.loading=true;
		searchByService();
	}
	function searchByService(){
		mSVC.metaInvoke(MSDefines.SPlaces, "SearchByService",function(list){
			listResult.loading=false;
			if(list.length>=0)listResult.pageNumber++;
			if(list.length===0){statusBar.displayError(enguia.tr("Nothing found"));return;}
			for(var i=0;i<list.length;i++){
				var e=list[i];
				listResult.append(e.id, e.name, e.brief, e.categoryID, e.rating, e.viewCount, e.cityName);
			}
		},mMobile.cityID, txtName.text,enguia.listCount,listResult.pageNumber);
	}
}

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
		title: enguia.tr("City selection")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
    }
    ColumnLayout{
        id: columnLayout
        anchors{top: pageTitle.bottom;topMargin: enguia.mediumMargin;left:parent.left; leftMargin: enguia.smallMargin;right:parent.right; rightMargin: enguia.smallMargin;}
        spacing: enguia.smallMargin
		VMTextField{
            id: txtCity
            Layout.fillWidth:true
			placeholderText: enguia.tr("City name")
			maximumLength: 100
			onAccepted: btnSearchClicked();
        }
		VMButton{
            id: btnSearch
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth:true
			text:enguia.tr("Search");
			onClicked: btnSearchClicked();
        }
    }
	VMListEmptyRect{
		id: searchingRect
		anchors{left:parent.left;right:parent.right;top:columnLayout.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Searching...")
		z:10
	}
	VMListCityResult{
        id: listCityResult
        visible:false
        anchors{top:columnLayout.bottom;topMargin:enguia.mediumMargin; bottom:parent.bottom; left: parent.left; right:parent.right; }
        onListItemClicked: setCurrentCity(mShared.userID,id,name);
		onSigEndOfListReached: searchCityByName(txtCity.text)
    }
	function btnSearchClicked(){
		Qt.inputMethod.commit();
		listCityResult.clear();
		statusBar.visible=false;
		Qt.inputMethod.hide();
		if(txtCity.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		searchCityByName(txtCity.text);
	}
    function searchCityByName(name){
		searchingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SCities,"SearchCityByName",function(list){
			listCityResult.visible=true;
			searchingRect.visible=false;
			if(list.length>=0)listCityResult.pageNumber++;
			for(var i=0;i<list.length;i++){
				var e=list[i];
				if(e.name.length<2)listCityResult.append(e.id, e.asciiName, e.stateName, e.countryName);
				else listCityResult.append(e.id, e.name, e.stateName, e.countryName);
			}
		}, name,enguia.listCount,listCityResult.pageNumber);
    }
    function setCurrentCity(currentUserID, cityID, cityName){
		mMobile.setCurrentCity(currentUserID,cityID, cityName);
		mainWindow.popOneLevel();
    }
}



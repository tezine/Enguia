import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
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


Dialog {
	id: dlgBase
	visible:false
	property alias title: titlebar.title
	property alias titleBar:titlebar
	property alias saveVisible: titlebar.saveVisible
	property date dtStart: new Date()
	property int type:0
	signal sigCitySelected(int cityID, string cityName);
	width: enguia.width
	height: enguia.height

	contentItem: Rectangle {
		implicitWidth: enguia.width
		implicitHeight: enguia.height
		VMDlgTitleBar{
			id: titlebar
			anchors{top:parent.top}
			width: parent.width;
			title: enguia.tr("City selection");
			onSigCancelClicked: close();
			saveVisible: false
		}
		ColumnLayout{
			id: columnLayout
			anchors{top: titlebar.bottom;topMargin: enguia.mediumMargin;left:parent.left; leftMargin: enguia.smallMargin;right:parent.right; rightMargin: enguia.smallMargin;}
			spacing: enguia.smallMargin
			VMTextField{
				id: txtCity
				Layout.fillWidth:true
				placeholderText: enguia.tr("City name")
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
		VSBusyIndicator{
			id: indicator
			anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter}
			width: enguia.width/2
			height: enguia.width/2
			running: true
			visible: false
		}
		VMListCityResult{
			id: listCityResult
			visible:false
			anchors{top:columnLayout.bottom; bottom:parent.bottom; left: parent.left; right:parent.right; }
			onListItemClicked: {sigCitySelected(id,name);close();}
			onSigEndOfListReached: searchCityByName(txtCity.text)
		}
		VMRectMsg{
			id: rectError
			anchors{left:parent.left; leftMargin:enguia.smallMargin; right:parent.right; rightMargin: enguia.smallMargin; top:columnLayout.bottom; topMargin:enguia.smallMargin}
			height: enguia.height*0.1
			visible:false
		}
	}
	function btnSearchClicked(){
		Qt.inputMethod.commit();
		listCityResult.clear();
		statusBar.visible=false;
		Qt.inputMethod.hide();
		listCityResult.visible=false;
		if(txtCity.text.length<3){rectError.displayError(enguia.tr("Type at least 3 characters"));return;}
		searchCityByName(txtCity.text)
	}
	function searchCityByName(name){
		indicator.visible=true;
		mSVC.metaInvoke(MSDefines.SCities,"SearchCityByName",function(list){
			listCityResult.visible=true;
			indicator.visible=false;
			if(list.length>=0)listCityResult.pageNumber++;
			for(var i=0;i<list.length;i++){
				var e=list[i];
				if(e.name.length<2)listCityResult.append(e.id, e.asciiName, e.stateName, e.countryName);
				else listCityResult.append(e.id, e.name, e.stateName, e.countryName);
			}
		},name,enguia.listCount,listCityResult.pageNumber);
	}
}

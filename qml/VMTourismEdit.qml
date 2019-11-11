import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
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
import "qrc:/Tourism"
import "qrc:/"

Rectangle{
    id: topWindow
	property var ePlace: enguia.createEntity("EPlace");
	property int placeID:0
	property bool isEvent:false//setado pelo VMEventsMain
	property bool isNew:false//usado para setar o mainPicture, caso nao esteja setado

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("New place")
		titleLayout.anchors.right: pageTitle.right
        btnBackVisible: true
        btnDoneVisible: true
		onSigBtnBackClicked: mainWindow.popWithoutClear();
		onDone: save();
		z:10//para o scrollbar do edit nao passar por cima
    }
    TabView{
        id: tabView
        style: tabViewStyleAndroid
        anchors{top: pageTitle.bottom;bottom: parent.bottom;left:parent.left;right:parent.right}
		onCurrentIndexChanged: {
			if(currentIndex!==1)Qt.inputMethod.hide();
		}
        Tab {
            id: tabGeneral
			title: enguia.tr("General");
			VMTourismEditGeneral{
            }
        }
        Tab {
            id: tabDescription
			title: enguia.tr("Description");
			VMTourismEditDescription{
            }
        }
		Tab {
            id: tabPictures
			title: enguia.tr("Pictures");
			VMTourismEditPictures{
            }
        }
    }
    function save(){
		Qt.inputMethod.commit();
		statusBar.visible=false;
		Qt.inputMethod.hide();
		if(ePlace.id===0)isNew=true;
        var tabGeneral=tabView.getTab(0).item;
		var tabDescription=tabView.getTab(1).item;
		var tabPictures=tabView.getTab(2).item;
		if(tabGeneral){if(!tabGeneral.saveFields())return;}
		if(tabDescription){if(!tabDescription.saveFields())return;}
		mSVC.metaInvoke(MSDefines.SPlaces,"SaveMyFun",function(id){
			statusBar.displayResult(id,enguia.tr("Place saved successfully"),enguia.tr("Unable to save place"))
			if(id>0){
				ePlace.id=id;
				placeID=id;
				if(tabPictures && tabPictures.hasPicturesToSend())tabPictures.sendPictures(id);
				else mainWindow.popWithoutClear();
			}
		},ePlace);
    }
	Component.onCompleted: {
		ePlace.id=placeID;
	}
}

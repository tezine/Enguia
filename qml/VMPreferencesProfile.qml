import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
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
    id:topWindow
	property var eUser: enguia.createEntity("EUser");
	color:enguia.backColor

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Profile")
		titleLayout.anchors.right: btnDone.left
		btnDoneVisible: true
        onDone: save()
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		z:50//por causa do scrollbar
    }
    TabView{
        id: tabView
        anchors{top: pageTitle.bottom;bottom: parent.bottom}
        width: parent.width
        style: tabViewStyleAndroid
        Tab{
			title:enguia.tr("General")
			VMPreferencesProfileGeneral{
                id:tabGeneral
            }
        }
        Tab{
			title: enguia.tr("Address");
			VMPreferencesProfileAddress{
                id: tabAddress
            }
        }
    }
    function save(){
        var tabGeneral=tabView.getTab(0).item;
		var tabAddress=tabView.getTab(1).item;
		if(!tabGeneral.saveFields())return;
		if(tabAddress){ if(!tabAddress.saveFields())return;}
		mSVC.metaInvoke(MSDefines.SUsers,"UpdateProfile",function(result){
			statusBar.displayResult(result,enguia.tr("Profile saved successfully"),enguia.tr("Unable to save profile"))
			if(result===2/*profile complete*/)mShared.isProfileComplete=true;
			else if(result===1/*profile incomplete*/)mShared.isProfileComplete=false;
			if(result>0)mainWindow.popWithoutClear();
		},eUser);
    }
}

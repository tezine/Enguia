import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import QtQuick.Window 2.2
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

Rectangle {
	id: vmmenu
	property string fileName:"VMMenu"
	property bool containsMngBlocks:false

	VMPageTitle {
        id: pageTitle
        Label{
            color:"white"
			text:"Enguia"
            font{pointSize: enguia.imenseFontPointSize;bold: true}
            anchors{left:parent.left;verticalCenter:parent.verticalCenter; leftMargin:enguia.mediumMargin}
        }
		VMLabelButton{
            id: lblCityName
			text: mMobile.cityName
			anchors{right:parent.right; verticalCenter: parent.verticalCenter;}
			fontPointSize: enguia.largeFontPointSize			
			borderVisible: true
			fontBold: true
			textColor:"white"
			onSigClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Preferences/VMPreferencesCity.qml"),destroyOnPop:true, immediate:true})
        }
    }
	VMListMainWindow {
        id: menuList
        displayCounter:true
        anchors{top: pageTitle.bottom; left: parent.left; right: parent.right; bottom:parent.bottom}
		onListItemClicked:  listClicked(value)
    }
	function listClicked(value){
		switch(value){
			case "MyPortal/VMMyPortal.qml":
				if(!containsMngBlocks)mainStack.push({item:Qt.resolvedUrl("qrc:///"+value),immediate:true, destroyOnPop:true})
				else mainStack.push({item:Qt.resolvedUrl("qrc:///MyPortal/VMMyPortalMng.qml"),immediate:true, destroyOnPop:true})
				break;
			case "Sights":
				getSights();
				break;
			default:
				mainStack.push({item:Qt.resolvedUrl("qrc:///"+value),immediate:true, destroyOnPop:true})
				break;
		}
	}
	function getSights(){
		mSVC.metaInvoke(MSDefines.SPlaces, "SearchByCategory", function(list){
			if(list.length===0){statusBar.displayError(enguia.tr("Nothing found"));return;}
			mainStack.push({item:Qt.resolvedUrl("qrc:///Search/VMSearchResult.qml"),destroyOnPop:true, immediate:true,
							   properties:{searchType:MMobile.SearchTypeCategory, resultList:list, categoryID:MSDefines.MainCategoryTypeTurism,titleName:enguia.tr("Sights") }})
		},mMobile.cityID, MSDefines.MainCategoryTypeTurism,enguia.listCount,0);
	}
    function getMobileCounts(currentUserID){
		var dt=new Date();
		mSVC.metaInvoke(MSDefines.SUsers,"GetMobileCounts",function(e){
			menuList.setMsgCount(e.unreadMsgCount);
			menuList.setNewsCount(e.unreadNewsCount);
			menuList.setQualificationsCount(e.unreadQualificationsCount);
			vmmenu.containsMngBlocks=e.containsMngBlocks;
		},currentUserID, enguia.convertToDateISOString(dt));
	}
	Stack.onStatusChanged: {//carregado automaticamente pelo onCodeCompleted e pop
		if(Stack.status!==Stack.Activating)return;
		getMobileCounts(mShared.userID);
	}
    Component.onCompleted:{
		if(mShared.userID>0){
			enguia.startRegistrationIntentService();
			mSUsers.setAppleDeviceToken(mShared.userID);
		}
		enguia.setScreenHeight(Screen.desktopAvailableHeight)//hack para ios, android e winphone
		enguia.setScreenWidth(Screen.desktopAvailableWidth);
        menuList.clear();
		menuList.append(enguia.tr('Search'),"Search/VMSearchMain.qml" ,0,'qrc:///Images/search.png')
		menuList.append(enguia.tr('Events'),"Events/VMEventsMain.qml",0,'qrc:///Images/agenda.png')
		menuList.append(enguia.tr('Sights'),"Sights" ,0,'qrc:///Images/fun.png')
		menuList.append(enguia.tr('Favorites'),"Favorites/VMFavoritesMain.qml",0,'qrc:///Images/favorites.png')
		menuList.append(enguia.tr('Messages'),"Messages/VMMessagesMain.qml",0,'qrc:///Images/chat.png')
		menuList.append(enguia.tr('News'),"News/VMNewsMain.qml",0,'qrc:///Images/news.png')
		menuList.append(enguia.tr('Qualifications'),"Qualifications/VMQualificationsMain.qml",0,'qrc:///Images/qualification.png')
		menuList.append(enguia.tr('My portal'),"MyPortal/VMMyPortal.qml" ,0,'qrc:///Images/myportal.png')
		menuList.append(enguia.tr('History'),"History/VMHistoryMain.qml",0,'qrc:///Images/history.png')
		menuList.append(enguia.tr('Preferences'),"Preferences/VMPreferencesMain.qml",0,'qrc:///Images/preferences.png')
		//menuList.append('Contatos',"Contacts/VContactsMain.qml",0,'qrc:///Images/people.png')
    }
}




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
		title: enguia.tr("Search")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		VMToolButton{
			id: toolMenu
			source: "qrc:///SharedImages/overflow.png"
			anchors.right: parent.right
			onSigClicked: menu.popup();
		}
    }
	VMListMenu2{
        id: menuList
        anchors{top: pageTitle.bottom;left: parent.left;right: parent.right;bottom: parent.bottom}
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///"+value),immediate:true, destroyOnPop:true})
    }
	Menu{
		id: menu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileSearch);
		}
	}
    Component.onCompleted:{
        menuList.clear()
		menuList.append(enguia.tr('By name'),"Search/VMSearchByName.qml" ,0,'qrc:///Images/byname.png')
		menuList.append(enguia.tr('By service'),"Search/VMSearchByService.qml",0,'qrc:///Images/service.png')
		menuList.append(enguia.tr('By product'),"Search/VMSearchByProduct.qml",0,'qrc:///Images/product.png')
		menuList.append(enguia.tr('By category'),"Search/VMSearchByCategory.qml",0,'qrc:///Images/categories.png')
		//menuList.append(enguia.tr('Nearby'),MData.PageTypeFunSearchNearBy,'qrc:/Images/nearby.png')
		menuList.append(enguia.tr('By address'),"Search/VMSearchByAddress.qml",0,'qrc:///Images/address.png')
		menuList.append(enguia.tr('By price'),"Search/VMSearchByPrice.qml",0,'qrc:///Images/money.png')
		menuList.append(enguia.tr('By date'),"Search/VMSearchByDate.qml",0,'qrc:///Images/bydate.png')
		menuList.append(enguia.tr('By age'),"Search/VMSearchByAge.qml",0,'qrc:///Images/byage.png')
		menuList.append(enguia.tr('By user'),"Search/VMSearchByUser.qml",0,'qrc:///Images/searchByUser.png')
    }
}



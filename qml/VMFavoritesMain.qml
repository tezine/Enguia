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
		title: enguia.tr("Favorites")
        btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolMenu.left
		VMToolButton{
			id: toolMenu
			source: "qrc:///SharedImages/overflow.png"
			anchors.right: parent.right
			onSigClicked: menu.popup();
		}
    }
    TabView{
        id: tab
        anchors{top: pageTitle.bottom;bottom: parent.bottom}
        width: parent.width
        style: tabViewStyleAndroid
        Tab {
            id: tabList
			title: enguia.tr("List")
			VMFavorites{
                id: tabFavoritesList
            }
        }
        Tab {
            id: tabGroup
			title: enguia.tr("Categories")
			VMFavoritesGrouped{
                id: tabFavoritesGrouped
            }
        }
    }
	Menu{
		id: menu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileFavorites);
		}
	}
}



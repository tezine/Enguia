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
    id: vTopWindow

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Qualifications")
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
        id: tabView
        anchors{top: pageTitle.bottom;bottom: parent.bottom}
        width: parent.width
        style: tabViewStyleAndroid
        Tab{
			title:enguia.tr("Received")
			VMQualificationsReceived{
                id: tabReceived
            }
        }
        Tab{
			title:enguia.tr("Sent")
			VMQualificationsSent{
                id: tabSent
            }
        }
		Tab{
			id:pending
			title:enguia.tr("Pending")
			VMQualificationsPending{
			}
		}
	}
	Menu{
		id: menu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileQualifications);
		}
	}
	Stack.onStatusChanged: {//necessário para atualizar a lista depois de qualificar um ponto
		if(Stack.status===Stack.Activating){
			if(tabView.currentIndex==2){
				var tabPending=tabView.getTab(2).item;
				if(tabPending)tabPending.refresh();
				var tabSent=tabView.getTab(1).item;
				if(tabSent)tabSent.refresh();
			}
		}
	}
	Component.onCompleted: {
		if(enguia.isDesktop()){
			pending.enabled=false;
		}
	}
}


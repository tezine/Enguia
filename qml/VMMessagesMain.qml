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
import "qrc:/"

Rectangle{
    id: topWindow

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Messages")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
        VMToolButton{
            id: toolAdd
            source: "qrc:///Images/add.png"
			anchors.right: toolMenu.left
			onSigClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Messages/VMMessagesEdit.qml"),destroyOnPop:true,immediate:true})
        }
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
			title:enguia.tr("Received");
			VMMessagesReceived{
			}
        }
        Tab{
			title:enguia.tr("Sent");
			VMMessagesSent{
			}
        }
    }
	Menu{
		id: menu
		MenuItem{
			text: enguia.tr("Search")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///Messages/VMMessagesSearch.qml"),destroyOnPop:true, immediate:true})
		}
		MenuItem{
			text: enguia.tr("Mark all as read")
			onTriggered: markAllAsRead();
		}
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileMessages);
		}
	}
    Stack.onStatusChanged: {
        if(Stack.status===Stack.Activating){
            var receivedTab=tabView.getTab(0).item;
			receivedTab.listView.clearBackColor();
			var sentTab=tabView.getTab(1).item;
			if(sentTab)sentTab.refresh();//required to update the messages after sending
        }
    }
	function markAllAsRead(){
		mSVC.metaInvoke(MSDefines.SUserMessages,"MarkAllAsRead",function(ok){
			statusBar.displayResult(ok,enguia.tr("Messages marked as read"),enguia.tr("Unable to mark messages as read"));
			if(ok){//let's refresh all msgs
				var receivedTab=tabView.getTab(0).item;
				receivedTab.clear();
				receivedTab.refresh();
			}
		},mShared.userID);
	}
}


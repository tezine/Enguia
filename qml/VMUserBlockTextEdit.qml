import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockText"
import "qrc:/"

Rectangle {
	property int blockID:0
	property var eUserBlockText: enguia.createEntity("EUserBlockText")

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Text block")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
		VMToolButton{
			id: toolAdd
			source: "qrc:///Images/save.png"
			anchors.right: toolMenu.left
			onSigClicked: save();
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
		anchors{top:pageTitle.bottom; bottom:parent.bottom; left:parent.left; right:parent.right;}
		style: tabViewStyleAndroid
		Tab{
			title:enguia.tr("Main")
			VMUserBlockTextEditGeral{
				id: tabGeral
			}
		}
		Tab{
			title:enguia.tr("Options")
			VMUserBlockTextEditConfig{
				id: tabConfig
			}
		}
	}
	Menu{
		id: menu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileUserBlockTextEdit);
		}
	}
	function save(){
		var tabGeral=tabView.getTab(0).item;
		if(!tabGeral.saveFields())return;
		var tabConfig=tabView.getTab(1).item;
		if(tabConfig){if(!tabConfig.saveFields())return;}
	}
}

import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockWelcome"
import "qrc:/"

Rectangle {
	property int blockID:0
	property var eUserBlockWelcome: enguia.createEntity("EUserBlockWelcome")

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Welcome block")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		z:10
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolAdd
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/save.png"
				onSigClicked: save();
			}
			VMToolButton{
				id: toolMenu
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///SharedImages/overflow.png"
				onSigClicked: menu.popup();
			}
		}
	}
	TabView{
		id: tabView
		anchors{top:pageTitle.bottom; bottom:parent.bottom; left:parent.left; right:parent.right;}
		style: tabViewStyleAndroid		
		Tab{
			title:enguia.tr("Main")
			VMUserBlockWelcomeEditGeral{
				id: tabGeral
			}
		}
		Tab{
			title:enguia.tr("Options")
			VMUserBlockWelcomeEditConfig{
				id: tabConfig
			}
		}
	}
	Menu{
		id: menu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileUserBlockWelcomeEdit);
		}
	}
	function save(){
		Qt.inputMethod.commit();
		eUserBlockWelcome.id=blockID;
		var tabGeral=tabView.getTab(0).item;
		if(!tabGeral.saveFields())return;
		var tabConfig=tabView.getTab(1).item;
		if(tabConfig){if(!tabConfig.saveFields())return;}
		Qt.inputMethod.hide();
		mSVC.metaInvoke(MSDefines.SUserBlockWelcome,"SaveUserBlockWelcome",function(id){
			statusBar.displayResult(id,enguia.tr("Block saved successfully"),enguia.tr("Unable to save block"));
			if(id>0)mainWindow.popWithoutClear();
		},enguia.convertObjectToJson(eUserBlockWelcome));
	}
}

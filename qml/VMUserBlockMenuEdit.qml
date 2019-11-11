import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockMenu"
import "qrc:/"

Rectangle {
	property int blockID:0
	property var eUserBlockMenu: enguia.createEntity("EUserBlockMenu")

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Menu block")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolSave
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/save.png"
				onSigClicked: save();
				visible: tabView.currentIndex===1
			}
			VMToolButton{
				id: toolAdd
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/add.png"
				onSigClicked: btnAddClicked();
				visible: tabView.currentIndex===0
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
			VMUserBlockMenuEditGeral{
				id: tabGeral
			}
		}
		Tab{
			title:enguia.tr("Options")
			VMUserBlockMenuEditConfig{
				id: tabConfig
			}
		}
	}
	Menu{
		id: menu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileUserBlockMenuEdit);
		}
	}
	function btnAddClicked(){
		mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockMenu/VMUserBlockMenuEditEntry.qml"),immediate:true, destroyOnPop:true, properties:{blockID:blockID,id:0} })
	}
	function save(){		
		Qt.inputMethod.commit();
		var tabGeral=tabView.getTab(0).item;
		if(!tabGeral.saveFields())return;
		var tabConfig=tabView.getTab(1).item;
		if(tabConfig){if(!tabConfig.saveFields())return;}
		Qt.inputMethod.hide();
		mSVC.metaInvoke(MSDefines.SUserBlockMenu,"SaveUserBlockMenu",function(id){
			statusBar.displayResult(id,enguia.tr("Block saved successfully"),enguia.tr("Unable to save block"));
			if(id>0)mainWindow.popWithoutClear();
		},enguia.convertObjectToJson(eUserBlockMenu));
	}
	Stack.onStatusChanged: {
		if(Stack.status!==Stack.Activating)return;
		var tabGeral=tabView.getTab(0).item;
		tabGeral.refresh();
	}
}

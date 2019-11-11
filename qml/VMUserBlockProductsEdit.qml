import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockProducts"
import "qrc:/"

Rectangle {
	property int blockID:0
	property var eUserBlockProducts: enguia.createEntity("EUserBlockProducts")

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Products")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		z:10
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolSave
				source: "qrc:///Images/save.png"
				Layout.fillHeight: true
				Layout.preferredWidth: height
				onSigClicked: save();
				visible: tabView.currentIndex!==0 && tabView.currentIndex!==1
			}
			VMToolButton{
				id: toolAdd
				source: "qrc:///Images/add.png"
				Layout.fillHeight: true
				Layout.preferredWidth: height
				onSigClicked: tabView.getTab(tabView.currentIndex).item.btnAddClicked();
				visible: tabView.currentIndex===0 || tabView.currentIndex===1
			}
			VMToolButton{
				id: toolMenu
				source: "qrc:///SharedImages/overflow.png"
				Layout.fillHeight: true
				Layout.preferredWidth: height
				onSigClicked: menu.popup();
			}
		}
	}
	TabView{
		id: tabView
		anchors{top:pageTitle.bottom; bottom:parent.bottom; left:parent.left; right:parent.right;}
		style: tabViewStyleAndroid
		Tab{
			title:enguia.tr("Products")
			VMUserBlockProductsEditGeral{
				id: tabGeral
			}
		}
		Tab{
			title:enguia.tr("Categories")
			VMUserBlockProductsEditCategories{
				id: tabCategories
			}
		}
		Tab{
			title:enguia.tr("Payment")
			VMUserBlockProductsEditPayment{
				id: tabPayment
			}
		}
		Tab{
			title:enguia.tr("Options")
			VMUserBlockProductsEditConfig{
				id: tabConfig
			}
		}
	}
	Menu{
		id: menu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileUserBlockProductsEdit);
		}
	}
	function save(){
		Qt.inputMethod.commit();
		var tabProducts=tabView.getTab(0).item;
		if(!tabProducts.saveFields())return;
		var tabCategories=tabView.getTab(1).item;
		if(tabCategories && (!tabCategories.saveFields()))return;
		var tabPayment=tabView.getTab(2).item;
		if(tabPayment && (!tabPayment.saveFields()))return;
		var tabConfig=tabView.getTab(3).item;
		if(tabConfig){if(!tabConfig.saveFields())return;}
		Qt.inputMethod.hide();
		mSVC.metaInvoke(MSDefines.SUserBlockProducts,"SaveUserBlockProducts",function(id){
			statusBar.displayResult(id,enguia.tr("Block saved successfully"),enguia.tr("Unable to save block"));
			if(id>0)mainWindow.popWithoutClear();
		},enguia.convertObjectToJson(eUserBlockProducts));
	}
	Stack.onStatusChanged: {
		if(Stack.status!==Stack.Activating)return;
		switch(tabView.currentIndex){
			case 0://products
				tabView.getTab(tabView.currentIndex).item.refresh();
				break;
			case 1://categories
				tabView.getTab(tabView.currentIndex).item.refresh();
				break;
		}
	}
	Component.onCompleted: {
		mSVC.metaInvoke(MSDefines.SUserBlockProducts,"GetUserBlockProductsByID",function(e){
			enguia.copyValues(e,eUserBlockProducts)
		},blockID)
	}
}

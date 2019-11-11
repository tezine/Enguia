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
	color: enguia.backColor
	property int productID:0
	property var eUserProduct: enguia.createEntity("EUserProduct")

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Product")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolAdd
				source: "qrc:///Images/add.png"
				Layout.fillHeight: true
				Layout.preferredWidth: height
				onSigClicked: tabView.getTab(tabView.currentIndex).item.btnAddClicked();
				visible: tabView.currentIndex===2|| tabView.currentIndex===3 || tabView.currentIndex===4
			}
			VMToolButton{
				id: toolSave
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/save.png"
				onSigClicked: save();
			}
		}
	}
	TabView{
		id: tabView
		anchors{top:pageTitle.bottom; bottom:parent.bottom; left:parent.left; right:parent.right;}
		style: tabViewStyleAndroid
		onCurrentIndexChanged: {
			//if(currentIndex===0 || currentIndex===1)titlebar.removeVisible=true;//para contornar bug
			//else titlebar.removeVisible=false;
		}
		Tab{
			title:enguia.tr("Main")
			VMUserBlockProductsEditEntryMain{
				id: tabMain
			}
		}
		Tab{
			title: enguia.tr("Description")
			VMUserBlockProductsEditEntryDescription{
				id: tabDescription
			}
		}
		Tab{
			id: tabOptions1
			title:enguia.tr("Options")+ " 1"
			VMUserBlockProductsEditEntryOptions{
				level:1
			}
		}
		Tab{
			title:enguia.tr("Options")+ " 2"
			VMUserBlockProductsEditEntryOptions{
				level:2
			}
		}
		/*Tab{
			title:enguia.tr("Options")+ " 3"
			VMUserBlockProductsEditEntryOptions{
				level:3
			}
		}*/
		Tab{
			title:enguia.tr("Add-ons")
			VMUserBlockProductsEditEntryAddons{
				id: tabAddons
			}
		}
	}
	function save(){
		var tabMain=tabView.getTab(0).item;
		var tabDescription=tabView.getTab(1).item;
		var tabOptions1=tabView.getTab(2).item;
		var tabOptions2=tabView.getTab(3).item;
		var tabAddons=tabView.getTab(4).item;
		if(!tabMain.saveFields())return;
		if(tabDescription && (!tabDescription.saveFields()))return;
		if(tabOptions1 && (!tabOptions1.saveFields()))return;
		if(tabOptions2 && (!tabOptions2.saveFields()))return;
		if(tabAddons &&(!tabAddons.saveFields()))return;
		mSVC.metaInvoke(MSDefines.SUserProducts,"SaveUserProduct",function(id){
			statusBar.displayResult(id,enguia.tr("Product saved successfully"),enguia.tr("Unable to save product"));
			if(id>0)mainWindow.popWithoutClear();
		},enguia.convertObjectToJson(eUserProduct),mSFiles.getPictureBase64(tabMain.completeLocalPicturePath));
	}
	Stack.onStatusChanged: {
		if(Stack.status!==Stack.Activating)return;
		switch(tabView.currentIndex){
			case 2://options 1
				tabView.getTab(tabView.currentIndex).item.refresh();
				break;
			case 3://options 2
				tabView.getTab(tabView.currentIndex).item.refresh();
				break;
			case 4://addons
				tabView.getTab(tabView.currentIndex).item.refresh();
				break;
		}
	}
}


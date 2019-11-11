import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/UserBlockProducts"

Rectangle {
	color: enguia.backColor

	Flickable {
		id: flickable
		clip: true
		width: parent.width;
		height: parent.height
		contentWidth: parent.width
		contentHeight: grid.height+enguia.height*0.02+enguia.mediumMargin
		ExclusiveGroup { id: sellGroup }
		ColumnLayout{
			id: grid
			anchors{left:parent.left;right:parent.right;top:parent.top;}
			anchors.margins: enguia.smallMargin
			spacing: 0
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Name")
			}
			VMTextField{
				id: txtName
				maximumLength: 50
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Visibility")
			}
			VMButton{
				id: btnVisibility
				Layout.fillWidth: true
				onClicked: visibilityDlg.open();
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Currency")
			}
			VMComboBox{
				id: comboCurrency
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VMCheckBox{
				id: checkDisplayImg
				text:enguia.tr("Display image")+"."
			}
			VMCheckBox{
				id: checkDisplayPrice
				text:enguia.tr("Display price")+"."
			}
			VMCheckBox{
				id: checkCollectAndDeliver
				text:enguia.tr("Collect and deliver")+"."
				onCheckedStateChanged: setCollectAndDeliver(checked)
			}
			ColumnLayout{
				id: gridCollect
				Layout.fillWidth: true
				height: txtCollect.height+lblMin.height
				visible: checkCollectAndDeliver.checked
				spacing: 0
				VSharedLabelRectCompact{
					id: lblMin
					Layout.fillWidth: true
					text:enguia.tr("Minimum days to deliver")
				}
				VMTextField{
					id:txtCollect
					Layout.fillWidth: true
				}
			}
			VMCheckBox{
				id: checkSellProducts
				text: enguia.tr("Sell products")+"."
				onCheckedChanged: {
					if(checked)checkDeliverProducts.enabled=true;
					else {
						checkDeliverProducts.checked=false;
						checkDeliverProducts.enabled=false;
					}
				}
			}
			VMCheckBox{
				id: checkAcceptExternalOrderWhenClosed
				text: enguia.tr("Accept External Order when closed")+"."
				visible: checkSellProducts.checked
			}
			VMCheckBox{
				id: checkDeliverProducts
				text: enguia.tr("Deliver products")+"."
				visible: checkSellProducts.checked
			}
			ColumnLayout{
				id: gridDelivery
				Layout.fillWidth: true
				height: txtDeliverTax.height+labelDeliverTax.height
				visible: checkDeliverProducts.checked
				spacing: 0
				VSharedLabelRectCompact{
					id: labelDeliverTax
					Layout.fillWidth: true
					text: enguia.tr("Delivery rate")+":"
				}
				VMTextField{
					id:txtDeliverTax
					Layout.fillWidth: true
				}
			}
		}
	}
	VMUserBlockVisibilityDlg{
		id: visibilityDlg
		onSigItemsSelected: {
			eUserBlockProducts.visibility=0;
			for(var i=0;i<selectedList.length;i++){
				var item=selectedList[i];
				if(item.id === MSDefines.BlockVisibilityMyself)eUserBlockProducts.visibility|=MSDefines.BlockVisibilityMyself;
				else if(item.id === MSDefines.BlockVisibilityBestFriends)eUserBlockProducts.visibility|=MSDefines.BlockVisibilityBestFriends;
				else if(item.id === MSDefines.BlockVisibilityFamily)eUserBlockProducts.visibility|=MSDefines.BlockVisibilityFamily;
				else if(item.id === MSDefines.BlockVisibilityFellowWorker)eUserBlockProducts.visibility|=MSDefines.BlockVisibilityFellowWorker;
				else if(item.id === MSDefines.BlockVisibilityFriends)eUserBlockProducts.visibility|=MSDefines.BlockVisibilityFriends;
				else if(item.id === MSDefines.BlockVisibilityOthers)eUserBlockProducts.visibility|=MSDefines.BlockVisibilityOthers;
			}
			btnVisibility.text=mMobile.getVisibilityName(eUserBlockProducts.visibility);
		}
	}
	function setCollectAndDeliver(collectAndDeliver){
		checkSellProducts.visible=!collectAndDeliver;
		checkDeliverProducts.visible=!collectAndDeliver
	}
	function saveFields(){
		var minimumDeliverDays=parseInt(txtCollect.text);
		if(checkCollectAndDeliver.checked  && isNaN(minimumDeliverDays)){statusBar.displayError(enguia.tr("Minimum days invalid"));return false;}
		eUserBlockProducts.name=txtName.text;
		eUserBlockProducts.displayImg=checkDisplayImg.checked
		eUserBlockProducts.displayPrice=checkDisplayPrice.checked
		eUserBlockProducts.sellProducts=checkSellProducts.checked
		eUserBlockProducts.acceptExternalOrderWhenClosed=checkAcceptExternalOrderWhenClosed.checked;
		eUserBlockProducts.deliverProducts=checkDeliverProducts.checked;
		eUserBlockProducts.deliveryTax=parseFloat(txtDeliverTax.text);
		eUserBlockProducts.currencyType=comboCurrency.getSelected();
		eUserBlockProducts.collectAndDeliver=checkCollectAndDeliver.checked;
		if(checkCollectAndDeliver.checked){
			eUserBlockProducts.minimumDeliverDays=minimumDeliverDays
			eUserBlockProducts.sellProducts=true;
			eUserBlockProducts.acceptExternalOrderWhenClosed=true;
		}
		return true;
	}
	Component.onCompleted: {
		txtName.text=eUserBlockProducts.name;
		btnVisibility.text=mMobile.getVisibilityName(eUserBlockProducts.visibility);
		comboCurrency.append(MSDefines.CurrencyTypeDollar,"US Dollar")
		comboCurrency.append(MSDefines.CurrencyTypeEuro,"Euro")
		comboCurrency.append(MSDefines.CurrencyTypeLibra,"Libra")
		comboCurrency.append(MSDefines.CurrencyTypeBrazilianReal,"Brazilian Real")
		comboCurrency.select(eUserBlockProducts.currencyType)
		checkDisplayImg.checked=eUserBlockProducts.displayImg;
		checkDisplayPrice.checked=eUserBlockProducts.displayPrice;
		checkSellProducts.checked=eUserBlockProducts.sellProducts
		checkAcceptExternalOrderWhenClosed.checked=eUserBlockProducts.acceptExternalOrderWhenClosed;
		checkDeliverProducts.checked=eUserBlockProducts.deliverProducts;
		checkCollectAndDeliver.checked=eUserBlockProducts.collectAndDeliver;
		if(checkCollectAndDeliver.checked)txtCollect.text=eUserBlockProducts.minimumDeliverDays
		txtDeliverTax.text=eUserBlockProducts.deliveryTax
	}
}


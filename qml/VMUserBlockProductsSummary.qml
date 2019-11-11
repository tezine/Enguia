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
import "qrc:/BlockProducts"
import "qrc:/"


Rectangle {
	property int nextBlockType:0
	property double orderTotal:0//calculated below
	property var eUserBlockProducts:dstore.getValue("eUserBlockProducts");
	property var eUserBlockWelcome:dstore.getValue("eUserBlockWelcome");

	VSharedPageTitle{
		id:pageTitle
		title: enguia.tr("Order summary")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
	}
	VMBlockProductsSummaryList{
		id: summaryList
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom: txtNote.top}
		onSigBtnDeleteClicked: {
			mSOrder.removeProduct(id)
			getOrderSummary();
		}
	}
	VSharedTextField{
		id: txtNote
		placeholderText: enguia.tr("Additional information")
		anchors{left:parent.left;right:parent.right;}
		anchors.bottom: collectRect.visible?collectRect.top: rectTotal.top
	}
	VMBlockProductsCollectRect{
		id:collectRect
		anchors{bottom:rectTotal.top; left:parent.left;right:parent.right;}
		visible: eUserBlockProducts.collectAndDeliver
	}
	Rectangle{
		id: rectTotal
		color:"#3f3f3f"
		anchors{ left:parent.left;right:parent.right;bottom:btnConfirm.top}
		height: parent.height*0.1
		Label{
			id: lblTotal
			color:"white"
			anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter}
			font{pointSize: enguia.imenseFontPointSize;bold:true;}
		}
		Label{
			id: lblDeliveryRate
			font{pointSize: enguia.largeFontPointSize}
			color:"white"
			visible: false
			anchors{left: lblTotal.left;bottom:lblTotal.top;}
		}
	}
	VSharedButton{
		id: btnConfirm
		text: enguia.tr("Next")+" ("+enguia.tr("Payment")+")"
		anchors{left:parent.left;right:parent.right;bottom:parent.bottom}
		onClicked:btnNextClicked();
	}
	function btnNextClicked(){
		if(eUserBlockProducts.collectAndDeliver){
			var today=new Date();
			var collectDate=enguia.convertToDateOnly(collectRect.collectDate);
			var deliveryDate=enguia.convertToDateOnly(collectRect.deliveryDate);
			if(collectDate <enguia.convertToDateOnly(today)){statusBar.displayError(enguia.tr("Collect date invalid"));return;}
			if(collectDate>deliveryDate){statusBar.displayError(enguia.tr("Delivery date invalid"));return;}
			var minimumDaysToDeliver=eUserBlockProducts.minimumDeliverDays;
			if(enguia.daysTo(collectDate, deliveryDate)<minimumDaysToDeliver){statusBar.displayError(enguia.tr("Minimum days to deliver")+": "+minimumDaysToDeliver.toString());return;}
			if(!enguia.isPlaceOpenOnDay(eUserBlockWelcome,collectDate)){statusBar.displayError(enguia.tr("Place is closed on collect date"));return;}
			if(!enguia.isPlaceOpenOnDay(eUserBlockWelcome,deliveryDate)){statusBar.displayError(enguia.tr("Place is closed on delivery date"));return;}
			dstore.saveValue("collectDate",collectDate);
			dstore.saveValue("deliveryDate",deliveryDate);
			dstore.saveValue("collectPeriod",collectRect.getCollectPeriod());
			dstore.saveValue("deliveryPeriod",collectRect.getDeliveryPeriod());
		}
		mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsPayment.qml"),destroyOnPop:true, immediate:true, properties:{note: txtNote.text,orderTotal:orderTotal }})
	}
	function getOrderSummary(){
		summaryList.reset();
		var list=mSOrder.getProducts();
		if(!list || list.length===0){
			btnConfirm.visible=false;
			rectTotal.visible=false;
			txtNote.visible=false;
			return;
		}
		for(var i=0;i<list.length;i++){
			var eOrderDetail=list[i];
			var img=mSFiles.getUserProductThumbImageUrl(mShared.otherUserID,eOrderDetail.productID);
			orderTotal+=eOrderDetail.totalProductValue;
			summaryList.append(eOrderDetail, img)
		}
		var deliveryRate=eUserBlockProducts.deliveryTax;
		if(deliveryRate>0){
			lblDeliveryRate.visible=true;
			lblDeliveryRate.text=enguia.tr("Delivery rate")+": "+mSOrder.getCurrencySymbol() +deliveryRate;
		}
		orderTotal+=deliveryRate;
		lblTotal.text=enguia.tr("Total")+": "+mSOrder.getCurrencySymbol()+ orderTotal.toString();
	}
	Component.onCompleted: {
		getOrderSummary();
	}
}


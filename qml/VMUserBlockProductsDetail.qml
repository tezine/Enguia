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
import "qrc:/mobilefunctions.js" as MobileFunctions

Rectangle {
	id:topWindow
	property alias name: pageTitle.title
	property int productID:0
	property bool displayImg:false
	property var eUserProduct: enguia.createEntity("EUserProduct")

	VMPageTitle{
		id:pageTitle
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: btnSave
				visible: false
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/btnok.png"
				onSigClicked: save();
			}
		}
	}
	VSBusyIndicator{
		id: imgProgress
		anchors{top:pageTitle.bottom;horizontalCenter: parent.horizontalCenter;}
		height:parent.height*0.3
		width: parent.height*0.3
		running: true
		visible: displayImg
	}
	Image{
		id: productImg
		anchors{top:pageTitle.bottom;left:parent.left;right:parent.right;}
		height: enguia.height*0.3
		fillMode: Image.Stretch
		visible: displayImg
		onStatusChanged: {
			switch(status){
				case Image.Error:
					source="qrc:///SharedImages/pictureunknownbig.jpg"
					break;
				case Image.Ready:
					imgProgress.visible=false
					break;
			}
		}
	}
	VSharedText{
		id: txtArea
		anchors.top: displayImg?productImg.bottom: pageTitle.bottom;
		anchors{left:parent.left;right:parent.right;bottom:columnLayout.top}
	}
	ColumnLayout{
		id: columnLayout
		anchors{left:parent.left;leftMargin: enguia.mediumMargin;right:parent.right;rightMargin: enguia.mediumMargin;bottom:parent.bottom;bottomMargin: enguia.mediumMargin}
		VMBlockProductsAmountSelection{
			id: amountSelection
			visible: true
			Layout.fillWidth: true
			onSigAmountSelected: checkSaveButton()
		}
		VMBlockProductsOptionSelection{
			id: option1Selection
			visible: false;
			Layout.fillWidth: true
			onSigSelected: checkSaveButton();
		}
		VMBlockProductsOptionSelection{
			id: option2Selection
			visible: false;
			Layout.fillWidth: true
			onSigSelected: checkSaveButton()
		}
		VMBlockProductsAddonSelection{
			id: addOnSelection
			visible: false
			Layout.fillWidth: true
		}
	}
	MouseArea{
		anchors.fill: topWindow
		propagateComposedEvents: true
		z: 1000000000
		onPressed: {
			enguia.closeDialogs(topWindow)
			mouse.accepted = false;
		}
	}
	VMListEmptyRect{
		id: loadingRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	VMRectMsg{
		id: placeClosedRect
		visible: false
		anchors{left:parent.left; right:parent.right; bottom:parent.bottom;}
		height:enguia.height*0.1
		z: 20
	}
	function getProduct(productID){
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserProducts,"GetUserProductByID",function(e){
			loadingRect.visible=false;
			enguia.copyValues(e,eUserProduct)
			productImg.source=mSFiles.getUserProductImageUrl(mShared.otherUserID,productID)
			txtArea.setText(e.description)
			if(e.option1Name.length>0){
				option1Selection.visible=true;
				option1Selection.setup(1,e.option1Name+":", productID,true);
			}
			if(e.option2Name.length>0){
				option2Selection.visible=true;
				option2Selection.setup(2,e.option2Name+":", productID,true);
			}
			if(e.addOnName.length>0){
				addOnSelection.visible=true;
				addOnSelection.setup(e.addOnName+":", productID,true);
			}
		},productID);
	}
	function checkSaveButton(){
		var amount=parseInt(amountSelection.amount);
		var option1Visible=option1Selection.visible;
		var option2Visible=option2Selection.visible;
		if(amount>0 && (!option1Visible) && (!option2Visible))btnSave.visible=true;
		else if(amount>0 && (option1Visible && option1Selection.selectedID>0) && (!option2Visible))btnSave.visible=true;
		else if(amount>0 && (option1Visible && option1Selection.selectedID>0) && (option2Visible && option2Selection.selectedID>0))btnSave.visible=true;
		else btnSave.visible=false;
	}
	function save(){
		var eOrderDetail=enguia.createEntity("EOrderDetail");
		eOrderDetail.productName=eUserProduct.name;
		eOrderDetail.productID=eUserProduct.id;
		eOrderDetail.amount=parseInt(amountSelection.amount);
		eOrderDetail.option1ID=option1Selection.selectedID;
		eOrderDetail.option2ID=option2Selection.selectedID;
		eOrderDetail.option3ID=0;//not used
		eOrderDetail.addOnsList=addOnSelection.selectedIDs.join(",");
		eOrderDetail.option1=option1Selection.getSelectedOption();
		eOrderDetail.option2=option2Selection.getSelectedOption();
		eOrderDetail.option3=""
		eOrderDetail.addOnsNames=addOnSelection.getSelectedAddonsNames();
		eOrderDetail.unitValue=mSOrder.getUnitValue(eUserProduct.price,option1Selection.selectedPrice, option2Selection.selectedPrice, 0, addOnSelection.addOnsPrice)
		eOrderDetail.totalProductValue=eOrderDetail.amount*eOrderDetail.unitValue;
		mSOrder.updateOrder(eOrderDetail);
		mainWindow.popOneLevel();
	}
	Component.onCompleted: {
		getProduct(productID)
		var eUserBlockProducts=MobileFunctions.eUserBlockProducts;
		if(!eUserBlockProducts.sellProducts)columnLayout.visible=false;
		console.debug("status:",MobileFunctions.userBlockWelcomeOpenStatus, eUserBlockProducts.sellProducts, eUserBlockProducts.acceptExternalOrderWhenClosed);
		if((MobileFunctions.userBlockWelcomeOpenStatus!==MSDefines.OpenStatusOpen)&& eUserBlockProducts.sellProducts  && (eUserBlockProducts.acceptExternalOrderWhenClosed===false)){
			placeClosedRect.displayError(enguia.tr("Place closed. Order not allowed"))
			columnLayout.visible=false;
		}
	}
}


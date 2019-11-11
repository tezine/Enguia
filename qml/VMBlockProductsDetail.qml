import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"

Rectangle {
	id:topWindow
    property alias name: pageTitle.title
    property int productID:0
	property bool displayImg:false
	property var eProduct:enguia.createEntity("EProduct")

	VMPageTitle{
        id:pageTitle
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: btnSave.visible?btnSave.left:pageTitle.right
		VSharedToolButton{
			id: btnSave
			visible: false
			anchors{right:parent.right}
			source: "qrc:///Images/btnok.png"
			onSigClicked: {
				var eOrderDetail=enguia.createEntity("EOrderDetail");
				eOrderDetail.productName=eProduct.name;
				eOrderDetail.productID=eProduct.id;
				eOrderDetail.amount=parseInt(amountSelection.amount);
				eOrderDetail.option1ID=option1Selection.selectedID;
				eOrderDetail.option2ID=option2Selection.selectedID;
				eOrderDetail.option3ID=option3Selection.selectedID;
				eOrderDetail.addOnsList=addOnSelection.selectedIDs.join(",");
				eOrderDetail.option1=option1Selection.getSelectedOption();
				eOrderDetail.option2=option2Selection.getSelectedOption();
				eOrderDetail.option3=option3Selection.getSelectedOption();
				eOrderDetail.addOnsNames=addOnSelection.getSelectedAddonsNames();
				eOrderDetail.unitValue=mSOrder.getUnitValue(eProduct.price,option1Selection.selectedPrice, option2Selection.selectedPrice, option3Selection.selectedPrice, addOnSelection.addOnsPrice)
				eOrderDetail.totalProductValue=eOrderDetail.amount*eOrderDetail.unitValue;
				mSOrder.updateOrder(eOrderDetail);
				mainWindow.popOneLevel();
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
		onStatusChanged: if(status===Image.Ready)imgProgress.visible=false
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
		VMBlockProductsOptionSelection{
			id: option3Selection
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
		id: emptyRect
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
		emptyRect.visible=true;
		mSVC.metaInvoke(MSDefines.SPlaceProducts,"GetByID",function(e){
			emptyRect.visible=false;
			enguia.copyValues(e,eProduct)
            productImg.source=mSFiles.getProductImageUrl(mShared.placeID,productID)
            txtArea.setText(e.description)
			if(e.option1Name.length>0){
				option1Selection.visible=true;
				option1Selection.setup(1,e.option1Name+":", productID,false);
			}
			if(e.option2Name.length>0){
				option2Selection.visible=true;
				option2Selection.setup(2,e.option2Name+":", productID,false);
			}
			if(e.option3Name.length>0){
				option3Selection.visible=true;
				option3Selection.setup(3,e.option3Name+":",productID,false)
			}
			if(e.addOnName.length>0){
				addOnSelection.visible=true;
				addOnSelection.setup(e.addOnName+":", productID,false);
			}
		},productID);
    }
	function checkSaveButton(){
		var amount=parseInt(amountSelection.amount);
		var option1Visible=option1Selection.visible;
		var option2Visible=option2Selection.visible;
		var option3Visible=option3Selection.visible;
		if(amount>0 && (!option1Visible) && (!option2Visible) && (!option3Visible))btnSave.visible=true;
		else if(amount>0 && (option1Visible && option1Selection.selectedID>0) && (!option2Visible) && (!option3Visible))btnSave.visible=true;
		else if(amount>0 && (option1Visible && option1Selection.selectedID>0) && (option2Visible && option2Selection.selectedID>0) && (!option3Visible))btnSave.visible=true;
		else if(amount>0 && (option1Visible && option1Selection.selectedID>0) && (option2Visible && option2Selection.selectedID>0) && (option3Visible && option3Selection.selectedID>0) )btnSave.visible=true;
		else btnSave.visible=false;
	}
    Component.onCompleted: {
        getProduct(productID)
		if(!mFlow.getSellProducts())columnLayout.visible=false;
		if((mFlow.getPlaceOpenStatus()!==MSDefines.OpenStatusOpen)&& mFlow.getSellProducts()  && (mFlow.getAcceptExternalOrderWhenClosed()===false)){
			placeClosedRect.displayError(enguia.tr("Place closed. Order not allowed"))
			columnLayout.visible=false;
		}
    }
}

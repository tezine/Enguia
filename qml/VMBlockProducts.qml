import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"
import "qrc:/mobilefunctions.js" as MobileFunctions

Rectangle {
	id:topWindow
	property var erBlockProducts: enguia.createEntity("ERBlockProducts2");
    property int nextBlockType:0
    property bool sellProducts:false
	property double deliveryRate:0
	property bool displayImg:false
	property int blockID:0
	property int currentCategoryID:0
	property bool containsCategoriesInternal:false
	property bool containsCategoriesExternal:false

    VSharedPageTitle{
        id:pageTitle
		title:enguia.tr("Products")
        btnBackVisible:true
		onSigBtnBackClicked: btnBackClicked();
		VMToolButton{
			id: btnSearch
			source: "qrc:///SharedImages/search.png"
			anchors.right: parent.right
			visible: orderTypeRect.visible?false:true
			onSigClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockProducts/VMBlockProductsSearch.qml"),destroyOnPop:true, immediate:true, properties:{displayImg:displayImg}})
		}
	}
	VMBlockProductsOrderTypeRect{//internal order or external order
		id:orderTypeRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;}
		visible: false
		onListItemClicked: {
			visible=false;
			mSOrder.setOrderType(orderType)
			switch(orderType){
				case MSDefines.OrderTypeInternal:
					if(containsCategoriesInternal)getCategories(orderType);
					else getProducts(orderType)
					break;
				case MSDefines.OrderTypeExternal:
					if(containsCategoriesExternal)getCategories(orderType);
					else getProducts(orderType)
					break;
			}
		}
	}
	ColumnLayout{
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		VMBlockProductsCategoriesList{
			id: categoryList
			visible: ((!productsList.visible) && (!orderTypeRect.visible))?true:false
			Layout.fillWidth: true
			Layout.fillHeight: true
			onListItemClicked: {
				currentCategoryID=id;
				visible=false
				getProductsInCategory(id)
			}
		}
		VMBlockProductsSelectionList{
			id:productsList
			visible: ((!categoryList.visible) && (!orderTypeRect.visible))?true:false
			Layout.fillWidth: true
			Layout.fillHeight: true
			onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockProducts/VMBlockProductsDetail.qml"),destroyOnPop:true, immediate:true, properties:{name:productName, productID:id, displayImg:displayImg}})
			onSigEndOfListReached: getProductsInCategory(currentCategoryID)
		}
		VSharedButton{
			id: btnMyBasket
			Layout.fillWidth: true
			visible: (!mSOrder.isBasketEmpty)
			text: enguia.tr("My Basket")
			onClicked: {
				if(sellProducts)mainStack.push({item:Qt.resolvedUrl("qrc:///BlockProducts/VMBlockProductsSummary.qml"),destroyOnPop:true, immediate:true, properties:{nextBlockType:nextBlockType} })
				else mainStack.push({item:Qt.resolvedUrl(mSBlocks.getUrlFromPageType(nextBlockType)),destroyOnPop:true, immediate:true })
			}
		}
	}
	VMListEmptyRect{
		id: emptyRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	Keys.onPressed:  {//call forceActiveFocus on completed
		if(event.key!==Qt.Key_Back)return;
		event.accepted = true;
		btnBackClicked()
	}
	function btnBackClicked(){
		if((containsCategoriesExternal || containsCategoriesInternal) && (!categoryList.visible)){categoryList.visible=true;productsList.visible=false;}
		else mainWindow.popOneLevel();
	}
	function getProductsInCategory(categoryID){
		productsList.clear();
		productsList.visible=true;
		emptyRect.visible=true;
		mSVC.metaInvoke(MSDefines.SPlaceProducts,"GetProductsInCategory",function(list){
			emptyRect.visible=false;
			if(list.length>=0)productsList.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eProduct=list[i];				
				var img=mSFiles.getProductThumbImageUrl(mShared.placeID,eProduct.id);
				if(!displayImg)img="";
				productsList.append(eProduct.name,eProduct.brief, eProduct.price,img.toString(),eProduct.id);
			}
		},categoryID,enguia.listCount,productsList.pageNumber)
	}
	function getProducts(orderType){
		productsList.clear();
		productsList.visible=true;
		emptyRect.visible=true;
		mSVC.metaInvoke(MSDefines.SPlaceProducts,"GetProducts",function(list){
			emptyRect.visible=false;
			for(var i=0;i<list.length;i++){
				var product=list[i];
				var img=mSFiles.getProductThumbImageUrl(mShared.placeID,product.id);
				productsList.append(product.name,product.brief, product.price,img.toString(),product.id);
			}
		},mShared.placeID);
	}	
	function getCategories(orderType){
		emptyRect.visible=true;
		categoryList.visible=true;
		mSVC.metaInvoke(MSDefines.SPlaceProductsCategories, "GetCategories",function(list){
			emptyRect.visible=false;
			for(var i=0;i<list.length;i++){
				var ePlaceProductCategory=list[i];
				categoryList.append(ePlaceProductCategory.name, ePlaceProductCategory.id,"")
			}
		},mShared.placeID,true,orderType);
	}
	function setVariables(erBlockProducts2){//onCompleted only
		mSOrder.setCurrencySymbol(erBlockProducts2.currencyType);
		mSOrder.setPaymentTypes(erBlockProducts2.paymentTypes);
		mSOrder.setCreditCardTypes(erBlockProducts2.creditCardTypes);
		mFlow.setAcceptExternalOrderWhenClosed(erBlockProducts2.acceptExternalOrderWhenClosed);
		mFlow.setSellProducts(erBlockProducts2.sellProducts);
		nextBlockType=erBlockProducts2.nextBlockType
		sellProducts=erBlockProducts2.sellProducts
		displayImg=erBlockProducts2.displayImg;
		containsCategoriesExternal=erBlockProducts2.containsCategoriesExternal;
		containsCategoriesInternal=erBlockProducts2.containsCategoriesInternal;
	}
	function configureOrderType(erBlockProducts2){//onCompleted only
		var orderType=0;
		if(erBlockProducts2.internalOrder && erBlockProducts2.externalOrder)orderType=MSDefines.OrderTypeExternalAndInternal;
		else if(erBlockProducts2.internalOrder && (!erBlockProducts2.externalOrder))orderType=MSDefines.OrderTypeInternal;
		else if(erBlockProducts2.externalOrder && (!erBlockProducts2.internalOrder))orderType=MSDefines.OrderTypeExternal;
		mSOrder.setOrderType(orderType);
		switch(orderType){
			case MSDefines.OrderTypeExternalAndInternal:
				orderTypeRect.visible=true;
				return;
			case MSDefines.OrderTypeInternal:
				orderTypeRect.visible=true;
				orderTypeRect.hideExternalOrder();
				return;
			default://we call this for external or if doesn't allow order
				if(containsCategoriesExternal)getCategories(orderType);
				else getProducts(orderType);
				return;
		}
	}
    Component.onCompleted: {
		mSOrder.clear();
		topWindow.forceActiveFocus();//required or we don't get key pressed
		mSVC.metaInvoke(MSDefines.SBlockProducts,"GetRuntimeBlock2",function(erBlockProducts2){
			enguia.copyValues(erBlockProducts2,topWindow.erBlockProducts);
			dstore.saveValue("erblockproducts2",erBlockProducts);
			setVariables(erBlockProducts2);
			if(erBlockProducts2.deliverProducts){
				mSOrder.setDeliveryRate(erBlockProducts2.deliveryTax);
				if(erBlockProducts2.deliveryTax>0)pageTitle.subtitle=enguia.tr("Delivery rate")+": "+mSOrder.getCurrencySymbol()+ erBlockProducts2.deliveryTax.toString();
			}
			configureOrderType(erBlockProducts2);
		},mShared.placeID);
    }    
}

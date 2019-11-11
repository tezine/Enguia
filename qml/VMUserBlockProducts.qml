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
	id:top
	property int blockID:0
	property int currentCategoryID:0
	property bool displayImg:false
	property var eUserBlockProducts: enguia.createEntity("EUserBlockProducts");

	VMPageTitle{
		id:pageTitle
		title:enguia.tr("Products")
		btnBackVisible:true
		onSigBtnBackClicked: btnBackClicked();
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			/*VMToolButton{
				id: btnSearch
				source: "qrc:///SharedImages/search.png"
				Layout.fillHeight: true
				Layout.preferredWidth: height
				//onSigClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockProducts/VMBlockProductsSearch.qml"),destroyOnPop:true, immediate:true, properties:{displayImg:displayImg}})
			}*/
		}
	}
	ColumnLayout{
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		VMBlockProductsCategoriesList{
			id: categoryList
			visible: (!productsList.visible)
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
			visible: (!categoryList.visible)
			Layout.fillWidth: true
			Layout.fillHeight: true
			onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsDetail.qml"),destroyOnPop:true, immediate:true, properties:{name:productName, productID:id, displayImg:eUserBlockProducts.displayImg}})
			onSigEndOfListReached: getProductsInCategory(currentCategoryID)
		}
		VSharedButton{
			id: btnMyBasket
			Layout.fillWidth: true
			visible: (!mSOrder.isBasketEmpty)
			text: enguia.tr("My Basket")
			onClicked: {
				if(eUserBlockProducts.sellProducts)mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsSummary.qml"),destroyOnPop:true, immediate:true, properties:{nextBlockType:eUserBlockProducts.nextBlockType} })
				else mainStack.push({item:Qt.resolvedUrl(mSBlocks.getUrlFromUserBlockType(nextBlockType)),destroyOnPop:true, immediate:true })
			}
		}
	}
	VMListEmptyRect{
		id: loadingRect
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
		if(eUserBlockProducts.containsCategoriesExternal && (!categoryList.visible)){categoryList.visible=true;productsList.visible=false;}
		else mainWindow.popOneLevel();
	}
	function getProductsInCategory(categoryID){
		productsList.clear();
		productsList.visible=true;
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserProducts,"GetUserProductsInCategory",function(list){
			loadingRect.visible=false;
			if(list.length>=0)productsList.pageNumber++;
			for(var i=0;i<list.length;i++){
				var eProduct=list[i];
				var img=mSFiles.getUserProductThumbImageUrl(mShared.otherUserID,eProduct.id);
				if(!eUserBlockProducts.displayImg)img="";
				productsList.append(eProduct.name,eProduct.brief, eProduct.price,img.toString(),eProduct.id);
			}
		},categoryID,enguia.listCount,productsList.pageNumber);
	}
	function getCategories(){
		loadingRect.visible=true;
		categoryList.visible=true;
		mSVC.metaInvoke(MSDefines.SUserProductsCategories, "GetUserCategoriesWithProducts",function(list){
			loadingRect.visible=false;
			for(var i=0;i<list.length;i++){
				var eUserProductCategory=list[i];
				categoryList.append(eUserProductCategory.name, eUserProductCategory.id,"")
			}
		},mShared.otherUserID);
	}
	function getProducts(){
		productsList.clear();
		productsList.visible=true;
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserProducts,"GetUserProducts",function(list){
			loadingRect.visible=false;
			for(var i=0;i<list.length;i++){
				var product=list[i];
				var img=mSFiles.getUserProductThumbImageUrl(mShared.otherUserID,product.id);
				productsList.append(product.name,product.brief, product.price,img.toString(),product.id);
			}
		},mShared.otherUserID);
	}
	Component.onCompleted: {
		mSOrder.clear();
		top.forceActiveFocus();//required or we don't get key pressed
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserBlockProducts,"GetRuntimeUserBlockProductsByID",function(e){
			loadingRect.visible=false;
			enguia.copyValues(e, eUserBlockProducts);
			dstore.saveValue("eUserBlockProducts",eUserBlockProducts);
			top.displayImg=eUserBlockProducts.displayImg;//precisa pq é usado na lista
			MobileFunctions.eUserBlockProducts=eUserBlockProducts;
			mSOrder.setCurrencySymbol(eUserBlockProducts.currencyType);
			if(eUserBlockProducts.deliverProducts){
				mSOrder.setDeliveryRate(eUserBlockProducts.deliveryTax);
				if(eUserBlockProducts.deliveryTax>0)pageTitle.subtitle=enguia.tr("Delivery rate")+": "+mSOrder.getCurrencySymbol()+ eUserBlockProducts.deliveryTax.toString();
			}
			if(eUserBlockProducts.containsCategoriesExternal)getCategories();
			else getProducts();
		},blockID);
	}
}


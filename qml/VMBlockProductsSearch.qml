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
	property bool displayImg:false

	VSharedPageTitle{
		id:pageTitle
		title:enguia.tr("Search")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
	}
	ColumnLayout{
		id: columnLayout
		anchors{top: pageTitle.bottom;topMargin: enguia.mediumMargin;left:parent.left; leftMargin: enguia.smallMargin;right:parent.right; rightMargin: enguia.smallMargin;}
		spacing: enguia.smallMargin
		VMTextField{
			id: txtProduct
			Layout.fillWidth:true
			placeholderText: enguia.tr("Product name")
			onAccepted: btnSearchClicked();
		}
		VMButton{
			id: btnSearch
			Layout.alignment: Qt.AlignCenter
			Layout.fillWidth:true
			text:enguia.tr("Search");
			onClicked: btnSearchClicked();
		}
	}
	VMBlockProductsSearchList{
		id: productList
		anchors{left:parent.left;right:parent.right;top:columnLayout.bottom;bottom:parent.bottom;topMargin:enguia.mediumMargin;}
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockProducts/VMBlockProductsDetail.qml"),destroyOnPop:true, immediate:true, properties:{name:productName, productID:id,displayImg:displayImg}})
	}
	function btnSearchClicked(){
		Qt.inputMethod.commit();
		if(txtProduct.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		productList.clear();
		productList.loading=true;
		productList.rectVisible=true;
		Qt.inputMethod.hide();
		searchProduct(txtProduct.text);		
	}
	function searchProduct(txt){
		mSVC.metaInvoke(MSDefines.SPlaceProducts,"SearchProductsByName",function(list){
			if(list.length>0)productList.rectVisible=false;
			productList.loading=false;
			for(var i=0;i<list.length;i++){
				var eProduct=list[i];
				var img=mSFiles.getProductThumbImageUrl(mShared.placeID,eProduct.id);
				productList.append(eProduct.name,eProduct.brief, eProduct.price,img.toString(),eProduct.id);
			}
		},mShared.placeID,txt, -1,0,mSOrder.getOrderType());
	}
}


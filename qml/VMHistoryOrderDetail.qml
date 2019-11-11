import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Events"
import "qrc:/Components"
import "qrc:/Contacts"
import "qrc:/Favorites"
import "qrc:/Messages"
import "qrc:/News"
import "qrc:/Preferences"
import "qrc:/Qualifications"
import "qrc:/Search"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/History"

Rectangle {
	property int orderID:0
	property int visualID:0
	property int placeID:0
	property string name:""
	property var eOrderSummary: enguia.createEntity("EOrderSummary")

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Order detail")
		titleLayout.anchors.right: pageTitle.right
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
	}
	VSharedLabelRect{
		id: rectStatus
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;}
		horizontalAlignment: Text.AlignHCenter
	}
	Rectangle{
		id: rect
		anchors{top:rectStatus.bottom; left:parent.left;right:parent.right;}
        height: columnLayout.height+2*enguia.mediumMargin
		color: enguia.backColor
		ColumnLayout{
			id: columnLayout
            anchors{verticalCenter: parent.verticalCenter; leftMargin: enguia.mediumMargin;rightMargin: enguia.mediumMargin;right: parent.right;left: parent.left}
			VSharedLabel{
				id: lblPlaceName
				font{pointSize: enguia.hugeFontPointSize; bold: true}
				Layout.fillWidth: true;
				color: "#484B4E"
			}
			VSharedLabel{
				id: lblOrderID
				Layout.fillWidth: true;
				text: enguia.tr("Order")+": "+visualID;
				color: "#484B4E"
			}
			VSharedLabel{
				id: lblPlaceAddress
				Layout.fillWidth: true;
				color: "#484B4E"
			}
			VSharedLabel{
				id: lblPlacePhone1
				Layout.fillWidth: true;
				color: "#484B4E"
			}
			VSharedLabel{
				id: lblTotal
				Layout.fillWidth: true;
				color: "#484B4E"
			}
		}
	}
	VSharedLabelRect{
		id: rectComment
		anchors{left:parent.left;right:parent.right;top:rect.bottom;}
		horizontalAlignment: Text.AlignHCenter
		text:enguia.tr("Products")
	}
	VMHistoryOrderDetailList{
		id: orderList
		anchors{left:parent.left;right:parent.right;top:rectComment.bottom;bottom:parent.bottom;}
	}
	VMListEmptyRect{
		id: emptyRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	function getOrderDetail(){
		emptyRect.visible=true;
		mSVC.metaInvoke(MSDefines.SPlaceOrders,"GetOrderSummary",function(summary){
			emptyRect.visible=false;
			var ok=enguia.convertJsonDocToObject(summary,eOrderSummary);
			if(!ok){statusBar.displayError(enguia.tr("Unable to read order summary"));return;}
			var total=eOrderSummary.totalWithoutDelivery+eOrderSummary.deliveryRate;
			if(total>0)lblTotal.text=enguia.tr("Total")+": "+total
			else lblTotal.visible=false;
			var productList=eOrderSummary.getProductListJSValue();
			for(var i=0;i<productList.length;i++){
				var eOrderProduct=productList[i];
				orderList.append(eOrderProduct);
			}
			rectStatus.color=mSOrder.getOrderStatusColor(eOrderSummary.status);
			rectStatus.text= mSOrder.getOrderStatusName(eOrderSummary.status);
		},orderID,false)
	}
	Component.onCompleted: {
		emptyRect.visible=true;
		mSVC.metaInvoke(MSDefines.SPlaces,"GetDetail",function(ePlace){
			emptyRect.visible=false;
			lblPlaceName.text=ePlace.name;
			lblPlaceAddress.text=enguia.tr("Address")+": "+ePlace.address;
			lblPlacePhone1.text=enguia.tr("Phone")+": "+ ePlace.phone1;
			getOrderDetail();
		},placeID)
	}
}


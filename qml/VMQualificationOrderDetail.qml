import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
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
	property string placeName:""	
	property alias comment: lblComment.text
	property var eOrderSummary: enguia.createEntity("EOrderSummary")

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Order detail")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		lblTitle.anchors{right: pageTitle.right;rightMargin: enguia.smallMargin;}
	}
	Rectangle{
		id: rect
		anchors{top:pageTitle.bottom; left:parent.left;right:parent.right;}
        height: columnLayout.height+2*enguia.mediumMargin
		color:enguia.backColor
		ColumnLayout{
			id: columnLayout
            anchors{verticalCenter: parent.verticalCenter;leftMargin: enguia.mediumMargin;rightMargin: enguia.mediumMargin;right: parent.right;left: parent.left}
			VSharedLabel{
				id: lblPlaceName
				font{pointSize: enguia.hugeFontPointSize; bold: true}
				Layout.fillWidth: true;
				color: "#484B4E"
				text: placeName;
			}
			VSharedLabel{
				id: lblComment
				Layout.fillWidth: true;
				wrapMode: Text.Wrap
				color: "#484B4E"
			}
			VSharedLabel{
				id: lblOrderID
				Layout.fillWidth: true;
				text: enguia.tr("Order")+": "+visualID;
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
		anchors{left:parent.left;right:parent.right;top:rectComment.bottom;topMargin:enguia.smallMargin; bottom:parent.bottom;}
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
			var list=eOrderSummary.getProductListJSValue();
			for(var i=0;i<list.length;i++){
				var eOrderProduct=list[i];
				orderList.append(eOrderProduct);
			}
			var total=eOrderSummary.totalWithoutDelivery+eOrderSummary.deliveryRate;
			if(total>0)lblTotal.text=enguia.tr("Total")+": "+total
			else lblTotal.visible=false;
		},orderID,false)
	}
	Component.onCompleted: {
		getOrderDetail();
	}
}


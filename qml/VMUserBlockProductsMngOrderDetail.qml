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
	id:topWindow
	color:"#EAEAEA"
	property int orderID:0
	property int orderClientID:0
	property int orderType:0
	property int visualID:0
	property int orderStatus:0
	property string topLabelsColor: "#484B4E"
	property double orderTotalPrice:0
	property string currencySymbol:""
	property string paymentTypeName:""
	property int clientUserID:0
	property double deliveryRate:0

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Order")+" "+visualID.toString();
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			/*VMToolButton{
				id: toolAdd
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/add.png"
				onSigClicked: btnAddClicked();
				visible: false
			}*/
			VMToolButton{
				id: toolMenu
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///SharedImages/overflow.png"
				onSigClicked: overflowMenu.popup();
			}
		}
	}
	GridLayout{
		id:clientInfo
		anchors{top:pageTitle.bottom;left:parent.left;right:parent.right}
		anchors.margins: enguia.smallMargin;
		columns:2
		VMLabel{
			text:enguia.tr("Client")+":"
			color: topLabelsColor
		}
		VMLabel{
			id: lblClientName
			text:""
			color: topLabelsColor
		}
		VMLabel{
			text:enguia.tr("Address")+":"
			color: topLabelsColor
		}
		VMLabel{
			id: lblHomeAddress
			text:""
			color: topLabelsColor
			Layout.fillWidth: true
			wrapMode: Text.Wrap
		}
		VMLabel{
			text:enguia.tr("Phone")+":"
			color: topLabelsColor
		}
		VMLabel{
			id: lblHomePhone
			text:""
			color: topLabelsColor
		}
		VMLabel{
			text:enguia.tr("Zipcode")+":"
			color: topLabelsColor
		}
		VMLabel{
			id: lblHomePostalCode
			text:""
			color: topLabelsColor
		}
		VMLabel{
			text:enguia.tr("Mobile")+":"
			color: topLabelsColor
		}
		VMLabel{
			id: lblMobilePhone
			text:""
			color: topLabelsColor
		}
		VMLabel{
			text:enguia.tr("Reference")+":"
			color: topLabelsColor
		}
		VMLabel{
			id: lblHomeAddressReference
			text:""
			color: topLabelsColor
			Layout.fillWidth: true
			elide: Text.ElideRight
		}
		VMLabel{
			text:enguia.tr("Email")+":"
			color: topLabelsColor
		}
		VMLabel{
			id: lblEmail
			text:""
			color: topLabelsColor
		}
		VMLabel{
			text:enguia.tr("Note")+":"
			color: topLabelsColor
		}
		VMLabel{
			id: lblObs
			text:""
			color: topLabelsColor
			Layout.fillWidth: true
			elide: Text.ElideRight
		}
		VMLabel{
			id: lblQualification
			text:enguia.tr("Qualification")+":"
			color: topLabelsColor
		}
		VSharedRatingIndicator{
			id: lblRating
			Layout.preferredHeight:  lblQualification.height
			Layout.preferredWidth: lblQualification.width
			rowAnchors.left: lblRating.left
		}
		VMLabel{
			text:enguia.tr("Date")+":"
			color: topLabelsColor
		}
		VMLabel{
			id: lblDate
			text:""
			color: topLabelsColor
			Layout.fillWidth: true
			elide: Text.ElideRight
		}
		VMLabel{
			text:enguia.tr("Payment")+":"
			color: topLabelsColor
		}
		VMLabel{
			id: lblPaymentTypeName
			text:""
			color: topLabelsColor
		}
		VMLabel{
			text:enguia.tr("Total")+":"
			color: topLabelsColor
			font.bold: true
		}
		VMLabel{
			text:currencySymbol+ (orderTotalPrice+deliveryRate).toString();
			color: topLabelsColor
			font.bold: true
		}
	}
	Rectangle{
		id:rectNote
		color:"#FFEA00"
		anchors{left:parent.left;right:parent.right;top:clientInfo.bottom;}
		height: lblOrderNote.height+enguia.height*0.02
		VMLabel{
			id: lblOrderNote
			anchors.fill: parent
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
		}
	}
	VSharedHorizontalRect{
		id: lineDetail
		text: enguia.tr("Products")
		anchors.top: rectNote.visible?rectNote.bottom:clientInfo.bottom
		anchors.topMargin: rectNote.visible?0:enguia.mediumMargin
		anchors{left:parent.left;right:parent.right;}
	}
	VMBlockProductsProOrderDetailList{
		id:orderDetailList
		anchors{left:parent.left;right:parent.right;top:lineDetail.bottom;}
		anchors.bottom: parent.bottom
		color:"white"
	}
	Menu{
		id: overflowMenu
		MenuItem {
			text: enguia.tr("Accept order")
			onTriggered: changeOrderStatus(orderID,MSDefines.OrderStatusAccepted);
			visible: topWindow.orderStatus===MSDefines.OrderStatusNew || topWindow.orderStatus===MSDefines.OrderStatusPending
		}
		MenuItem {
			text: enguia.tr("Reject order")
			onTriggered: rejectDlg.setup();
			visible: topWindow.orderStatus!==MSDefines.OrderStatusAccepted && topWindow.orderStatus!==MSDefines.OrderStatusCanceledByPlace && topWindow.orderStatus!==MSDefines.OrderStatusClosed && topWindow.orderStatus!==MSDefines.OrderStatusDispatched && topWindow.orderStatus!==MSDefines.OrderStatusRejected
		}
		MenuItem {
			text: enguia.tr("Order dispatched")
			onTriggered: changeOrderStatus(orderID,MSDefines.OrderStatusDispatched);
			visible:topWindow.orderStatus!==MSDefines.OrderStatusRejected && topWindow.orderStatus!==MSDefines.OrderStatusDispatched && topWindow.orderStatus!==MSDefines.OrderStatusClosed
		}
		MenuItem {
			text: enguia.tr("Order concluded")
			onTriggered: changeOrderStatus(orderID,MSDefines.OrderStatusClosed);
			visible: topWindow.orderType!==MSDefines.OrderTypeInternal&& topWindow.orderStatus!==MSDefines.OrderStatusRejected && topWindow.orderStatus!==MSDefines.OrderStatusClosed
		}
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileBlockProductsProOrderDetail);
		}
	}
	VMBlockProductsRejectDlg{
		id: rejectDlg
		onSigBtnSaveClicked: rejectOrder(orderID,mShared.userID,clientUserID,enguia.tr("Order")+" "+topWindow.visualID.toString()+" " + enguia.tr("was rejected"), txt);
	}
	VMListEmptyRect{
		id: rectLoading
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	function getClient(clientID){
		rectLoading.visible=true;
		mSVC.metaInvoke(MSDefines.SUserClients,"GetUserClientDetail",function(eUserClient){
			rectLoading.visible=false;
			clientUserID=eUserClient.clientUserID;
			lblClientName.text=eUserClient.name;
			lblHomePhone.text=eUserClient.homePhone;
			lblMobilePhone.text=eUserClient.mobilePhone;
			lblHomeAddress.text=eUserClient.homeAddress+", "+eUserClient.stateName+", "+eUserClient.cityName;
			lblHomeAddressReference.text=eUserClient.homeAddressReference
			lblHomePostalCode.text=eUserClient.homePostalCode;
			lblEmail.text=eUserClient.email;
			lblObs.text=eUserClient.comment;
			lblRating.setRating(eUserClient.rating)
		},clientID);
	}
	function rejectOrder(orderID, professionalUserID, clientUserID, title, cause){
		mSVC.metaInvoke(MSDefines.SUserOrders,"RejectUserOrder",function(ok){
			statusBar.displayResult(ok,enguia.tr("Status changed successfully"),enguia.tr("Unable to change the status"));
		},orderID,professionalUserID,clientUserID,title, cause);
	}
	function changeOrderStatus(orderID,status){
		if(topWindow.orderStatus===MSDefines.OrderStatusRejected){statusBar.displayError(enguia.tr("It's not allowed to change a rejected status"));return;}
		mSVC.metaInvoke(MSDefines.SUserOrders,"ChangeStatus",function(ok){
			statusBar.displayResult(ok,enguia.tr("Status changed successfully"),enguia.tr("Unable to change the status"));
		}, orderID,status);
	}
	Component.onCompleted:{
		orderTotalPrice=0;
		rectLoading.visible=true;
		mSVC.metaInvoke(MSDefines.SUserOrders,"GetUserBaseOrder",function(eBaseOrder){
			rectLoading.visible=false;
			var eOrderSummary= enguia.createEntity("EOrderSummary");
			var ok=enguia.convertJsonDocToObject(eBaseOrder.summary,eOrderSummary);
			if(!ok){statusBar.displayError(enguia.tr("Unable to read order summary"));return;}
			lblOrderNote.text=eBaseOrder.note
			if(lblOrderNote.text.length>0)rectNote.visible=true;
			else rectNote.visible=false;
			clientInfo.visible=true;
			//rectTotal.showTotal(true)
			currencySymbol= mSOrder.getCurrencySymbolFromType(eBaseOrder.currencyType)
			paymentTypeName=mSOrder.getCompletePaymentTypeName(eBaseOrder.paymentType, eBaseOrder.creditCardType)
			if(paymentTypeName.toLowerCase().indexOf("paypal")>-1){
				if(eBaseOrder.payPalTransactionID.length<1)lblPaymentTypeName.text=enguia.tr("PayPal NOT CONFIRMED")
				else lblPaymentTypeName.text="PayPal "+eBaseOrder.payPalTransactionID;
			}else lblPaymentTypeName.text=paymentTypeName;
			lblDate.text=Qt.formatDateTime(eBaseOrder.dateInserted,Qt.DefaultLocaleLongDate);
			deliveryRate=eOrderSummary.deliveryRate;
			getClient(orderClientID);
			orderDetailList.clear();
			var productList=eOrderSummary.getProductListJSValue();
			for(var i=0;i<productList.length;i++){
				var e=productList[i];
				orderTotalPrice+=e.totalProductValue;
				orderDetailList.append(e);
			}
		}, orderID,true,true);
	}
}


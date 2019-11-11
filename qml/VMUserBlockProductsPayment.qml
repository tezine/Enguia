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
	property string note:""
	property double orderTotal:0
	property var eUserBlockProducts:dstore.getValue("eUserBlockProducts");

	VSharedPageTitle{
		id:pageTitle
		title:enguia.tr("Payment")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		subtitle: enguia.tr("Select the payment method below")
		z:10
	}
	ExclusiveGroup { id: paymentGroup }
	ColumnLayout{
		id: columnLayout1
		anchors{left:parent.left;leftMargin: enguia.mediumMargin;right:parent.right;rightMargin: enguia.mediumMargin;top:pageTitle.bottom;topMargin: enguia.mediumMargin}
		VSharedCheckBox{
			id: checkCash
			text: enguia.tr("Cash")
			exclusiveGroup: paymentGroup
			visible: false
		}
		VSharedCheckBox{
			id: checkCheck
			text: enguia.tr("Check")
			exclusiveGroup: paymentGroup
			visible: false
		}
		VSharedCheckBox{
			id: checkPaypal
			text:"PayPal"
			exclusiveGroup: paymentGroup
			visible: false
		}
		VSharedCheckBox{
			id: checkBoleto
			text:enguia.tr("Billet")
			exclusiveGroup: paymentGroup
			visible: false
		}
	}
	VSharedHorizontalRect{
		id:horizontalLine2
		text:enguia.tr("Credit cards")
		anchors{left:parent.left;right:parent.right;top:columnLayout1.bottom;topMargin:enguia.mediumMargin}
		visible: false
		z:10
	}
	Flickable {
		id:flickable
		clip: true
		width: parent.width;
		contentWidth: parent.width
		anchors{top:horizontalLine2.bottom;topMargin:enguia.mediumMargin;bottom:lblWarning.top;}
		contentHeight: columnLayout2.height+enguia.height*0.02+enguia.mediumMargin
		ColumnLayout{
			id: columnLayout2
			anchors{left:parent.left;leftMargin:enguia.mediumMargin;  right:parent.right;top:parent.top;}
			VSharedCheckBox{
				id: checkVisa
				text:"Visa"
				exclusiveGroup: paymentGroup
				visible: false
			}
			VSharedCheckBox{
				id: checkMastercard
				text:"Mastercard"
				exclusiveGroup: paymentGroup
				visible: false
			}
			VSharedCheckBox{
				id: checkAmex
				text:"Amex"
				exclusiveGroup: paymentGroup
				visible: false
			}
			VSharedCheckBox{
				id: checkDiners
				text:"Diners Club"
				exclusiveGroup: paymentGroup
				visible: false
			}
			VSharedCheckBox{
				id: checkAura
				text:"Aura"
				exclusiveGroup: paymentGroup
				visible: false
			}
			VSharedCheckBox{
				id: checkElo
				text:"Elo"
				exclusiveGroup: paymentGroup
				visible: false
			}
			VSharedCheckBox{
				id: checkHipercard
				text:"Hipercard"
				exclusiveGroup: paymentGroup
				visible: false
			}
		}
	}
	Rectangle {
		id: scrollbar
		anchors.right: flickable.right
		y: flickable.visibleArea.yPosition * flickable.height
		width: enguia.scrollWidth
		height: flickable.visibleArea.heightRatio * flickable.height
		color: topWindow.color
	}
	Label{
		id:lblWarning
		font{pointSize: enguia.mediumFontPointSize;}
		text:enguia.tr("Warning: If you confirm the order, the user will receive your Enguia profile (name, address, phone...).")
		color: "black"
		wrapMode: Text.Wrap
		horizontalAlignment: Text.AlignLeft
		anchors{left:parent.left;right:parent.right;bottom:btnNext.top;}
		anchors.margins: enguia.mediumMargin;
	}
	VSharedButton{
		id: btnNext
		text: enguia.tr("Confirm order");
		anchors{left:parent.left;right:parent.right;bottom:parent.bottom}
		onClicked: confirmOrder();
	}
	function confirmOrder(){
		var paymentType=0;
		var creditCardType=0;
		if(checkBoleto.checked)paymentType|=MSDefines.PaymentTypeBoleto;
		if(checkCheck.checked)paymentType|=MSDefines.PaymentTypeCheque;
		if(checkCash.checked)paymentType|=MSDefines.PaymentTypeMoney;
		if(checkPaypal.checked)paymentType|=MSDefines.PaymentTypePaypal;

		if(checkAmex.checked){creditCardType|=MSDefines.CreditCardTypeAmex; paymentType|=MSDefines.PaymentTypeCreditCard;}
		if(checkMastercard.checked){creditCardType|=MSDefines.CreditCardTypeMasterCard;paymentType|=MSDefines.PaymentTypeCreditCard;}
		if(checkVisa.checked){creditCardType|=MSDefines.CreditCardTypeVisa;paymentType|=MSDefines.PaymentTypeCreditCard;}
		if(checkDiners.checked){creditCardType|=MSDefines.CreditCardTypeDiners;paymentType|=MSDefines.PaymentTypeCreditCard;}
		if(checkAura.checked){creditCardType|=MSDefines.CreditCardTypeAura;paymentType|=MSDefines.PaymentTypeCreditCard;}
		if(checkElo.checked){creditCardType|=MSDefines.CreditCardTypeElo;paymentType|=MSDefines.PaymentTypeCreditCard;}
		if(checkHipercard.checked){creditCardType|=MSDefines.CreditCardTypeHipercard;paymentType|=MSDefines.PaymentTypeCreditCard;}
		var eUserOrderConfirmation=enguia.createEntity("EUserOrderConfirmation");
		eUserOrderConfirmation.buyerUserID=mShared.userID;
		eUserOrderConfirmation.userID=mShared.otherUserID;
		eUserOrderConfirmation.note=note;
		eUserOrderConfirmation.paymentType=paymentType;
		eUserOrderConfirmation.creditCardType=creditCardType;
		eUserOrderConfirmation.isCollectAndDeliver=eUserBlockProducts.collectAndDeliver;
		if(eUserOrderConfirmation.isCollectAndDeliver){
			eUserOrderConfirmation.collectDate=dstore.getValue("collectDate");
			eUserOrderConfirmation.deliveryDate=dstore.getValue("deliveryDate");
			eUserOrderConfirmation.collectPeriod=dstore.getValue("collectPeriod");
			eUserOrderConfirmation.deliveryPeriod=dstore.getValue("deliveryPeriod");
		}
		mSOrder.confirmUserOrder(enguia.convertObjectToJson(eUserOrderConfirmation), function(visualID){
			if(visualID<=0){statusBar.displayError(enguia.tr("Unable to confirm order"));return;}
			if(!checkPaypal.checked)mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsConfirmation.qml"),destroyOnPop:true, immediate:true, properties:{orderNumber:visualID}})
			/*else{//paypal
				if(enguia.isDesktop())mainStack.push({item:Qt.resolvedUrl("qrc:///BlockProducts/VMBlockProductsPaymentPaypalDesktop.qml"),destroyOnPop:true, immediate:true, properties:{orderTotal:orderTotal, note:note, visualID:visualID}})
				else mainStack.push({item:Qt.resolvedUrl("qrc:///BlockProducts/VMBlockProductsPaymentPaypal.qml"),destroyOnPop:true, immediate:true, properties:{orderTotal:orderTotal, note:note,visualID:visualID}})
			}*/
		});
	}
	Component.onCompleted: {
		var eUserBlockProducts=eUserBlockProducts
		var paymentTypes=eUserBlockProducts.paymentTypes;
		var creditCardTypes=eUserBlockProducts.creditCardTypes;
		if(paymentTypes & MSDefines.PaymentTypeMoney) checkCash.visible=true;
		if(paymentTypes & MSDefines.PaymentTypeCheque) checkCheck.visible=true;
		if(paymentTypes & MSDefines.PaymentTypePaypal){if(!enguia.isIOS()) checkPaypal.visible=true; else checkPaypal.visible=false;}
		if(paymentTypes & MSDefines.PaymentTypeBoleto) checkBoleto.visible=true;
		if(paymentTypes & MSDefines.PaymentTypeCreditCard){
			console.debug("aceita cartao")
			horizontalLine2.visible=true;
			if(creditCardTypes & MSDefines.CreditCardTypeVisa) checkVisa.visible=true;
			if(creditCardTypes & MSDefines.CreditCardTypeMasterCard) checkMastercard.visible=true;
			if(creditCardTypes & MSDefines.CreditCardTypeAmex) checkAmex.visible=true;
			if(creditCardTypes & MSDefines.CreditCardTypeDiners) checkDiners.visible=true;
			if(creditCardTypes & MSDefines.CreditCardTypeAura) checkAura.visible=true;
			if(creditCardTypes & MSDefines.CreditCardTypeElo) checkElo.visible=true;
			if(creditCardTypes & MSDefines.CreditCardTypeHipercard) checkHipercard.visible=true;
		}else console.debug("nao aceita cartao.Ver isso!!!")
	}
}


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
import "qrc:/"

Rectangle {

	Flickable {
		id: flickable
		clip: true
		width: parent.width;
		height: parent.height
		contentWidth: parent.width
		contentHeight: horizontalLine1.height+columnLayout1.height+horizontalLine2.height+columnLayout2.height+ enguia.height*0.02+enguia.mediumMargin
		VSharedHorizontalRect{
			id:horizontalLine1
			text:enguia.tr("Payment options")
			anchors{left:parent.left;right:parent.right;top:parent.top}
		}
		ColumnLayout{
			id: columnLayout1
			anchors{left:parent.left;leftMargin:enguia.mediumMargin;  right:parent.right;top:horizontalLine1.bottom; topMargin:enguia.mediumMargin}
			VMCheckBox{
				id: checkMoney
				text: enguia.tr("Cash")
			}
			VMCheckBox{
				id: checkCheque
				text: enguia.tr("Check")
			}
			VMCheckBox{
				id: checkItau
				text:"Itaú"
				visible: false
			}
			VMCheckBox{
				id: checkPaypal
				text:"Paypal"
				visible: true
			}
			VMCheckBox{
				id: checkBoleto
				text:enguia.tr("Billet")
				visible: false
			}
			VMCheckBox{
				id: checkCreditCard
				text:enguia.tr("Credit card")
			}
		}
		VSharedHorizontalRect{
			id:horizontalLine2
			text:enguia.tr("Credit cards")
			visible: checkCreditCard.checked
			anchors{left:parent.left;right:parent.right;top:columnLayout1.bottom;topMargin:enguia.mediumMargin}
		}
		ColumnLayout{
			id: columnLayout2
			visible: checkCreditCard.checked
			anchors{left:parent.left;leftMargin:enguia.mediumMargin;  right:parent.right;top:horizontalLine2.bottom; topMargin:enguia.mediumMargin}
			VMCheckBox{
				id: checkVisa
				text:"Visa"
			}
			VMCheckBox{
				id: checkMastercard
				text:"Mastercard"
			}
			VMCheckBox{
				id: checkAmex
				text:"Amex"
			}
			VMCheckBox{
				id: checkDiners
				text:"Diners Club"
			}
			VMCheckBox{
				id: checkAura
				text:"Aura"
			}
			VMCheckBox{
				id: checkElo
				text:"Elo"
			}
			VMCheckBox{
				id: checkHipercard
				text:"Hipercard"
			}
		}
	}
	Rectangle {
		id: scrollbar
		anchors.right: flickable.right
		y: flickable.visibleArea.yPosition * flickable.height
		width: enguia.scrollWidth
		height: flickable.visibleArea.heightRatio * flickable.height
		color: "#BDBDBD"
	}
	function clearFields(){
		checkAmex.checked=false;
		checkBoleto.checked=false;
		checkCheque.checked=false;
		checkCreditCard.checked=false;
		checkItau.checked=false;
		checkMastercard.checked=false;
		checkMoney.checked=false;
		checkPaypal.checked=false;
		checkVisa.checked=false;
		checkDiners.checked=false;
		checkAura.checked=false;
		checkElo.checked=false;
		checkHipercard.checked=false;
	}
	function saveFields(){
		eUserBlockProducts.paymentTypes=0;
		eUserBlockProducts.creditCardTypes=0;
		if(checkBoleto.checked)eUserBlockProducts.paymentTypes|=MSDefines.PaymentTypeBoleto;
		if(checkCheque.checked)eUserBlockProducts.paymentTypes|=MSDefines.PaymentTypeCheque;
		if(checkCreditCard.checked){eUserBlockProducts.paymentTypes|=MSDefines.PaymentTypeCreditCard; console.debug("aceita cartao");}
		if(checkItau.checked)eUserBlockProducts.paymentTypes|=MSDefines.PaymentTypeItau;
		if(checkMoney.checked)eUserBlockProducts.paymentTypes|=MSDefines.PaymentTypeMoney;
		if(checkPaypal.checked)eUserBlockProducts.paymentTypes|=MSDefines.PaymentTypePaypal;
		console.debug("payment types:",eUserBlockProducts.paymentTypes)

		if(checkAmex.checked)eUserBlockProducts.creditCardTypes|=MSDefines.CreditCardTypeAmex;
		if(checkMastercard.checked)eUserBlockProducts.creditCardTypes|=MSDefines.CreditCardTypeMasterCard;
		if(checkVisa.checked)eUserBlockProducts.creditCardTypes|=MSDefines.CreditCardTypeVisa;
		if(checkDiners.checked)eUserBlockProducts.creditCardTypes|=MSDefines.CreditCardTypeDiners;
		if(checkAura.checked)eUserBlockProducts.creditCardTypes|=MSDefines.CreditCardTypeAura;
		if(checkElo.checked)eUserBlockProducts.creditCardTypes|=MSDefines.CreditCardTypeElo;
		if(checkHipercard.checked)eUserBlockProducts.creditCardTypes|=MSDefines.CreditCardTypeHipercard;
		return true;
	}
	Component.onCompleted: {
		clearFields();
		if(eUserBlockProducts.paymentTypes & MSDefines.PaymentTypeBoleto) checkBoleto.checked=true;
		if(eUserBlockProducts.paymentTypes & MSDefines.PaymentTypeCheque) checkCheque.checked=true;
		if(eUserBlockProducts.paymentTypes & MSDefines.PaymentTypeCreditCard) checkCreditCard.checked=true;
		if(eUserBlockProducts.paymentTypes & MSDefines.PaymentTypeItau) checkItau.checked=true;
		if(eUserBlockProducts.paymentTypes & MSDefines.PaymentTypeMoney) checkMoney.checked=true;
		if(eUserBlockProducts.paymentTypes & MSDefines.PaymentTypePaypal) checkPaypal.checked=true;

		if(eUserBlockProducts.creditCardTypes & MSDefines.CreditCardTypeAmex) checkAmex.checked=true;
		if(eUserBlockProducts.creditCardTypes & MSDefines.CreditCardTypeMasterCard) checkMastercard.checked=true;
		if(eUserBlockProducts.creditCardTypes & MSDefines.CreditCardTypeVisa) checkVisa.checked=true;

		if(eUserBlockProducts.creditCardTypes & MSDefines.CreditCardTypeDiners) checkDiners.checked=true;
		if(eUserBlockProducts.creditCardTypes & MSDefines.CreditCardTypeAura) checkAura.checked=true;
		if(eUserBlockProducts.creditCardTypes & MSDefines.CreditCardTypeElo) checkElo.checked=true;
		if(eUserBlockProducts.creditCardTypes & MSDefines.CreditCardTypeHipercard) checkHipercard.checked=true;
	}
}


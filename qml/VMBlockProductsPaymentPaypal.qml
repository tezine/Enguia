import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import QtQuick.Controls 1.0
import QtWebView 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"

Rectangle {
	property double orderTotal:0
	property string note:""
	property int visualID:0

    VSharedPageTitle{
        id:pageTitle
        title:"Paypal"
        btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
    }
	VMListEmptyRect{
		id: loadingRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;}
		visible: true
		title: enguia.tr("Loading...")
		z:20
	}
	WebView {
		id: webview
		visible: false
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		url: enguia.getBaseURL()+ "/PayPal/EnguiaCheckout.aspx?placeID="+mShared.placeID.toString()+"&userID="+mShared.userID.toString()+ "&total="+orderTotal.toString()+"&visualID="+visualID.toString();
	}
	Timer{
		id:loadTimer
		interval: 500;
		running: true;
		repeat: true
		onTriggered: {
			console.debug("loading",webview.loading)
			if(webview.loading)loadingRect.title=enguia.tr("Loading...")+webview.loadProgress.toString()+"%"
			else{
				loadingRect.visible=false;
				webview.visible=true;
				running=false;
			}
		}
	}
	Timer {
		id:changePageTimer
		interval: 1000;
		running: true;
		repeat: true
		onTriggered: {
			var response=webview.url.toString();
			console.debug("response:",response)
			if(response.indexOf("EnguiaCheckoutSuccess")>-1){
				running=false;
				mainStack.push({item:Qt.resolvedUrl("qrc:///BlockProducts/VMBlockProductsConfirmation.qml"),destroyOnPop:true, immediate:true, properties:{orderNumber:visualID}})
			}
		}
	}
}


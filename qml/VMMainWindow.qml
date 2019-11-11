import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
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

ApplicationWindow {
	id: mainWindow
	visible:true
	title:"Enguia"
	width: enguia.width
	height: enguia.height
	property bool backClickedOnce:false

	StackView{
		id: mainStack
		anchors.fill: parent
		initialItem: pageLogin
		focus: true//nem sempre funciona. Usar forceActiveFocus()
		Keys.onPressed:  {//se o stackview nao tiver focus, onClosing é chamado ao inves deste ao clicar em back
			if(event.key!==Qt.Key_Back)return;
			console.debug("VMMainWindow back pressed. MainStack depth:",mainStack.depth)
			if(mainStack.depth>2){
				event.accepted = true;
				popOneLevel();
			}else{
				if(currentItem.toString().indexOf("VMNewUser")>-1){
					event.accepted = true;
					popOneLevel();
				}
			}
		}
		Component{
			id: pageLogin
			VMLogin{
			}
		}
		Component{
			id: pageMenu
			VMMenu{
			}
		}
	}
	VSBusyIndicator{
		id: mainIndicator
		running: true
		anchors{right: parent.right;bottom:parent.bottom}
		height:enguia.height*0.09
		width:enguia.height*0.09
		visible: false
		z: 5000
	}
	VMRectMsg{
		id: statusBar
		visible: false
		anchors{left:parent.left; right:parent.right; bottom:parent.bottom;}
		height:enguia.height*0.1
		z: 4999
	}
	VMRectMsg{
		id: quitMsg
		visible: false
		anchors{left:parent.left; right:parent.right; bottom:parent.bottom}
		height:enguia.height*0.1
		z: 4999
		onSigTimeout: backClickedOnce=false;
	}
	VMHelpDlg{
		id: dlgHelp
	}
	Connections{
		target: mSVC
		onSigProgress:{
			mainIndicator.visible=inProgress;
			if(inProgress && percentage>0 && percentage<100){
				//console.debug("vai mostrar percent:",percentage)
				mainIndicator.percentage=percentage;
			}else mainIndicator.percentage=0;//hides the percentage
		}
		onSigNetworkError:{
			popToLogin();
			statusBar.displayError(errorName);
		}
		onSigSessionExpired:{
			popToLogin();
			statusBar.displayError(enguia.tr("Session expired"));
		}
	}
	onClosing: {
		if(enguia.isDesktop()){close.accepted=true;return;}
		console.debug("closing:",mainStack.depth)
		if(mainStack.depth>2){
			mainWindow.popOneLevel();
			close.accepted = false;
			return;
		}
		if(!backClickedOnce){
			backClickedOnce=true;
			close.accepted = false
			quitMsg.displayWithTimer(enguia.tr("Press again to quit"),"#FF5722")
		}
	}
	VMTabViewStyleAndroid{
		id: tabViewStyleAndroid
	}
	VMTextFieldStyleAndroid{
		id: textFieldStyleAndroid
	}
	VMButtonStyleAndroid{
		id: buttonStyleAndroid
	}
	VMCheckBoxStyleAndroid{
		id: checkStyleAndroid
	}
	VMSwitchStyleAndroid{
		id: switchStyleAndroid
	}
	VMComboStyleAndroid{
		id: comboBoxStyleAndroid
	}
	VSharedSpinBoxStyle{
		id: spinBoxStyleAndroid
	}
	VSharedButtonStyleCancel{
		id: buttonStyleCancel
	}
	function popToLogin(){
		enguia.closeDialogs(mainStack.currentItem)
		var vLogin=mainStack.get(0,true);
		vLogin.reload();
		mainStack.pop({item:vLogin,immediate:true})
	}
	function popToMenu(){
		enguia.closeDialogs(mainStack.currentItem)
		var menuItem=mainStack.find(function(item) {
			return item.fileName === "VMMenu";
		});
		if(menuItem) mainStack.pop({item:menuItem,immediate:true});
		mainStack.forceActiveFocus();
	}
	function popOneLevel(){
		console.debug("popOneLevel")
		if(dlgHelp.visible){dlgHelp.close();return;}
		enguia.closeDialogs(mainStack.currentItem)
		statusBar.visible=false;
		mainIndicator.visible=false;
		mainStack.pop({immediate: true});
		mainStack.focus=true;
	}
	function popWithoutClear(){	
		console.debug("popWithoutClear")
		if(dlgHelp.visible){dlgHelp.close();return;}
		enguia.closeDialogs(mainStack.currentItem)
		mainIndicator.visible=false;
		mainStack.pop({immediate: true});
		mainStack.focus=true;
	}
	Component.onCompleted: {
		if(enguia.isIOSNotAuthenticated()){
			mainStack.push({item:Qt.resolvedUrl("qrc:///Events/VMEventsMain.qml"),immediate:true, destroyOnPop:true})
		}
	}
}

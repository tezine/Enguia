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

Rectangle{

    Rectangle{
		id: rect
        anchors{left: parent.left;right: parent.right;top: parent.top;bottom: parent.verticalCenter}
		color: "#01579B"
		Image{
			id: logo
			anchors{verticalCenter: parent.verticalCenter;left: parent.left;leftMargin:enguia.mediumMargin;}
			source: "qrc:///SharedImages/logo.png"
			width: parent.width/5
			height: parent.width/5
			sourceSize.width: parent.width/5
			sourceSize.height: parent.width/5
		}
		Label{
			id: lblText
			anchors{verticalCenter: parent.verticalCenter;left: logo.right; leftMargin: enguia.smallMargin; right:parent.right}
			font{pointSize: enguia.imenseFontPointSize}
			text: enguia.tr("Welcome to Enguia")
			wrapMode: Text.WordWrap
			color: "white"
		}
		VSBusyIndicator{
			id: indicator
			width: parent.width/3
			height: parent.width/3
			anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter}
			running: true
			visible: false
		}
		Label{
			id: lblConnect
			anchors{top: indicator.bottom;horizontalCenter: parent.horizontalCenter}
			font.pointSize: enguia.largeFontPointSize
			horizontalAlignment: Text.AlignHCenter
			color: "white"
			text: enguia.tr("conecting...")
			visible: false
		}
    }
	ColumnLayout{
        id: column
		spacing: enguia.smallMargin
        anchors{top: rect.bottom;topMargin: enguia.smallMargin;leftMargin: enguia.largeMargin;rightMargin: enguia.largeMargin;right: parent.right;left: parent.left}
		VMTextField{
            id: txtLogin
			inputMethodHints: Qt.ImhPreferLowercase
			placeholderText: enguia.tr("Login");
			Layout.fillWidth: true
            maximumLength: 50
        }
		VMTextField{
            id: txtPassword
            inputMethodHints: Qt.ImhNoPredictiveText
			placeholderText: enguia.tr("Password");
            echoMode: TextInput.Password
			maximumLength: 12
			Layout.fillWidth: true
			Keys.onReturnPressed:Qt.inputMethod.hide();
        }
		VMButton{
            id: btnLogin
			text: enguia.tr("Enter");
			Layout.fillWidth: true
			onClicked: authenticate(txtLogin.text, txtPassword.text);
        }
		VMButton{
            id: btnNewUser
			text: enguia.tr("New user");
			Layout.fillWidth: true
			onClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///VMNewUser.qml"),destroyOnPop:true})
        }
        CheckBox{
            id: checkBox
            style: checkStyleAndroid
			text:enguia.tr("Auto-login");
        }
    }
	VMRectMsg{
        id: rectError
        anchors{left:parent.left; right:parent.right;bottom:parent.bottom;top:column.bottom; topMargin:enguia.smallMargin}
        visible:false
    }
    Label{
        id: lblVersao
		text: enguia.tr("version")+" "+mShared.getAppVersion();
        font{pointSize: enguia.mediumFontPointSize;}
        anchors{right:parent.right;rightMargin:enguia.mediumMargin; bottom:parent.bottom;}
    }
	function authenticate(login,password){
		Qt.inputMethod.commit();
        txtPassword.focus=false;
        Qt.inputMethod.hide();
		if(login.length<3){displayProgress(false);rectError.displayError(enguia.tr("Invalid login"));return;}
		if(password.length<3){displayProgress(false);rectError.displayError(enguia.tr("Invalid password"));return;}
		displayProgress(true)
		mSUsers.authenticate(login.toLowerCase(),password,checkBox.checked,MSDefines.AppTypeEnguiaMobile, function(eLoginResponse){
			displayProgress(false)			
			if(eLoginResponse.userID>0) mainStack.push({item:pageMenu})
			else{ displayProgress(false);rectError.displayError(enguia.tr("Invalid login/password"));}
		});
    }
	function displayProgress(visible){
        if(visible){
            rectError.visible=false;
            lblText.visible=false;
            indicator.visible=true;
            lblConnect.visible=true;
            btnLogin.enabled=false;
            btnNewUser.enabled=false;
            checkBox.enabled=false;
			logo.visible=false;
        }else{
            lblText.visible=true;
            indicator.visible=false;
            lblConnect.visible=false;
            btnLogin.enabled=true;
            btnNewUser.enabled=true;
            checkBox.enabled=true;
			logo.visible=true
        }
    }
	function reload(){
		displayProgress(false)
	}
	Stack.onStatusChanged: {
		if(Stack.status===Stack.Activating){
			var defaultLogin=mSUsers.getDefaultLogin();//we do not allow more than one login per device
			if(defaultLogin.length>0){
				txtLogin.text=defaultLogin;
				//btnNewUser.visible=false;
				//if(!enguia.isDesktop()) txtLogin.readOnly=true;
			}
		}
	}
	Component.onCompleted: {
		//if(enguia.isDesktop())btnNewUser.visible=false;
		if(enguia.isAutoLogin()){
			checkBox.checked=true;
			console.debug("usando auto login");
			displayProgress(true)
			mSUsers.autoLogin(MSDefines.AppTypeEnguiaMobile, function(eLoginResponse){
				displayProgress(false)
				if(eLoginResponse.userID>0) mainStack.push({item:pageMenu})
				else{ displayProgress(false);rectError.displayError(enguia.tr("Invalid login/password"));}
			});
		}
	}
}





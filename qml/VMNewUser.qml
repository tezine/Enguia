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

VMTopWindow{
    id: pageNewUser

	VMPageTitle{
        id: pageTitle
		title: enguia.tr("New user")
        btnBackVisible: true
        onSigBtnBackClicked: mainWindow.popOneLevel();
    }
	ColumnLayout{
        id: grid
		spacing: enguia.smallMargin
		anchors{top: pageTitle.bottom;topMargin: enguia.mediumMargin;leftMargin: enguia.mediumMargin;rightMargin: enguia.mediumMargin;right: parent.right;left: parent.left}
		VMTextField{
			id: txtName
			placeholderText: enguia.tr("Name");
			Layout.fillWidth: true
			maximumLength: 50
		}
		VMTextField{
            id: txtLogin
			placeholderText: enguia.tr("Login");
			Layout.fillWidth: true
            inputMethodHints: Qt.ImhLowercaseOnly
			maximumLength: 50
        }
		VMTextField{
            id: txtPassword
			placeholderText: enguia.tr("Password");
            echoMode: TextInput.Password
			Layout.fillWidth: true
            inputMethodHints: Qt.ImhLowercaseOnly
            maximumLength: 12
        }
		VMTextField{
            id: txtRepeatPassword
			placeholderText: enguia.tr("Repeat password");
            echoMode: TextInput.Password
			Layout.fillWidth: true
            inputMethodHints: Qt.ImhLowercaseOnly
            maximumLength: 12
        }
		VMTextField{
            id: txtEmail
			placeholderText: enguia.tr("Email")
			Layout.fillWidth: true
            inputMethodHints: Qt.ImhLowercaseOnly | Qt.ImhEmailCharactersOnly
            maximumLength: 50
        }
		VMButton{
			id: btnLogin
			text: enguia.tr("Create");
			Layout.fillWidth: true
			onClicked: createUser();
		}
	}
	Label{
		id:lblWarning
		font{pointSize: enguia.mediumFontPointSize;}
		text:enguia.tr("Note: Your login cannot be modified later")
		color: "black"
		wrapMode: Text.Wrap
		horizontalAlignment: Text.AlignHCenter
		anchors{left:parent.left;right:parent.right;bottom:parent.bottom}
		anchors.margins: enguia.mediumMargin;
	}
	VMRectMsg{
		id: rectError
		anchors{left:parent.left; right:parent.right;bottom:parent.bottom;}
		height: enguia.height*0.2
		visible:false
	}
    function createUser(){
		Qt.inputMethod.commit();
		Qt.inputMethod.hide();
		rectError.visible=false;
		if(txtName.text.length<3){rectError.displayError(enguia.tr("Invalid name"));return;}
		if(txtLogin.text.length<3){rectError.displayError(enguia.tr("Invalid login"));return;}
		if(txtPassword.text.length<6){rectError.displayError(enguia.tr("Password must have at least 6 characters"));return;}
		if(txtPassword.text!== txtRepeatPassword.text){rectError.displayError(enguia.tr("Passwords do not match"));return;}
		if(txtEmail.text.length<3){rectError.displayError(enguia.tr("Email is required"));return;}
		if(txtEmail.text.indexOf('@')===-1){rectError.displayError(enguia.tr("Invalid email"));return;}
		pageTitle.busy=true;
		mSUsers.createUser(txtName.text, txtLogin.text, txtPassword.text, txtEmail.text,MSDefines.AppTypeEnguiaMobile, function(eLoginResponse){
			pageTitle.busy=false;
			switch(eLoginResponse.respCreateUser){
				case MSDefines.RespCreateUserLoginExists:
					rectError.displayError(enguia.tr("Login exists"));
					break;
				case MSDefines.RespCreateUserEmailExists:
					rectError.displayError(enguia.tr("Email exists"));
					break;
				case MSDefines.RespCreateUserUnknownError:
					rectError.displayError(enguia.tr("Unknown error"));
					break;
				case MSDefines.RespCreateUserOk:
					enguia.setAutoLogin(txtLogin.text,"",false);//para nao permitir se logar com outro usuario
					mainStack.push({item:pageMenu, replace: true})
					break;
				}
		});
    }
}


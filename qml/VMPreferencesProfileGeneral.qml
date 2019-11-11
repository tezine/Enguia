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
	anchors.fill: parent
	color:enguia.backColor

	Flickable {
		id:flickable
		clip: true
		width: parent.width;
		height: parent.height
		contentWidth: parent.width
		contentHeight: grid.height+enguia.height*0.02+enguia.mediumMargin
		GridLayout{
			id: grid
			columns: 2
			anchors{top: parent.top;left: parent.left;right: parent.right;rightMargin:enguia.mediumMargin; leftMargin: enguia.mediumMargin;topMargin: enguia.mediumMargin}
			VMLabel{
				id: lblValue
				text: enguia.tr("Name")+":"
			}
			VMTextField{
				id: txtName
				Layout.fillWidth: true
				maximumLength: 50
			}
			VMLabel{
				id: lblLogin
				text: enguia.tr("Login")+":"
			}
			VMTextField{
				id: txtLogin
				Layout.fillWidth: true
				readOnly: true
			}
			VMLabel{
				text: enguia.tr("Password")+":"
			}
			VMTextField{
				id: txtPassword
				Layout.fillWidth: true
				echoMode: TextInput.Password
				maximumLength: 12
			}
			VMLabel{
				text: enguia.tr("Repeat password")+":"
			}
			VMTextField{
				id: txtRepeatPassword
				Layout.fillWidth: true
				echoMode: TextInput.Password
				maximumLength: 12
			}
			VMLabel{
				id: lblMail
				text: enguia.tr("Email")+":"
			}
			VMTextField{
				id: txtMail
				Layout.fillWidth: true
				inputMethodHints: Qt.ImhLowercaseOnly | Qt.ImhEmailCharactersOnly
				maximumLength: 50
			}
			VMLabel{
				id: lblHomePhone
				text: enguia.tr("Phone")+":"
			}
			VMTextField{
				id: txtHomePhone
				Layout.fillWidth: true
				inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
				maximumLength: 20
			}
			VMLabel{
				id: lblMobile
				text: enguia.tr("Mobile")+":"
			}
			VMTextField{
				id: txtMobile
				Layout.fillWidth: true
				inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
				maximumLength: 20
			}
			VMLabel{
				id: lblDocument
				text: enguia.tr("Document")+":"
			}
			VMTextField{
				id: txtDocument
				Layout.fillWidth: true
				inputMethodHints: Qt.ImhNoPredictiveText
				maximumLength: 45
			}
			VMLabel{
				text: enguia.tr("Sex")+":"
			}
			VMComboBox{
				id:comboSex
				Layout.fillWidth: true
			}
			VMLabel{
				text: enguia.tr("Birthday")+":"
			}
			VMButton{
				id: btnBirthday
				text: "..."
				Layout.fillWidth: true
				onClicked: dlgDate.launchDate(dt,1)
			}
			VMLabel{
				text: enguia.tr("Language")+":"
			}
			VMComboBox{
				id:comboLanguage
				Layout.fillWidth: true
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
	VMDlgDate{
		id: dlgDate
		onSigDateSelected: btnBirthday.fillDate(dt)		
	}
	function saveFields(){
		if(txtPassword.text.length<6){statusBar.displayError(enguia.tr("Password must have at least 6 characters"));return false;}
		if(txtPassword.text!==txtRepeatPassword.text){statusBar.displayError(enguia.tr("Passwords do not match"));return false;}
		if(txtMail.text.length<3 || (txtMail.text.indexOf('@')===-1)){statusBar.displayError(enguia.tr("Invalid email"));return false;}
		var dt=new Date();
		dt.setFullYear(dt.getFullYear()-1)//tem que ter pelo menos 1 ano de idade.
		if(btnBirthday.dt >= dt ){statusBar.displayError(enguia.tr("Invalid date"));return false;}
		eUser.name=txtName.text;
		eUser.email=txtMail.text
		eUser.homePhone=txtHomePhone.text
		eUser.mobilePhone=txtMobile.text
		eUser.password=txtPassword.text;
		eUser.passwordHash=mSUsers.encryptPassword(txtPassword.text);
		eUser.bornDate=btnBirthday.dt;
		eUser.sex=comboSex.getSelected();
		eUser.languageCodeID=comboLanguage.getSelected();
		eUser.document=txtDocument.text;
		enguia.setDefaultLanguageCode(eUser.languageCodeID)
		return true;
	}
	Component.onCompleted: {
		comboSex.append(MMobile.SexTypeMale,enguia.tr("Male"));
		comboSex.append(MMobile.SexTypeFemale,enguia.tr("Female"));
		comboLanguage.append(MSDefines.LanguageCodePortugueseBrasil,"Português-Brasil")
		comboLanguage.append(MSDefines.LanguageCodeEnglishUS,"English-US");
		mSVC.metaInvoke(MSDefines.SUsers,"GetAllFieldsByID",function(e){
			enguia.copyValues(e,eUser);
			txtName.text=eUser.name;
			txtLogin.text=eUser.login;
			txtMail.text=eUser.email
			txtHomePhone.text=eUser.homePhone
			txtMobile.text=eUser.mobilePhone;
			txtDocument.text=eUser.document;
			btnBirthday.fillDate(eUser.bornDate);
			comboSex.select(eUser.sex);
			comboLanguage.select(eUser.languageCodeID)
			//tabGeneral.pic.source=Qt.resolvedUrl("data:image/png;base64," + mData.getFile('C:/construction.png')); FUNCIONA!!!
			//tabGeneral.pic.source="image://arrayimages/"+cs.icon
		},mShared.userID);
	}
}

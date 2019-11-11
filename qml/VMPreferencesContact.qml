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


Rectangle {
	color:enguia.backColor

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Contact us")
		btnDoneVisible: false
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popWithoutClear();
		titleLayout.anchors.right: btnSend.left
		VMToolButton{
			id: btnSend
			source: "qrc:///SharedImages/send.png"
			anchors.right: parent.right
			onSigClicked: sendMsg(0, mShared.userID,combo.getSelected(), txtTitle.text,textArea.text)
		}
	}
	ColumnLayout{
		anchors{left:parent.left;right:parent.right; top:pageTitle.bottom;bottom:parent.bottom;}
		anchors.margins: enguia.mediumMargin;
		VMComboBox{
			id: combo
			Layout.fillWidth: true
		}
		VMTextField{
			id: txtTitle
			placeholderText: enguia.tr("Subject")+":"
			Layout.fillWidth: true;
			maximumLength: 50
		}
		TextArea{
			id: textArea
			font{pointSize: enguia.mediumFontPointSize;}
			Layout.fillHeight: true
			Layout.fillWidth: true;
		}
	}
	Component.onCompleted: {
		combo.append(MSDefines.ContactTypeSuggestion,enguia.tr("Suggestion"));
		combo.append(MSDefines.ContactTypeComplain,enguia.tr("Complaint"));
		combo.append(MSDefines.ContactTypeBug,enguia.tr("Bug"))
		combo.append(MSDefines.ContactTypeOther,enguia.tr("Other"));
	}
	function sendMsg(placeID, userID, msgType, title, content){
		if(title.length<3){statusBar.displayError(enguia.tr("Invalid subject"));return;}
		if(content.length<3){statusBar.displayError(enguia.tr("Invalid content"));return;}
		if(content.length>10000){statusBar.displayError(enguia.tr("Maximum size is 10.000 chars"));return;}
		mSVC.metaInvoke(MSDefines.SAbout,"SendAboutMsg",function(ok){
			if(ok){
				textArea.text="";
				statusBar.displaySuccess(enguia.tr("Message sent successfully"));
				mainWindow.popWithoutClear()
			}else statusBar.displayError(enguia.tr("Unable to send message"));
		},placeID,userID,msgType,title, content);
	}
}


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
    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Help")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
    }
	TextArea{
		id:textArea
        anchors{top: pageTitle.bottom;left: parent.left;right: parent.right;bottom: parent.bottom}
        textFormat: TextEdit.RichText
		font.pointSize: enguia.mediumFontPointSize
        readOnly: true
		VSharedListEmptyRect{
			id: loadingRect
			anchors.fill: parent
			visible: false
			title: enguia.tr("Loading...")
			z:10
		}
    }
	Component.onCompleted: {
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SHelp,"GetHelpContent",function(txt){
			loadingRect.visible=false;
			textArea.text=txt;
		},enguia.getLanguageCodeID(),MSDefines.HelpTypeMobilePreferencesHelp);
	}
}

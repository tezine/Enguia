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


Dialog {
	id: dlg
	visible:false
	signal sigCloseClicked();

	contentItem: Rectangle {
		id:rectContent
		implicitWidth: enguia.width
		implicitHeight: enguia.height
		color: enguia.backColor

		VMDlgTitleBar{
			id: titlebar
			anchors{top:parent.top;left:parent.left;right:parent.right}
			title: enguia.tr("Help");
			onSigCancelClicked:{sigCloseClicked();  close();}
			saveVisible: false
		}
        VSharedText{//textarea na deixa margem esquerda/direita e ainda mostra o cursor!
            id:sharedText
            fontPointSize: enguia.mediumFontPointSize
            anchors{left:parent.left;right:parent.right;top:titlebar.bottom;bottom:parent.bottom;}
            textFormat: TextEdit.RichText
            VSharedListEmptyRect{
                id: loadingRect
                anchors.fill: parent
                visible: false
                title: enguia.tr("Loading...")
                z:10
            }
        }
	}
	function setup(helpType){
		rectContent.implicitWidth= enguia.width
		rectContent.implicitHeight= enguia.height
		rectContent.width= enguia.width
		rectContent.height= enguia.height
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SHelp,"GetHelpContent",function(txt){
			loadingRect.visible=false;
            sharedText.setText(txt)
		},enguia.getLanguageCodeID(),helpType)
		open();
	}
}


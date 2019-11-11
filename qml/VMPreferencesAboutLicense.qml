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

Rectangle {

	TextArea{
		id:textArea
		font.pointSize: enguia.mediumFontPointSize
		anchors.fill: parent
		readOnly: true
		textFormat: TextEdit.RichText
		wrapMode: TextEdit.Wrap
	}
	Component.onCompleted: {
		mSVC.metaInvoke(MSDefines.SAbout,"GetAgreement",function(eAgreement){
			textArea.text=eAgreement.content
		})
	}
}


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
	signal sigSaveClicked(string title, string description)
	width: enguia.width
	height: enguia.height

	contentItem: Rectangle {
		implicitWidth: enguia.width
		implicitHeight: enguia.height
		color: enguia.backColor
		VMDlgTitleBar{
			id: titlebar
			anchors{top:parent.top;left:parent.left;right:parent.right}
			title: enguia.tr("Picture detail");
            onSigCancelClicked: {Qt.inputMethod.hide();close();}
			saveVisible: true
            onSigSaveClicked: {dlg.sigSaveClicked(txtTitle.text,textArea.text);Qt.inputMethod.hide();close();}
		}
		ColumnLayout{
			id: columnLayout
			anchors{top: titlebar.bottom;topMargin: enguia.mediumMargin;left:parent.left; leftMargin: enguia.mediumMargin;right:parent.right; rightMargin: enguia.mediumMargin;bottom:parent.bottom;bottomMargin: enguia.mediumMargin}
			spacing: enguia.smallMargin
			VMTextField{
				id: txtTitle
				Layout.fillWidth:true
				placeholderText: enguia.tr("Picture title")
				maximumLength: 50
				//onAccepted: searchCityByName(txtCity.text)
			}
			TextArea{
				id: textArea
				Layout.fillWidth: true
				Layout.fillHeight: true
				font.pointSize: enguia.largeFontPointSize
			}
		}
	}
	function setup(title, description){
		txtTitle.text=""
		textArea.text=""
		if(title)txtTitle.text=title;
		if(description)textArea.text=description;
		open();
	}
}

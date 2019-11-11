import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"

Dialog {
	id: dlg
	visible:false
	modality: Qt.NonModal
	property int productID:0
	property int mode:0
	property alias text: txtArea.text
	signal sigBtnSaveClicked(string txt);

	contentItem: Rectangle {
		color:enguia.backColor
		implicitWidth:enguia.width
		implicitHeight:enguia.height
		VSharedTitleBar{
			id: titlebar
			anchors{top:parent.top}
			width: parent.width;
			title: enguia.tr("Rejection cause")
			cancelVisible: false
			saveText: enguia.tr("Save")
			saveVisible: true
			onSigCancelClicked: close();
			onSigOkClicked: save();
		}
		TextArea{
			id: txtArea
			font.pointSize: enguia.largeFontPointSize
			anchors{top:titlebar.bottom;topMargin:enguia.mediumMargin; left:parent.left;leftMargin:enguia.mediumMargin;  right:parent.right; rightMargin:enguia.mediumMargin;  bottom:parent.bottom; bottomMargin:enguia.mediumMargin}
		}
	}
	function save(){
		if(txtArea.text.length<3){statusBar.displayError(enguia.tr("Invalid text"));return;}
		sigBtnSaveClicked(txtArea.text)
		close();
	}
	function setup(){
		txtArea.text=""
		open();
	}
}


import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Rectangle{
	height: enguia.height*0.08
	color: "#01579B"
    property alias title: txt.text
    property alias saveVisible: btnSave.visible
	signal sigCancelClicked();
	signal sigSaveClicked();

	RowLayout{
		anchors{left:parent.left;leftMargin: enguia.mediumMargin;right:parent.right;top:parent.top;bottom:parent.bottom;}
		Text{
			id: txt
			font.pointSize: enguia.largeFontPointSize
			verticalAlignment: Text.AlignVCenter
			Layout.fillWidth: true
			color: "white"
		}
		VMLabelButton{
			id: btnSave
			text:enguia.tr("Save");
			textColor:"green"
			onSigClicked: sigSaveClicked();
		}
		VMLabelButton{
			id: btnCancel
			text:enguia.tr("Cancel")
			textColor:"red"
			onSigClicked: sigCancelClicked()
		}
	}
}


import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"

Rectangle {
	height: enguia.height*0.06
	id: rect
	border.color: "lightgray"
	border.width: 1
	property string amount: lblSelected.text
	signal sigAmountSelected(int amount);

	RowLayout{
		id:rowLayout
		anchors{left:parent.left;leftMargin: enguia.mediumMargin;right:parent.right;rightMargin: enguia.mediumMargin;verticalCenter: parent.verticalCenter}
		Label{
			id: lblAmount
			font{pointSize: enguia.hugeFontPointSize}
			color:"black"
			Layout.fillHeight: true
			Layout.alignment: Qt.AlignLeft
			text: enguia.tr("Amount")+":"
		}
		Label{
			id: lblSelected
			font{pointSize: enguia.largeFontPointSize}
			color:"gray"
			Layout.fillWidth: true
			horizontalAlignment: Text.AlignRight
			Layout.alignment: Qt.AlignRight
			visible: text.length>0
		}
	}
	VMBlockProductsAmountDlg{
		id: dlg
		onSigItemSelected: {
			lblSelected.text=name
			sigAmountSelected(parseInt(name))
		}
	}
	MouseArea{
		anchors.fill: parent
		onClicked: dlg.open();
	}
}


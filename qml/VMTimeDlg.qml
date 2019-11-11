import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"

Dialog {
	id: dlg
	property int type:0
	signal sigBtnSaveClicked(int type, int hour, int minute)

	contentItem: Rectangle {
		implicitWidth:enguia.width
		implicitHeight:enguia.height
		VSharedTitleBar{
			id: titlebar
			anchors{top:parent.top}
			width: parent.width;
			title: enguia.tr("Period")
			cancelVisible: false
			saveText: enguia.tr("Ok")
			saveVisible: true
			onSigCancelClicked: close();
			onSigOkClicked: {
				dlg.sigBtnSaveClicked(dlg.type, pickerStart.hour, pickerStart.minute)
				close();
			}
		}

		VSharedTimePicker{
			id:pickerStart
			anchors.verticalCenter: parent.verticalCenter
			height:parent.width
			width:parent.width
			hour: 9
			minute: 0
		}
	}
	function setup(type){
		dlg.type=type;
		open();
	}
}


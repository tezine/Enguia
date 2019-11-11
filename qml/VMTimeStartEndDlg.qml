import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import QtQuick.Layouts 1.1
import "qrc:/Components"
import "qrc:/Shared"

Dialog {
	id: dlg
	property int type:0
	signal sigBtnSaveClicked(int type, int hourStart, int minuteStart, int hourEnd, int minuteEnd)

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
				dlg.sigBtnSaveClicked(dlg.type, pickerStart.hour, pickerStart.minute, pickerEnd.hour, pickerEnd.minute)
				close();
			}
		}
		ColumnLayout{
			anchors{top:titlebar.bottom;left:parent.left;right:parent.right; bottom: parent.bottom;}
			spacing: 0

			VSharedTimePicker{
				id:pickerStart
				anchors.horizontalCenter: parent.horizontalCenter
				Layout.preferredHeight:parent.height/2
				Layout.preferredWidth:parent.height/2
				hour: 9
				minute: 0
				title: enguia.tr("Start")
			}
			VSharedTimePicker{
				id:pickerEnd
				anchors.horizontalCenter: parent.horizontalCenter
				Layout.preferredHeight:parent.height/2
				Layout.preferredWidth:parent.height/2
				hour: 18
				minute: 0
				title: enguia.tr("End")
			}
		}
	}
	function setup(type, start, end){
		dlg.type=type;
		if(enguia.isNullTime(start))console.debug("null time")
		else console.debug("start nao é null")
		console.debug("start:",start, "end:",end)
		if(Qt.formatTime(start,Qt.ISODate)!=="00:00:00")pickerStart.setTime(start.getHours(),start.getMinutes());
		if(Qt.formatTime(end,Qt.ISODate)!=="00:00:00")pickerEnd.setTime(end.getHours(),end.getMinutes());
		open();
	}
}




import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockSchedule"

Rectangle {
	id: top
	color:"transparent"
	height: grid.height
	property alias title: rectTitle.text
	property alias startString: btnPeriodStart.text
	property alias endString: btnPeriodEnd.text

	ColumnLayout{
		id: grid
		anchors{left:parent.left;right:parent.right;top:parent.top;}
		height: btnPeriodStart.height+btnPeriodEnd.height+enguia.height*0.02
		spacing: 0
		VSharedLabelRectCompact{
			id: rectTitle
			Layout.fillWidth: true
			text:enguia.tr("Period 1")
		}
		VMButton{
			id: btnPeriodStart
			Layout.fillWidth: true
			text: "..."
			onClicked: timeDlg.setup(1)
			VMLabel{
				color: "white"
				text: enguia.tr("Start")+":"
				anchors{left:parent.left;leftMargin: enguia.mediumMargin;verticalCenter:parent.verticalCenter}
			}
			VMImageButton{
				color: enguia.buttonNormalColor
				anchors.right: parent.right
				width: parent.height
				height: parent.height
				source:"qrc:///Images/delete.png"
				visible: true
				onSigBtnClicked: {
					btnPeriodStart.text="..."
				}
			}
		}
		VMButton{
			id: btnPeriodEnd
			Layout.fillWidth: true
			text: "..."
			onClicked: timeDlg.setup(2)
			VMLabel{
				color: "white"
				text: enguia.tr("End")+":"
				anchors{left:parent.left;leftMargin: enguia.mediumMargin;verticalCenter:parent.verticalCenter}
			}
			VMImageButton{
				color: enguia.buttonNormalColor
				anchors.right: parent.right
				width: parent.height
				height: parent.height
				source:"qrc:///Images/delete.png"
				visible: true
				onSigBtnClicked: {
					btnPeriodEnd.text="..."
				}
			}
		}
	}
	VMTimeDlg{
		id:timeDlg
		onSigBtnSaveClicked: {
			if(type===1)btnPeriodStart.text=Qt.formatTime(enguia.convertToTime(hour,minute),"HH:mm")
			else btnPeriodEnd.text=Qt.formatTime(enguia.convertToTime(hour,minute),"HH:mm")
		}
	}
	function setup(start, end){
		var startString=Qt.formatTime(start,"HH:mm");
		var endString=Qt.formatTime(end,"HH:mm");
		if(!enguia.isNullTime(start) && startString!=="00:00")btnPeriodStart.text=startString
		if(!enguia.isNullTime(end)&& endString!=="00:00")btnPeriodEnd.text=endString
	}
}


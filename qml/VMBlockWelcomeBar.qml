import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockWelcome"

RowLayout{
	id:rowLayout
	spacing: 0
	property alias btnStatus: btnStatus
	property alias btnInfo: btnInfo

	Rectangle{
		id: btnStatus        
		implicitWidth: enguia.width*0.3
        Layout.fillHeight: true
		Label {
			id: lblStatus
			anchors.centerIn: parent
			color: "white"
			font.pointSize: enguia.largeFontPointSize;
			renderType: Text.NativeRendering
		}
		MouseArea{
			anchors.fill: parent
			onClicked: dlgStatus.setup(erBlockWelcome)
		}
	}
	Rectangle{
        Layout.fillHeight: true
        Layout.minimumWidth: enguia.width*0.5
        Layout.preferredWidth: enguia.width*0.5
		Layout.fillWidth: true
		color:enguia.buttonNormalColor
		VSharedRatingIndicator{
			id: ratingIndicator
            width: enguia.width*0.5
			height: btnStatus.height
			rating: 0
			MouseArea{
				anchors.fill: parent
				onClicked: dlgRating.setup(erBlockWelcome)
			}
		}
	}
	VSharedButton{
		id: btnInfo
		text:enguia.tr("Info")
		Layout.preferredWidth: parent.width*0.2
		onClicked: {
			dlgAddress.setup(erBlockWelcome)
		}
	}
	function setup(rating, qualificationsEnabled, openStatus){
		ratingIndicator.setRating(rating)
		if(!qualificationsEnabled)ratingIndicator.visible=false
		switch(openStatus){
		case MSDefines.OpenStatusOpen:
			btnStatus.color="#4CAF50"
			lblStatus.text=enguia.tr("Open")
			break;
		case MSDefines.OpenStatusClosed:
			btnStatus.color="#C62828"
			lblStatus.text=enguia.tr("Closed")
			break;
		}
	}
}


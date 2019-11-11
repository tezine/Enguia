import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"


Dialog {
    id: dlg
    visible:false
	width: enguia.width
	height: enguia.height

	contentItem: Rectangle {
		implicitWidth:enguia.width
		implicitHeight:enguia.height
		ColumnLayout{
			anchors.fill: parent
			Label{
				id: lblName
				visible: text.length>0
				Layout.fillWidth: true
				font{pointSize: enguia.largeFontPointSize;bold:true}
				horizontalAlignment: Text.AlignHCenter
				Layout.alignment: Qt.AlignHCenter
			}
			Label{
				id: lblDescription
				font{pointSize: enguia.mediumFontPointSize}
				Layout.fillHeight: true
				Layout.fillWidth: true
				visible: text.length>0
			}
			Image{
				id:img
				fillMode: Image.PreserveAspectFit
				Layout.fillHeight: true
				Layout.fillWidth: true
			}
		}
		MouseArea{
			anchors.fill: parent
			onClicked: close();
		}
    }
	function setup(placeID, picID, name, description){
        img.source=mSFiles.getPictureUrl(placeID,picID)
		lblName.text=name;
		lblDescription.text=description;
        open();
    }
}


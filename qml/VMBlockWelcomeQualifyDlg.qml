import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockWelcome"

Dialog {
	id: dlg
	visible:false
	modality: Qt.NonModal
	signal sigRateSet(int rating)

	contentItem: Rectangle {
		implicitWidth:enguia.width*0.8
		implicitHeight:enguia.height*0.2
		color:enguia.backColor
		VSharedTitleBar{
			id: titlebar
			anchors{top:parent.top}
			width: parent.width;
			title: enguia.tr("Qualify place")
			cancelText: enguia.tr("Ok");
			saveVisible: false
			onSigCancelClicked: {sigRateSet(indicator.rating);close();}
		}
		VSharedRatingSelection{
			id: indicator
			color:enguia.backColor
			anchors{left:parent.left;right: parent.right;top:titlebar.bottom;bottom:parent.bottom;}
			width: parent.width
			rating: 10
		}
	}
}


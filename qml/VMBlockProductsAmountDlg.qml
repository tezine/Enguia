import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"

Dialog {
	id: dlg
	visible:false
	modality: Qt.NonModal
	signal sigItemSelected(int id, string name)

	contentItem: Rectangle {
		implicitWidth:enguia.width*0.4
		implicitHeight:enguia.height*0.4
		VMBlockProductsAmountList{
			id: sharedList
			anchors.fill: parent
			onListItemClicked: {sigItemSelected(id,name);close();}
		}
	}
	Component.onCompleted: {
		for(var i=0;i<=50;i++){
			sharedList.append(i,i+1,0)
		}
	}
}

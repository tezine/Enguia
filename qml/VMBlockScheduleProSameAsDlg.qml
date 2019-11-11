import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockSchedule"

Dialog {
	id: dlg
	visible:false
	modality: Qt.NonModal
	signal listItemClicked(int weekDay)

	contentItem: Rectangle {
		implicitWidth:enguia.width*0.8
		implicitHeight:enguia.height*0.8
		VSharedList{
			id: listView
			anchors.fill: parent
			onListItemClicked: {
				dlg.listItemClicked(id)
				close();
			}
		}
	}
	Component.onCompleted: {
		listView.append(enguia.tr("Monday"),"",Qt.Monday)
		listView.append(enguia.tr("Tuesday"),"",Qt.Tuesday)
		listView.append(enguia.tr("Wednesday"),"",Qt.Wednesday)
		listView.append(enguia.tr("Thursday"),"",Qt.Thursday)
		listView.append(enguia.tr("Friday"),"",Qt.Friday)
		listView.append(enguia.tr("Saturday"),"",Qt.Saturday)
		listView.append(enguia.tr("Sunday"),"",Qt.Sunday)
	}
}

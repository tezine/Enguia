import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"

Item{
	clip: true
	property alias listModel: menuModel
	property alias visibleArea: listView.visibleArea
	property alias listView: listView
	signal listItemClicked(string name, int status)
	signal listItemPressAndHold(int id, int status, int clientUserID)

	ListModel{
		id: menuModel
	}
	ListView{
		id: listView
		anchors.fill: parent
		model: menuModel
		clip: true
		delegate:  Rectangle{
			id: listItem
			color:mSAgenda.getAppointmentStatusColor(model.status);
			height: enguia.screenHeight*0.1
			anchors{left: parent.left;  right: parent.right; }
			ColumnLayout{
				id:columnLayout
				anchors{left:parent.left;leftMargin: enguia.mediumMargin ;right:parent.right;rightMargin: enguia.mediumMargin;verticalCenter: parent.verticalCenter}
				spacing: 0
				Label{
					id: mainText
					font{pointSize: enguia.hugeFontPointSize;weight: Font.Bold}
					color: "black"
					Layout.fillWidth: true
					elide: Text.ElideRight
					text: Qt.formatTime(model.tm,"HH:mm")
				}
				Label{
					id: subText
					font{pointSize: enguia.smallFontPointSize}
					text: model.clientUserName
					color: "#424242"
					visible: text.length>0
					elide: Text.ElideRight
					Layout.fillWidth: true
				}
				Label{
					font{pointSize: enguia.smallFontPointSize}
					text: model.phone
					color: "#424242"
					visible: text.length>0
					elide: Text.ElideRight
					Layout.fillWidth: true
				}
				Label{
					font{pointSize: enguia.smallFontPointSize}
					text: model.serviceName
					color: "#424242"
					visible: text.length>0
					elide: Text.ElideRight
					Layout.fillWidth: true
				}
				Label{
					id: lblStatus
					font{pointSize: enguia.tinyFontPointSize;}
					color: "#424242"
					text:  mSAgenda.getAppointmentStatusName(model.status);
				}
			}
			Rectangle{
				id: imgSeparator
				anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height:1
				color:"lightgray"
			}
			MouseArea{
				id: mouseArea
				anchors.fill: parent
				onPressAndHold: listItemPressAndHold(model.id, model.status, model.clientUserID)
				//onClicked: listItemClicked(model.id, model.name, model.brief, model.description)
			}
			Component.onCompleted: {
				var itensHeight=columnLayout.height+imgSeparator.height+ enguia.height*0.02
				if(itensHeight>listItem.height)listItem.height=itensHeight
			}
		}
	}
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
		anchors.right: listView.right
		anchors.top: parent.top
	}
	function append(eUserSchedule) {
		var phone="";
		if(eUserSchedule.clientMobile.length>0)phone=eUserSchedule.clientMobile;
		else if(eUserSchedule.clientPhone.length>0)phone=eUserSchedule.clientPhone
		eUserSchedule.phone=phone;
		menuModel.append(eUserSchedule);
	}
	function clear(){
		menuModel.clear();
	}
	function getByID(id){
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===id) {
				var modelItem=menuModel.get(i);
				return modelItem;
			}
		}
		return null;
	}
}



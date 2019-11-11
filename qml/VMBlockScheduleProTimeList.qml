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
	signal listItemPressAndHold(int id, int status, int userID)

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
					text: model.userName
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
				onPressAndHold: listItemPressAndHold(model.id, model.status, model.userID)
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
	function append(eAgenda) {
		eAgenda.phone=""
		if(eAgenda.userMobile.length>0)eAgenda.phone=eAgenda.userMobile;
		else if(eAgenda.userPhone.length>0)eAgenda.phone=eAgenda.userPhone;
		menuModel.append(eAgenda)
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

import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockSchedule"


Item{
	clip: true
	property alias listModel: menuModel
	property bool loading:false
	signal listItemClicked(int id, string name, string brief, string description)
	signal listItemPressAndHold(int id, int index)
	signal sigBtnDeleteClicked(int id)

	ListModel{
		id: menuModel
	}
	VMListEmptyRect{
		id: listEmptyRect
		anchors{left:parent.left;right:parent.right;top:parent.top}
		visible: listModel.count===0
		title: loading?enguia.tr("Loading..."): enguia.tr("No records");
	}
	ListView{
		id: listView
		anchors.fill: parent
		model: menuModel
		clip: true
		delegate:  Item{
			id: listItem
			height: enguia.screenHeight*0.09
			anchors{left: parent.left; right: parent.right;}
			ColumnLayout{
				id:columnLayout
				anchors{left: parent.left; leftMargin: enguia.mediumMargin; right:arrowImage.left;rightMargin:enguia.mediumMargin;  verticalCenter:parent.verticalCenter}
				Label{
					id: mainText
					font{pointSize: enguia.hugeFontPointSize;}
					color: "black"
					text: model.name
					verticalAlignment: Text.AlignVCenter
					Layout.fillHeight: true
					Layout.fillWidth: true
					Layout.alignment: Qt.AlignVCenter
					elide: Text.ElideRight
				}
				Label{
					id: subText
					font{pointSize: enguia.smallFontPointSize;}
					color: "#616161"
					text: model.brief
					wrapMode: Text.Wrap
					visible: model.brief.length>0
					//visible: model.typeName!==model.name
				}
			}
			VMListButton{
				id: deleteImage
				z: 100
				width: listItem.height*0.9
				height: listItem.height*0.9
				anchors{right:arrowImage.left;verticalCenter: parent.verticalCenter;}
				source: "qrc:///Images/delete.png"
				visible: model.showDelete?true:false
				onSigClicked: sigBtnDeleteClicked(model.id)
			}
			Image{
				id: arrowImage
				source: "qrc:///SharedImages/nextblack.png"
				width: listItem.height*0.5
				height: listItem.height*0.5
				anchors{right: parent.right;verticalCenter: parent.verticalCenter}
			}
			Rectangle{
				id: imgSeparator
				anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height:1
				color:enguia.sectionRectColor
			}
			MouseArea{
				id: mouseArea
				anchors.fill: parent
				onClicked: listItemClicked(model.id, model.name, model.brief, model.description)
				onPressAndHold: listItemPressAndHold(model.id,model.index)
			}
			Component.onCompleted:{
				var itensHeight=columnLayout.height+imgSeparator.height+ enguia.height*0.02
				if(itensHeight>listItem.height) listItem.height=itensHeight
			}
		}
	}
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: parent.width*0.02
		anchors.right: listView.right
		anchors.top: parent.top
	}
	MSTimer {
		id: tmr
		onTriggered: {
			for(var i=0;i<menuModel.count;i++) {
				var modelItem=menuModel.get(i);
				modelItem.showDelete=false;
			}
		}
	}
	function append(id, name, brief, description) {
		menuModel.append({id:id,name:name,brief:brief, description:description,showDelete:false})
	}
	function showDelete(id){
		tmr.stop();
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===id) {
				var modelItem=menuModel.get(i);
				modelItem.showDelete=true;
				tmr.start(5000);
				break;
			}
		}
	}
	function remove(id){
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===id) {
				menuModel.remove(i);
				break;
			}
		}
	}
	function clear(){
		menuModel.clear();
	}

}

import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockMenu"

Item{
	clip: true
	property alias listModel: menuModel
	property bool loading:false
	signal listItemClicked(int targetBlockType, int targetBlockID,int nextBlockVisibility)
	signal listItemPressAndHold(double unitValue, string productName, int index, int id)

	ListModel{
		id: menuModel
	}
	VMListEmptyRect{
		id: listEmptyRect
		anchors{left:parent.left;right:parent.right;top:parent.top}
		visible: menuModel.count===0
		title: loading?enguia.tr("Loading..."): enguia.tr("No records");
	}
	ListView{
		id: listView
		anchors.fill: parent
		model: menuModel
		clip: true
		delegate:  Item{
			id: listItem
			height: enguia.screenHeight*0.1
			anchors{left: parent.left; right: parent.right;}
			/*Image{
				id: imagem
				anchors{left: parent.left;verticalCenter: parent.verticalCenter}
				source: model.image
				width: listItem.height
				height: listItem.height
				asynchronous: true
			}*/
			ColumnLayout{
				anchors{left:parent.left; leftMargin: enguia.hugeMargin; verticalCenter:parent.verticalCenter}
				anchors.right: parent.right
				Label{
					id: mainText
					font{pointSize: enguia.hugeFontPointSize;}
					color: "black"
					text: model.title
					verticalAlignment: Text.AlignVCenter
					Layout.fillHeight: true
					Layout.fillWidth: true
					Layout.alignment: Qt.AlignVCenter
					elide: Text.ElideRight
				}
				Text{
					id: lblSubTitle
					font{pointSize: enguia.smallFontPointSize}
					text:model.subtitle
					elide: Text.ElideRight
					Layout.fillWidth: true
					color: "gray"
					visible: text.length>0
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
				onClicked: listItemClicked(model.targetBlockType, model.targetBlockID,model.nextBlockVisibility)
				onPressAndHold: listItemPressAndHold(model.unitValue, model.productName, model.index, model.id)
			}
		}
	}
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
		anchors.right: listView.right
		anchors.top: parent.top
	}
	function append(id, title, subtitle, targetBlockType, targetBlockID,  image, nextBlockVisibility) {
		if(nextBlockVisibility===undefined)nextBlockVisibility=0;
		menuModel.append({id:id, title:title, subtitle:subtitle, "backColor":'#e7e3e7',targetBlockType:targetBlockType, targetBlockID:targetBlockID,  image:image, nextBlockVisibility:nextBlockVisibility})
	}
	function remove(id){
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===id) {
				menuModel.remove(i);
				break;
			}
		}
	}
}

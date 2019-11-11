import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"

Item{
	clip: true
	property alias listModel: menuModel
	signal listItemClicked(double unitValue, string productName, int id, string image)
	signal listItemPressAndHold(double unitValue, string productName, int index, int id)
	property int pageNumber:0
	property bool loading:false
	property alias rectVisible:listEmptyRect.visible
	signal sigEndOfListReached()

	ListModel{
		id: menuModel
	}
	VMListEmptyRect{
		id: listEmptyRect
		color:"white"
		anchors{left:parent.left;right:parent.right;top:parent.top}
		visible: false
		title: loading?enguia.tr("Searching..."): enguia.tr("Nothing found");
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
			Image{
				id: imagem
				anchors{left: parent.left;verticalCenter: parent.verticalCenter}
				source: model.image
				width: listItem.height
				height: listItem.height
				asynchronous: true
				visible: displayImg
			}
			ColumnLayout{
				anchors.left: displayImg?imagem.right: parent.left
				anchors{leftMargin: enguia.mediumMargin; verticalCenter:parent.verticalCenter}
				anchors.right: lblPrice.visible?lblPrice.left:parent.right
				Label{
					id: mainText
					font{pointSize: enguia.hugeFontPointSize;}
					color: "black"
					text: model.productName
					verticalAlignment: Text.AlignVCenter
					Layout.fillHeight: true
					Layout.fillWidth: true
					Layout.alignment: Qt.AlignVCenter
					elide: Text.ElideRight
				}
				Text{
					id: lblSubTitle
					font{pointSize: enguia.smallFontPointSize}
					text:model.brief
					elide: Text.ElideRight
					Layout.fillWidth: true
					color: "gray"
					visible: text.length>0
				}
			}
			Text{
				id: lblPrice
				anchors{right:parent.right;rightMargin: enguia.mediumMargin;verticalCenter: parent.verticalCenter;}
				font{pointSize: enguia.smallFontPointSize}
				text: mSOrder.getCurrencySymbol()+model.unitValue
				color: "gray"
				visible: model.unitValue>0
			}
			Rectangle{
				id: imgSeparator
				anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height:enguia.separatorHeight
				color:enguia.sectionRectColor
			}
			MouseArea{
				id: mouseArea
				anchors.fill: parent
				onClicked: listItemClicked(model.unitValue, model.productName, model.id, model.image)
				onPressAndHold: listItemPressAndHold(model.unitValue, model.productName, model.index, model.id)
			}
		}
		onAtYEndChanged: {
			if(listModel.count<enguia.listCount)return;
			if(atYEnd) sigEndOfListReached()
		}
	}
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
		anchors.right: listView.right
		anchors.top: parent.top
	}
	function append(productName, brief, unitValue, image, id) {
		menuModel.append({productName:productName,brief:brief, unitValue:unitValue,"image":image, "backColor":'#e7e3e7', "id":id})
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
		pageNumber=0;
	}
}

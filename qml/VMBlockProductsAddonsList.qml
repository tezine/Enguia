import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Styles"
import "qrc:/Shared"

Item{
	clip: true
	property alias listModel: menuModel
	property alias visibleArea: listView.visibleArea
	property alias listView: listView
	property bool loading:false
	signal listItemClicked(string name, int id, double price)

	ListModel{
		id: menuModel
	}
	VMListEmptyRect{
		id: listEmptyRect
		color:"white"
		anchors.fill: parent//nao copiar para outro lugar
		visible: menuModel.count===0
		title: loading?enguia.tr("Loading..."): enguia.tr("No records");
	}
	ListView{
		id: listView
		anchors.fill: parent
		model: menuModel
		clip: true
		delegate:  Rectangle{
			id: listItem
			height: enguia.screenHeight*0.07
			anchors{left: parent.left ; right: parent.right;}
			color:"transparent"
			Label{
				id: mainText
				anchors{left: parent.left; leftMargin: enguia.smallMargin; verticalCenter:parent.verticalCenter}
				font{pointSize: enguia.hugeFontPointSize;}
				color: "black"
				text: model.name
				font.bold: model.itemSelected
			}
			Label{
				id: txtPrice
				anchors{right:imgSelected.left;rightMargin: enguia.mediumMargin; verticalCenter:parent.verticalCenter}
				font{pointSize: enguia.largeFontPointSize;}
				color: "black"
				text: model.price
				visible: model.price>0
			}
			Image{
				id: imgSelected
				source:"qrc:///SharedImages/ok.png"
				width: parent.height*0.8
				height: parent.height*0.8
				anchors{right: parent.right;rightMargin: enguia.smallMargin;verticalCenter: parent.verticalCenter;}
				visible: model.itemSelected
			}
			Rectangle{
				id: imgSeparator
				anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height: 1;
				color:"lightgray"
			}
			MouseArea{
				id: mouseArea
				anchors.fill: parent
				onClicked:{
					if(!model.itemSelected){
						menuModel.get(model.index).itemSelected=true;
					}else{
						menuModel.get(model.index).itemSelected=false;
					}
				}
			}
			Component.onCompleted:{
				//listItem.height=mainText.height+imgSeparator.height
			}
		}
	}
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
		anchors.right: listView.right
		anchors.top: parent.top
	}
	function append(id, name, price) {
		menuModel.append({id:id, name:name, price:price,itemSelected:false})
	}
	function clear(){
		menuModel.clear()
	}
}

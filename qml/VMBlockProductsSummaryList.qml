import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"

Item{
	property variant pressedAndHoldItem : null
	property alias listModel: listModel
	signal listItemClicked(int id, int transactionType, int index)
	signal listItemPressAndHold(int id, int transactionType)
	signal sigRequestNextPage(int nextPageNumber)
	signal sigBtnDeleteClicked(int id);
	property int nextBlockID:0

	ListModel{
		id: listModel
	}
	ListView{
		id: listView
		anchors.fill: parent
		model: listModel
		clip: true
		delegate:  Item{
			id: listItem
			height: enguia.screenHeight*0.04
			property variant itemData: model
			anchors{left:parent.left; right: parent.right; }
			Rectangle{
				id: rect
				height: enguia.screenHeight*0.05
				width: parent.width
				color: "lightgray"
				Text{
					id: headerLabel
					anchors{left:parent.left;leftMargin:  enguia.mediumMargin;verticalCenter: rect.verticalCenter}
					text: model.amount.toString()+" "+model.name
					font{bold: true;pointSize: enguia.mediumFontPointSize}
					color: "black"
				}
			}
			Rectangle{
				id: rectBottom
				anchors{left:parent.left;right:parent.right;rightMargin: enguia.mediumMargin; top:rect.bottom}
				height: columnLayout.height<enguia.height*0.07?enguia.height*0.07:columnLayout.height
				Image{
					id: imagem
					anchors{left: parent.left;}
					source: model.image
					width: parent.height
					height: parent.height
				}
				ColumnLayout{
					id: columnLayout
					spacing: 0
					anchors{left:imagem.right;leftMargin: enguia.smallMargin; right: imgRemove.left;verticalCenter: parent.verticalCenter;}
					Label{
						id: lblOption1
						font{pointSize: enguia.smallFontPointSize}
						text: model.option1?model.option1:""
						color: "gray"
						elide: Text.ElideRight
						Layout.fillWidth: true
						visible: text.length>0
					}
					Label{
						id: lblOption2
						font{pointSize: enguia.smallFontPointSize}
						text: model.option2?model.option2:""
						color: "gray"
						elide: Text.ElideRight
						Layout.fillWidth: true
						visible: text.length>0
					}
					Label{
						id: lblOption3
						font{pointSize: enguia.smallFontPointSize}
						text: model.option3?model.option3:""
						color: "gray"
						elide: Text.ElideRight
						Layout.fillWidth: true
						visible: text.length>0
					}
					Label{
						id: lblAddons
						Layout.fillWidth: true
						font{pointSize: enguia.smallFontPointSize}
						text: model.addOns?model.addOns:""
						color: "gray"
						elide: Text.ElideRight
						visible: text.trim().length>0
					}
					Label{
						id: lblUnitValue
						font{pointSize: enguia.smallFontPointSize}
						color: "#757575"
						text:enguia.tr("Unit price")+": "+mSOrder.getCurrencySymbol()+ model.unitValue.toString();
						visible: model.unitValue>0
					}
					Label{
						id: lblProductTotal
						font{pointSize: enguia.smallFontPointSize}
						color: "#757575"
						text:enguia.tr("Product total")+": "+ mSOrder.getCurrencySymbol()+ model.productTotal.toString();
						visible: model.productTotal>0
					}
					Component.onCompleted: {//esse é carregado depois
						listItem.height= rectBottom.height+rect.height+imgSeparator.height//+enguia.height*0.02
					}
				}
				Image{
					id: imgRemove
					source: "qrc:///SharedImages/delete.png"
					anchors{verticalCenter: parent.verticalCenter;right:parent.right;}
					width: enguia.height*0.06
					height: enguia.height*0.06
					MouseArea{
						anchors.fill: parent
						onClicked: sigBtnDeleteClicked(model.productID)
					}
				}
			}
			Rectangle{
				id: imgSeparator
				anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height:1
				color:"lightgray"
			}
			Component.onCompleted: {//nao sei pq, esse é chamado antes do completed do rectBottom
			}
		}
	}
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
		anchors.right: listView.right
		anchors.top: parent.top
	}
	Timer {
		id: tmr
		interval: 5000
		repeat: false
		running: false
		onTriggered: {
			for(var i=0;i<listModel.count;i++) {
				var modelItem=listModel.get(i);
				modelItem.showDelete=false;
				modelItem.backColor="#f2f2f2";
			}
		}
	}
	function showDelete(id){
		tmr.stop();
		for(var i=0;i<listModel.count;i++) {
			if(listModel.get(i).id===id) {
				var modelItem=listModel.get(i);
				modelItem.showDelete=true;
				modelItem.backColor="#6d6767";
				tmr.start();
				break;
			}
		}
	}
	function append(eOrderDetail, img){
		var option1, option2, option3=""
		if(eOrderDetail.option1ID>0){
			option1=eOrderDetail.option1;
		}
		if(eOrderDetail.option2ID>0){
			option2=eOrderDetail.option2;
		}
		if(eOrderDetail.option3ID>0){
			option3=eOrderDetail.option3;
		}
		listModel.append({productID:eOrderDetail.productID, id:eOrderDetail.id,name:eOrderDetail.productName,image:img,unitValue:eOrderDetail.unitValue, amount:eOrderDetail.amount,
							 productTotal:eOrderDetail.totalProductValue, option1:option1, option2:option2, option3:option3, addOns:eOrderDetail.addOnsNames ,"showDelete":false})
	}
	function remove(id){
		for(var i=0;i<listModel.count;i++) {
			if(listModel.get(i).id===id) {
				listModel.remove(i);
				break;
			}
		}
	}
	function clearBackColor(){
		for(var i=0;i<listModel.count;i++){
			listModel.get(i).backColor="transparent"
		}
	}
	function select(id){
		for(var i=0;i<listModel.count;i++) {
			if(listModel.get(i).id===id) {
				var modelItem=listModel.get(i);
				modelItem.backColor="gray";
			}
		}
	}
	function removeCurrent(){
		listModel.remove(listView.currentIndex);
	}
	function reset(){
		listModel.clear();
		nextBlockID=0;
	}
}

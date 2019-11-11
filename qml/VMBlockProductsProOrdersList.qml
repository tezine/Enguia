import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/BlockProducts"
import "qrc:/Shared"


Item{
	clip: true
	property alias listModel: menuModel
	property alias visibleArea: listView.visibleArea
	property alias listView: listView
	property bool loading:false
	signal listItemClicked(string name, int id, int visualID, string userName, int userID, int status, int clientID, int orderType)
	signal listItemPressAndHold(string name, int id, int visualID, string userName, int userID, int status, int clientID, int orderType)
	signal sigBtnDeleteClicked(int id);
	property int pageNumber:0
	signal sigEndOfListReached()

	ListModel{
		id: menuModel
	}
	VSharedListEmptyRect{
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
		delegate:  Rectangle{
			id: listItem
			height: enguia.screenHeight*0.07
			anchors{left: parent.left; right: parent.right;}
			color:model.backColor
			Rectangle{
				id: rectSelected
				color:"lightgray"
				anchors{left:parent.left;top:parent.top;bottom:parent.bottom;}
				width:parent.width*0.05
				visible:model.selected
			}
			ColumnLayout{
				id:columnLayout
				anchors{left: parent.left; leftMargin: enguia.hugeMargin; verticalCenter:parent.verticalCenter}
				spacing: 0
				Label{
					id: mainText
					font{pointSize: enguia.hugeFontPointSize;weight: Font.Bold}
					color: "black"
					text: model.title
				}
				Label{
					id: subText
					font{pointSize: enguia.mediumFontPointSize;}
					color: "black"
					text: model.userName
				}
				Label{
					id: lblTableName
					font{pointSize: enguia.mediumFontPointSize;}
					color: "black"
					text: model.tableName
					visible: model.orderType===MSDefines.OrderTypeInternal
				}
				Label{
					id: lblStatus
					font{pointSize: enguia.tinyFontPointSize;}
					color: "black"
					text: model.statusName
				}
			}
			Rectangle{
				id: imgSeparator
				anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height: 1;
				color:"lightgray"
			}
			VMListButton{
				id: deleteImage
				z: 1
				width: listItem.height*0.9
				height: listItem.height*0.9
				source: "qrc:///Images/delete.png"
				anchors{right: parent.right;rightMargin: enguia.mediumMargin;verticalCenter: parent.verticalCenter}
				visible: model.showDelete?true:false
				onSigClicked: sigBtnDeleteClicked(model.id)
			}
			Image{
				id: arrowImage
				source: "qrc:///Images/next.png"
				width: listItem.height*0.9
				height: listItem.height*0.9
				anchors{right: parent.right;verticalCenter: parent.verticalCenter}
			}
			MouseArea{
				id: mouseArea
				anchors.fill: parent
				onClicked: {
					clearSelection();
					select(model.id);
					listItemClicked(model.title, model.id, model.visualID, model.userName, model.userID, model.status, model.clientID, model.orderType)
				}
				onPressAndHold: listItemPressAndHold(model.title, model.id, model.visualID, model.userName, model.userID, model.status, model.clientID, model.orderType)
			}
			Component.onCompleted: {
				var itensHeight=columnLayout.height+enguia.height*0.01
				if(itensHeight>listItem.height)listItem.height=itensHeight
			}
		}
		onAtYEndChanged: {
			if(menuModel.count<enguia.listCount)return;
			if(atYEnd) sigEndOfListReached()
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
			for(var i=0;i<menuModel.count;i++) {
				var modelItem=menuModel.get(i);
				modelItem.showDelete=false;
				modelItem.backColor="#f2f2f2";
			}
		}
	}
	function showDelete(id){
		tmr.stop();
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===id) {
				var modelItem=menuModel.get(i);
				modelItem.showDelete=true;
				modelItem.backColor="#6d6767";
				tmr.start();
				break;
			}
		}
	}
	function append(eBaseOrder) {
		var title="";
		switch(eBaseOrder.orderType){
			case MSDefines.OrderTypeExternal:
				title=enguia.tr("External Order")+" "+eBaseOrder.visualID.toString()
				break;
			case MSDefines.OrderTypeInternal:
				title=enguia.tr("Internal Order")+" "+eBaseOrder.visualID.toString()
				break;
		}
		var backColor=getStatusColor(eBaseOrder.status);
		var statusName=getStatusName(eBaseOrder.status)
		menuModel.append({"title":title,
							 userName:eBaseOrder.userName,
							 visualID:eBaseOrder.visualID,
							 "backColor":'#e7e3e7',
							 "id":eBaseOrder.id,
							 "showDelete":false,
							 "backColor":backColor,
							 "userID":eBaseOrder.userID,
							 "selected":false,
							 "dateInserted":eBaseOrder.dateInserted,
							 "status":eBaseOrder.status,
							 "statusName":statusName,
							 "tableName": eBaseOrder.tableName,
							 "orderType":eBaseOrder.orderType,
							 "clientID":eBaseOrder.clientID})
	}
	function prepend(eBaseOrder) {
		var title="";
		switch(eBaseOrder.orderType){
			case MSDefines.OrderTypeExternal:
				title=enguia.tr("External Order")+" "+eBaseOrder.visualID.toString()
				break;
			case MSDefines.OrderTypeInternal:
				title=enguia.tr("Internal Order")+" "+eBaseOrder.visualID.toString()
				break;
		}
		var backColor=getStatusColor(eBaseOrder.status);
		var statusName=getStatusName(eBaseOrder.status)
		menuModel.insert(0,{"title":title,
							 userName:eBaseOrder.userName,
							 visualID:eBaseOrder.visualID,
							 "backColor":'#e7e3e7',
							 "id":eBaseOrder.id,
							 "showDelete":false,
							 "backColor":backColor,
							 "userID":eBaseOrder.userID,
							 "selected":false,
							 "dateInserted":eBaseOrder.dateInserted,
							 "status":eBaseOrder.status,
							 "statusName":statusName,
							 "tableName":eBaseOrder.tableName,
							 "orderType":eBaseOrder.orderType,
							 "clientID":eBaseOrder.clientID})
	}
	function remove(id){
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===id) {
				menuModel.remove(i);
				break;
			}
		}
	}
	function clearBackColor(){
		for(var i=0;i<menuModel.count;i++){
			menuModel.get(i).backColor="transparent"
		}
	}
	function clearSelection(){
		for(var i=0;i<menuModel.count;i++){
			menuModel.get(i).selected=false;
		}
	}
	function select(id){
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===id) {
				var modelItem=menuModel.get(i);
				modelItem.selected=true;
			}
		}
	}
	function clear(){
		menuModel.clear();
		pageNumber=0;
	}
	function updateOrInsert(name, id){
		var found=false;
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===id) {
				var modelItem=menuModel.get(i);
				modelItem.title=name;
				modelItem.id=id;
				found=true;
				break;
			}
		}
		if(!found)append(name,"",id)
	}
	function getLastOrderID(){
		if(menuModel.count===0)return 0;
		return menuModel.get(0).id
	}
	function getLastOrderDateInserted(){
		if(menuModel.count===0)return 0;
		return menuModel.get(0).dateInserted
	}
	function getStatusColor(statusType){
		return mSOrder.getOrderStatusColor(statusType);
	}
	function getStatusName(statusType){
		return mSOrder.getOrderStatusName(statusType);
	}
	function setStatus(orderType, currentOrderID, currentStatus){
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===currentOrderID && menuModel.get(i).orderType===orderType) {
				var modelItem=menuModel.get(i);
				modelItem.status=currentStatus;
				modelItem.backColor=getStatusColor(currentStatus);
				modelItem.statusName=getStatusName(currentStatus);
			}
		}
	}
}

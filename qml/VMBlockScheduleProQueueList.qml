import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"


Item{
	clip: true
	property alias listModel: menuModel
	property alias visibleArea: listView.visibleArea
	property alias listView: listView
	property bool loading:false
	signal listItemClicked(string name, int id)
	signal listItemPressAndHold(int id, string name, int userID, int clientID, int serviceID, date dt)
	signal sigBtnDeleteClicked(int id);
	property int pageNumber:0
	signal sigEndOfListReached()

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
		delegate:  Rectangle{
			id: listItem
			height: enguia.screenHeight*0.08
			anchors{left: parent.left; right: parent.right;}
			color:model.backColor
			ColumnLayout{
				id:columnLayout
				anchors{left: parent.left; leftMargin: enguia.mediumMargin; verticalCenter:parent.verticalCenter;right:rowLayout.left}
				Label{
					id: mainText
					font{pointSize: enguia.largeFontPointSize;}
					color:  "black"
					text: model.name
					visible: text.length>0
				}
				Label{
					font{pointSize: enguia.smallFontPointSize;}
					color: "#424242"
					text: model.serviceName
					Layout.fillWidth: true
					visible: text.length>0
				}
				Label{
					id: subCellPhone
					font{pointSize: enguia.smallFontPointSize;}
					color: "#424242"
					text: model.mobilePhone
					Layout.fillWidth: true
					visible: text.length>0
				}
				Label{
					id: subText
					font{pointSize: enguia.tinyFontPointSize;}
					color: "gray"
					text: model.comment
					Layout.fillWidth: true
					wrapMode: Text.Wrap
					visible: text.length>0
				}
			}
			RowLayout{
				id:rowLayout
				anchors{right:parent.right;rightMargin: enguia.smallMargin; verticalCenter: parent.verticalCenter}
				VMListButton{
					id: deleteImage
					z: 100
					width: listItem.height*0.9
					height: listItem.height*0.9
					Layout.preferredHeight: listItem.height*0.9
					Layout.preferredWidth: listItem.height*0.9
					source: "qrc:///Images/delete.png"
					visible: model.showDelete?true:false
					onSigClicked: sigBtnDeleteClicked(model.id)
				}
//				Image{
//					id: arrowImage
//					source: "qrc:///Images/next.png"
//					width: listItem.height*0.5
//					height: listItem.height*0.5
//					Layout.preferredWidth: listItem.height*0.5
//					Layout.preferredHeight: listItem.height*0.5
//				}
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
				enabled: !model.showDelete
				onClicked: {
					//clearBackColor();
					//select(model.id);
					//listItemClicked(model.title, model.id)
				}
				onPressAndHold: listItemPressAndHold(model.id, model.name, model.userID, model.clientID, model.serviceID, model.dt)
			}
			Component.onCompleted: {
				var itensHeight=columnLayout.height+imgSeparator.height+ enguia.height*0.02
				if(itensHeight>listItem.height)listItem.height=itensHeight
			}
		}
		section.property: "dt"
		section.criteria: ViewSection.FullString
		section.delegate: VSharedListSection{
			text: Qt.formatDate(section,Qt.SystemLocaleLongDate)
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
				modelItem.backColor="transparent"
			}
		}
	}
	function showDelete(id){
		tmr.stop();
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===id) {
				var modelItem=menuModel.get(i);
				modelItem.showDelete=true;
				modelItem.backColor=enguia.sectionRectColor
				tmr.start();
				break;
			}
		}
	}
	function append(eScheduleQueue) {
		menuModel.append({dt:eScheduleQueue.dt1, id:eScheduleQueue.id, serviceName:eScheduleQueue.serviceName, clientID:eScheduleQueue.clientID, name:eScheduleQueue.userName, comment:eScheduleQueue.comment, userID:eScheduleQueue.userID, serviceID:eScheduleQueue.serviceID, backColor:"transparent", showDelete:false, mobilePhone:eScheduleQueue.mobilePhone})
		if(enguia.isValidDate(eScheduleQueue.dt2))menuModel.append({dt:eScheduleQueue.dt2, id:eScheduleQueue.id, serviceName:eScheduleQueue.serviceName,clientID:eScheduleQueue.clientID,name:eScheduleQueue.userName, comment:eScheduleQueue.comment, userID:eScheduleQueue.userID, serviceID:eScheduleQueue.serviceID, backColor:"transparent", showDelete:false,mobilePhone:eScheduleQueue.mobilePhone})
		if(enguia.isValidDate(eScheduleQueue.dt3))menuModel.append({dt:eScheduleQueue.dt3, id:eScheduleQueue.id, serviceName:eScheduleQueue.serviceName,clientID:eScheduleQueue.clientID,name:eScheduleQueue.userName, comment:eScheduleQueue.comment, userID:eScheduleQueue.userID, serviceID:eScheduleQueue.serviceID, backColor:"transparent", showDelete:false,mobilePhone:eScheduleQueue.mobilePhone})
		if(enguia.isValidDate(eScheduleQueue.dt4))menuModel.append({dt:eScheduleQueue.dt4, id:eScheduleQueue.id, serviceName:eScheduleQueue.serviceName,clientID:eScheduleQueue.clientID,name:eScheduleQueue.userName, comment:eScheduleQueue.comment, userID:eScheduleQueue.userID, serviceID:eScheduleQueue.serviceID, backColor:"transparent", showDelete:false,mobilePhone:eScheduleQueue.mobilePhone})
		if(enguia.isValidDate(eScheduleQueue.dt5))menuModel.append({dt:eScheduleQueue.dt5, id:eScheduleQueue.id, serviceName:eScheduleQueue.serviceName,clientID:eScheduleQueue.clientID,name:eScheduleQueue.userName, comment:eScheduleQueue.comment, userID:eScheduleQueue.userID, serviceID:eScheduleQueue.serviceID, backColor:"transparent", showDelete:false,mobilePhone:eScheduleQueue.mobilePhone})
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
	function select(id){
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===id) {
				var modelItem=menuModel.get(i);
				modelItem.backColor=enguia.backColor
			}
		}
	}
	function clear(){
		pageNumber=0;
		menuModel.clear();
	}
	function removeCurrent(){
		menuModel.remove(listView.currentIndex);
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
}


import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Events"
import "qrc:/Components"
import "qrc:/Contacts"
import "qrc:/Favorites"
import "qrc:/Messages"
import "qrc:/News"
import "qrc:/Preferences"
import "qrc:/Qualifications"
import "qrc:/Search"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/"

Item{
	clip: true
	property alias listModel: menuModel
	property alias visibleArea: listView.visibleArea
	property alias listView: listView
	property bool loading:false
	signal listItemClicked(int id)
	signal listItemPressAndHold(string name, int index, int id, string userName)
	signal sigBtnDeleteClicked(int id);
	property int pageNumber:0
	signal sigEndOfListReached()

	ListModel{
		id: menuModel
	}
	VMListEmptyRect{
		id: listEmptyRect
		color: "white"
		anchors{left:parent.left;right:parent.right;top:parent.top}
		visible: loading
		title: enguia.tr("Loading...")
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
				anchors{left: parent.left; leftMargin: enguia.mediumMargin; verticalCenter:parent.verticalCenter;right:arrowImage.left}
				Label{
					id: mainText
					font{pointSize: enguia.mediumFontPointSize;}
					color: "black"
					text: enguia.tr("From")+": "+ model.fromName
					visible: text.length>0
				}
				Label{
					id: subText
					font{pointSize: enguia.mediumFontPointSize;}
					color: "black"
					text: enguia.tr("To")+": " +model.toName
					Layout.fillWidth: true
					elide: Text.ElideRight
					visible: text.length>0
				}
				Label{
					id: lblTitle
					font{pointSize: enguia.smallFontPointSize;}
					color: "gray"
					text: model.title
					Layout.fillWidth: true
					elide: Text.ElideRight
					visible: text.length>0
				}
				Label{
					id: lblContent
					font{pointSize: enguia.tinyFontPointSize;}
					color: "gray"
					text: model.content
					Layout.fillWidth: true
					elide: Text.ElideRight
					visible: text.length>0
				}
			}
			Rectangle{
				id: imgSeparator
				anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height: 1;
				color:"lightgray"
			}
			Image{
				id: arrowImage
				source: "qrc:///Images/next.png"
				width: listItem.height*0.5
				height: listItem.height*0.5
				anchors{right: parent.right;verticalCenter: parent.verticalCenter}
			}
			MouseArea{
				id: mouseArea
				anchors.fill: parent
				onClicked: {
					clearBackColor();
					select(model.id);
					listItemClicked(model.id)
				}
				//onPressAndHold: listItemPressAndHold(model.title, model.index, model.id, model.userName)
			}
			Component.onCompleted: {
				var itensHeight=columnLayout.height+imgSeparator.height+ enguia.height*0.02
				if(itensHeight>listItem.height)listItem.height=itensHeight
			}
		}
		section.property: "dateInserted"
		section.criteria: ViewSection.FullString
		section.delegate: VSharedListSection{
			text: Qt.formatDate(section,Qt.SystemLocaleShortDate)
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
	function append(eMessage) {
		menuModel.append({id:eMessage.id,content:eMessage.content,  title:eMessage.title, fromName:eMessage.fromName, toName:eMessage.toName ,dateInserted:enguia.convertToDate(eMessage.dateInserted), backColor:"transparent"})
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
				modelItem.backColor=enguia.backColor;
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
}



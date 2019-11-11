import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
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
	signal listItemClicked(string name, int id)
	signal listItemPressAndHold(string name, int index, int id)
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
					font.bold: (model.msgType==="received" && (!model.isRead))?true:false// model.isRead?false:true
					color: (model.msgType==="received" && model.isRead)?"#424242": "black"
					text: model.name
					visible: text.length>0
                }
                Label{
                    id: subText
                    font{pointSize: enguia.smallFontPointSize;}
					color: "gray"
					text: model.title
                    Layout.fillWidth: true
                    elide: Text.ElideRight
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
				Image{
					id: imgAttach
					source:"qrc:///SharedImages/attachment.png"
					Layout.preferredHeight: arrowImage.height*0.5
					Layout.preferredWidth: arrowImage.width*0.5
					visible:model.containsAttach
				}
				Image{
					id: readImage
					source:"qrc:///SharedImages/ok.png"
					width: listItem.height*0.5
					height: listItem.height*0.5
					Layout.preferredHeight: listItem.height*0.5
					Layout.preferredWidth: listItem.height*0.5
					visible: model.msgType==="sent" && model.isRead===true;
				}
				Image{
					id: arrowImage
					source: "qrc:///Images/next.png"
					width: listItem.height*0.5
					height: listItem.height*0.5
					Layout.preferredWidth: listItem.height*0.5
					Layout.preferredHeight: listItem.height*0.5
				}
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
                    clearBackColor();
                    select(model.id);
					listItemClicked(model.title, model.id)
                }
				onPressAndHold: listItemPressAndHold(model.title, model.index, model.id)
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
	function append(msgType, eMessage) {
		var name="";
		if(msgType==="sent")name=eMessage.toName;
		else name=eMessage.fromName;
		menuModel.append({msgType:msgType,
							 isRead:eMessage.isRead,
							 title:eMessage.title,
							 name:name,
							 id:eMessage.id,
							 showDelete:false,
							 backColor:"transparent",
							 dateInserted:enguia.convertToDateOnly(eMessage.dateInserted),
							 containsAttach:eMessage.containsAttach})
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



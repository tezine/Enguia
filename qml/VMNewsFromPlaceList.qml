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
    signal listItemClicked(string name, int id, string userName)
    signal listItemPressAndHold(string name, int index, int id, string userName)
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
            anchors{left: parent.left; right: parent.right;}
            color:model.backColor
            ColumnLayout{
                id:columnLayout
                anchors{left: parent.left; leftMargin: enguia.hugeMargin; verticalCenter:parent.verticalCenter;right:parent.right;rightMargin: enguia.mediumMargin}
                Label{
                    id: mainText
                    font{pointSize: enguia.mediumFontPointSize;weight: Font.Bold}
                    color: "black"
                    text: model.title
					Layout.fillWidth: true
					wrapMode: Text.Wrap
                }
                Label{
                    id: subText
                    font{pointSize: enguia.smallFontPointSize;}
                    color: "black"
                    text: model.content
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap
                }
				Label{
					id: lblEnd
					font{pointSize: enguia.tinyFontPointSize;}
					color: "gray"
					text:enguia.tr("valid until")+" "+Qt.formatDate(model.endDate,Qt.SystemLocaleShortDate)
					Layout.fillWidth: true
					wrapMode: Text.WordWrap
				}
            }
            Rectangle{
                id: imgSeparator
                anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height: enguia.separatorHeight
				color:enguia.sectionRectColor
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
            MouseArea{
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    //clearBackColor();
                    //select(model.id);
                    listItemClicked(model.title, model.id, model.userName)
                }
                onPressAndHold: listItemPressAndHold(model.title, model.index, model.id, model.userName)
            }
            Component.onCompleted: {
                height=columnLayout.height+enguia.height*0.05
            }
        }
		section.property: "startDate"
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
	function append(eNew) {
		menuModel.append({content:eNew.content, "title":eNew.title,"userName":eNew.from, "backColor":'#e7e3e7', "id":eNew.id,"showDelete":false,backColor:"transparent", startDate:eNew.startDate, endDate:eNew.endDate})
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
                modelItem.backColor="gray";
            }
        }
    }
    function clear(){
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



import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
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

Item{
    property variant pressedAndHoldItem : null
    property alias listModel: listModel
	property bool loading:false
	signal listItemClicked(int id, int userID, int placeID)
	signal listItemPressAndHold(int id, int userID, int placeID)
	signal sigBtnDeleteClicked(int id,int userID, int placeID);
	property int pageNumber:0
	signal sigEndOfListReached()

    ListModel{
        id: listModel
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
        model: listModel
        clip: true
        delegate:  Item{
            id: listItem
            height: enguia.screenHeight*0.1
            property variant itemData: model
            anchors{left:parent.left;right: parent.right;}
            Image{
                id: imagem
                anchors{left: parent.left;verticalCenter: parent.verticalCenter}
                source: model.image
				width: listItem.height-imgSeparator.height
				height: listItem.height-imgSeparator.height
                onStatusChanged: if (status == Image.Error)source="qrc:///SharedImages/unknownpicture.png"
            }
            ColumnLayout{
                id: columnLayout
                anchors{left:imagem.right;leftMargin:enguia.smallMargin;verticalCenter:parent.verticalCenter;right:parent.right;rightMargin: enguia.mediumMargin}
                Label{
                    id: mainText
                    font{weight: Font.Bold;pointSize: enguia.largeFontPointSize}
                    color: "black"
                    text: model.name                    
					elide: Text.ElideRight
					Layout.fillWidth: true
                }
                Label{
                    id: subText
                    font{pointSize: enguia.smallFontPointSize}
                    text: model.brief
					color:"#616161"
                    elide: Text.ElideRight
                    Layout.fillWidth: true
					visible: text.length>0
                }
				Label{
					id: lblDisabled
					font{pointSize: enguia.tinyFontPointSize}
					text: enguia.tr("Place is currently disabled")
					color: "#B71C1C"
					visible: model.enabled===false
				}
            }
            Rectangle{
                id: imgSeparator
                anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height:enguia.separatorHeight
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
				onSigClicked: sigBtnDeleteClicked(model.id,model.userID, model.placeID)
            }
            MouseArea{
                id: mouseArea
                anchors.fill: parent
				enabled: !model.showDelete
				onClicked: {
					if(model.enabled===false)return;
					listItemClicked(model.id,model.userID, model.placeID)
				}
				onPressAndHold: listItemPressAndHold(model.id, model.userID, model.placeID)
            }
			Component.onCompleted: {
				var itensHeight=columnLayout.height+imgSeparator.height+enguia.height*0.02
				if(itensHeight>listItem.height)listItem.height=itensHeight
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
	function append(favoriteID, userID, placeID, name, brief, enabled){
		var img=mSFiles.getBannerThumbUrl(placeID,userID).toString();
		listModel.append({id:favoriteID,
							 userID:userID,
							 placeID:placeID,
							 name:name,
							 brief:brief,
							 image:img,
							 enabled:enabled,
							 showDelete:false})
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
	function clear(){
		pageNumber=0;
		listModel.clear();
	}
    function removeCurrent(){
        listModel.remove(listView.currentIndex);
    }
    function reset(){
        listModel.clear();
    }
}

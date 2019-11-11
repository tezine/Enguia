import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.1
import com.tezine.enguia 1.0
import "qrc:///Scripts/Defines.js" as Defines

Item{
    clip: true
    property alias listModel: menuModel
    signal listItemClicked(string value, string name, int id, string urlPath)
    signal listItemPressAndHold(string value, string name, int index, int id)
    signal sigBtnDeleteClicked(int id);

    ListModel{
        id: menuModel
    }
    ListView{
        id: listView
        anchors.fill: parent
        model: menuModel
        clip: true
        delegate:  Rectangle{
            id: listItem
            height: mCommon.height*0.1
            color: "transparent"
            anchors{left: parent.left; right: parent.right;}
            Image{
                id: imagem
                anchors{left: parent.left;leftMargin: mCommon.mediumMargin;verticalCenter: parent.verticalCenter}
                source: model.image
                width: listItem.height*0.8
                height: listItem.height*0.8
                asynchronous: true
            }
            Column{
                id: column
                anchors{left: imagem.right; leftMargin: mCommon.mediumMargin; verticalCenter: parent.verticalCenter; right:parent.right; rightMargin: mCommon.mediumMargin}
                Label{
                    id: lblName
                    font{pointSize: mCommon.largeFontPointSize;}
                    color: mCommon.fontColor
                    text: model.title
                }
                Label{
                    id: lblDescription
                    text: model.urlPath
                    font{pointSize: mCommon.tinyFontPointSize}
                    color: "black"
                    visible: text != ""
                    wrapMode:Text.WordWrap
                }
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
                onClicked: listItemClicked(model.value, model.title, model.id, model.urlPath)
                onPressAndHold: listItemPressAndHold(model.value, model.title, model.index, model.id)
            }
            Rectangle {
               id: separator
               color: "lightgray";
               anchors{bottom:listItem.bottom}
               width: parent.width
               // Only show the section separator when we are the beginning of a new section
               // Note that for this to work nicely, the list must be ordered by section.
               height: listView.ListView.prevSection != listView.ListView.section ? mCommon.height*0.002 : 0
               opacity: listView.ListView.prevSection != listView.ListView.section ? 1 : 0
               Text {
                   text: listView.ListView.section; font.bold: true
                   x: 2; height: parent.height; verticalAlignment: 'AlignVCenter'
               }
           }
        }
    }
    VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
        anchors.right: listView.right
        anchors.top: parent.top
    }
    /*ScrollDecorator{
        flickableItem: listView
    }*/
    Timer {
        id: tmr
        interval: 5000
        repeat: false
        running: false
        onTriggered: {
            for(var i=0;i<menuModel.count;i++) {
                var modelItem=menuModel.get(i);
                modelItem.showDelete=false;
                modelItem.backColor=mCommon.backColor;
            }
        }
    }
    function append(title, urlPath, value, image, id, showArrow) {
        menuModel.append({"title":title,"value":value,"urlPath":urlPath, "image":image, "backColor":mCommon.backColor, "id":id, "showArrow":showArrow,  "showDelete":false})
    }
    function remove(id){
        for(var i=0;i<menuModel.count;i++) {
            if(menuModel.get(i).id===id) {
                menuModel.remove(i);
                break;
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
    function clear(){
        menuModel.clear();
    }
}

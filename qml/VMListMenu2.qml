import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Item{
    clip: true
    property alias listModel: menuModel
    property alias visibleArea: listView.visibleArea
    property alias listView: listView
    property bool displayCounter: false
    signal listItemClicked(string name, int id, string value)
    signal listItemPressAndHold(string name, int index, int id, string value)

    ListModel{
        id: menuModel
    }
    ListView{
        id: listView
        anchors.fill: parent
        model: menuModel
        clip: true
        delegate:  Item{
            id: listItem
            height: enguia.screenHeight*0.09
            anchors{left: parent.left; leftMargin: enguia.mediumMargin ; right: parent.right; rightMargin: enguia.smallMargin}
            Image{
                id: imagem
                anchors{left: parent.left;verticalCenter: parent.verticalCenter}
                source: model.img
                width: listItem.height*0.9
                height: listItem.height*0.9
                asynchronous: true
            }
            Label{
                id: mainText
                anchors{left: imagem.right; leftMargin: enguia.hugeMargin; verticalCenter:parent.verticalCenter}
                font{pointSize: enguia.hugeFontPointSize;weight: Font.Bold}
                color: "black"
                text: model.title
            }
            Label{
                id: lblCounter
                anchors{right:arrowImage.left; leftMargin: enguia.smallMargin; verticalCenter: parent.verticalCenter}
                text: model.counter?model.counter.toString():""
                font{pointSize: enguia.mediumFontPointSize}
                color: enguia.secondLineFontColor
                visible: displayCounter
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
                onClicked: listItemClicked(model.title, model.id, model.value)
                onPressAndHold: listItemPressAndHold(model.title, model.index, model.id, model.value)
            }
        }
    }
    VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
        anchors.right: listView.right
        anchors.top: parent.top
    }
    function append(title, value, id,img,counter) {
        menuModel.append({"title":title,"value":value, "backColor":'#e7e3e7', "id":id,"img":img,"counter":counter})
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
    }
}



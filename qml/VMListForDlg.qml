import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Item{
    clip: true
    property alias listModel: menuModel
    signal listItemClicked(string value, string name, int id, string image)
    signal listItemPressAndHold(string value, string name, int index, int id)

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
            height: enguia.screenHeight*0.1
            anchors{left: parent.left; leftMargin: enguia.mediumMargin ; right: parent.right; rightMargin: enguia.imenseMargin}
            Image{
                id: imagem
                anchors{left: parent.left;verticalCenter: parent.verticalCenter}
                source: model.image
                width: listItem.height*0.9
                height: listItem.height*0.9
                asynchronous: true
            }
            Label{
                id: mainText
                anchors{left: imagem.right; leftMargin: enguia.hugeMargin; verticalCenter:parent.verticalCenter}
                font{pointSize: enguia.hugeFontPointSize;}
                color: "black"
                text: model.title
            }
            MouseArea{
                id: mouseArea
                anchors.fill: parent
                onClicked: listItemClicked(model.value, model.title, model.id, model.image)
                onPressAndHold: listItemPressAndHold(model.value, model.title, model.index, model.id)
            }
        }
    }
    /*ScrollDecorator{
        flickableItem: listView
    }*/
    function append(title, value, image, id) {
        menuModel.append({"title":title,"value":value,"image":image, "backColor":'#e7e3e7', "id":id})
    }
    function remove(id){
        for(var i=0;i<menuModel.count;i++) {
            if(menuModel.get(i).id===id) {
                menuModel.remove(i);
                break;
            }
        }
    }
}

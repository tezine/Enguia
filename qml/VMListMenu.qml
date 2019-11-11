import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Item{
    clip: true
    property alias listModel: menuModel
    property alias visibleArea: listView.visibleArea
    property alias listView: listView
    signal listItemClicked(string name, int id)
    signal listItemPressAndHold(string name, int index, int id)

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
            anchors{left: parent.left; leftMargin: enguia.mediumMargin ; right: parent.right; rightMargin: enguia.mediumMargin}
            Label{
                id: mainText
                anchors{left: parent.left; leftMargin: enguia.hugeMargin; verticalCenter:parent.verticalCenter}
                font{pointSize: enguia.hugeFontPointSize;weight: Font.Bold}
                color: "black"
                text: model.name
            }
            Image{
                id: arrowImage
                source: "qrc:///Images/next.png"
                width: listItem.height*0.9
                height: listItem.height*0.9
                anchors{right: parent.right;verticalCenter: parent.verticalCenter}
            }
            Rectangle{
                id: imgSeparator
                anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
                height:1
                color:"lightgray"
            }
            MouseArea{
                id: mouseArea
                anchors.fill: parent
                onClicked: listItemClicked(model.name, model.id)
                onPressAndHold: listItemPressAndHold(model.name, model.index, model.id)
            }
        }
    }
    VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
        anchors.right: listView.right
        anchors.top: parent.top
    }
    function append(id, name, description, startDate, endDate) {
        menuModel.append({id:id, name:name, description:description, startDate:startDate, endDate:endDate})
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

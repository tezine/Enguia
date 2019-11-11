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
    clip: true
    property alias listModel: menuModel
    signal listItemClicked(int id, string name)
    signal listItemPressAndHold(int id, string name, int index)

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
            anchors{left: parent.left; leftMargin: enguia.mediumMargin ; right: parent.right; rightMargin: enguia.hugeMargin}
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
                anchors{left: imagem.right; leftMargin: enguia.mediumMargin; verticalCenter:parent.verticalCenter}
                font{pointSize: enguia.largeFontPointSize;weight: Font.Bold}
                color: "black"
                text: model.title
            }
            Image{
                id: arrowImage
                source: "qrc:///Images/arrow.png"
                anchors{right: parent.right;verticalCenter: parent.verticalCenter}
            }
            MouseArea{
                id: mouseArea
                anchors.fill: parent
                onClicked: listItemClicked(model.tableID, model.title)
                onPressAndHold: listItemPressAndHold(model.tableID, model.title, model.index)
            }
        }
    }
    /*ScrollDecorator{
        flickableItem: listView
    }*/
    function append(title, id, image) {
        menuModel.append({"title":title,"tableID":id,"image":image})
    }
}

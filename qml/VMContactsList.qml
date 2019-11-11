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

Rectangle {
    clip: true
    property alias listModel: listModel
	signal listItemClicked(int placeID, int userID, string name)

    ListModel {
        id: listModel
    }
    ListView {
        id: listView
        anchors.fill: parent
        anchors.topMargin: 0
        model: listModel
        clip: true
        delegate:  Item {
            id: listItem
            height: enguia.screenHeight*0.09
            anchors{left: parent.left;  right: parent.right;}
            Label {
                id: mainText
                anchors { left: parent.left; leftMargin: enguia.mediumMargin; verticalCenter: parent.verticalCenter }
                font { pointSize:enguia.largeFontPointSize;weight: Font.Bold }
                color: "black"
				text: model.name
            }
            Rectangle{
                id: imgSeparator
                anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
                height:1
                color:"lightgray"
            }
            MouseArea {
                id: mouseArea
                anchors.fill: parent
				onClicked: listItemClicked(model.placeID, model.userID, model.name);
            }
        }
    }
    VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
        anchors.right: listView.right
        anchors.top: parent.top
    }
	function append(placeID, userID, name) {
		listModel.append({placeID:placeID, userID:userID, name:name})
    }
    function clear(){
        listModel.clear();
    }
}

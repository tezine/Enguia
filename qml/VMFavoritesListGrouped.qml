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
	property bool loading:false
    signal listItemClicked(int id, string name)
    signal listItemPressAndHold(int id, string name, int index)
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
        delegate:  Item{
            id: listItem
            height: enguia.screenHeight*0.1
			anchors{left: parent.left; right: parent.right; }
            Label{
                id: mainText
				anchors{left: parent.left; leftMargin: enguia.hugeMargin; verticalCenter:parent.verticalCenter}
                font{pointSize: enguia.largeFontPointSize;weight: Font.Bold}
                color: "black"
                text: model.title
            }
            Image{
                id: arrowImage
                source: "qrc:///Images/next.png"
				anchors{right: parent.right; rightMargin: enguia.smallMargin; verticalCenter: parent.verticalCenter}
				width: listItem.height*0.5
				height: listItem.height*0.5
				sourceSize.width: width
				sourceSize.height: height
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
                onClicked: listItemClicked(model.tableID, model.title)
                onPressAndHold: listItemPressAndHold(model.tableID, model.title, model.index)
            }
            Component.onCompleted: {
                var itensHeight=mainText.height+imgSeparator.height+enguia.height*0.02
                if(itensHeight>listItem.height)listItem.height=itensHeight
            }
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
    function append(title, id, image) {
        menuModel.append({"title":title,"tableID":id,"image":image})
    }
	function clear(){
		menuModel.clear();
		pageNumber=0;
	}
}


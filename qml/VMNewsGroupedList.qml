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
	signal listItemClicked(int placeID, string placeName)
	signal listItemPressAndHold(int placeID, string placeName, int index)
    signal sigBtnDeleteClicked(int placeID);
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
            anchors{left: parent.left ; right: parent.right;}
            Image{
                id: imagem
                anchors{left: parent.left;verticalCenter: parent.verticalCenter}
                source: mSFiles.getBannerThumbUrl(model.placeID).toString();
                width: listItem.height
                height: listItem.height
                onStatusChanged: if (status == Image.Error)source="qrc:///SharedImages/unknownpicture.png"
            }
            Label{
                id: mainText
                anchors{left: imagem.right; leftMargin: enguia.mediumMargin; verticalCenter:parent.verticalCenter}
				font{pointSize: enguia.largeFontPointSize;weight: Font.Bold}
                color: "black"
                text: model.contactName
            }
            Image{
                id: arrowImage
                source: "qrc:///Images/next.png"				
				width: listItem.height*0.5
				height: listItem.height*0.5
                anchors{right: parent.right;verticalCenter: parent.verticalCenter}
            }
            Label{
                id: lblCounter
                anchors{right:arrowImage.left; leftMargin: enguia.smallMargin; verticalCenter: parent.verticalCenter}
                text: model.unreadCount?model.unreadCount.toString():""
                font{pointSize: enguia.mediumFontPointSize}
                color: enguia.secondLineFontColor
                visible: unreadCount>0?true:false
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
                onClicked: listItemClicked(model.placeID, model.contactName)
                onPressAndHold: listItemPressAndHold(model.placeID, model.contactName, model.index)
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
	function append(eNewGrouped) {
		menuModel.append({placeID:eNewGrouped.placeID, contactID:eNewGrouped.contactID, contactName:eNewGrouped.contactName, unreadCount:eNewGrouped.unreadCount,showDelete:false})
    }        
	function clear(){
		pageNumber=0;
		menuModel.clear()
	}
}

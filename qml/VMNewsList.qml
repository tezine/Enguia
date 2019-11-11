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
    property alias listModel: listModel
    signal listItemClicked(int id, int userID, int contactID, int index)
    signal listItemPressAndHold(int id, int index, int userID, int contactID)
	property int pageNumber:0
	signal sigEndOfListReached()

    ListModel{
        id: listModel
    }
	VMListEmptyRect{
		id: listEmptyRect
		anchors{left:parent.left;right:parent.right;top:parent.top}
		visible: listModel.count===0
		title: enguia.tr("No records");
	}
    ListView{
        id: listView
        anchors.fill: parent
        model: listModel
        clip: true
        delegate:  Item{
            id: listItem
            width: parent.width
            height: enguia.screenHeight*0.1
            anchors{left: parent.left ; right: parent.right; }
            Image{
                id: imagem
                anchors{left: parent.left;verticalCenter: parent.verticalCenter}
                source: mSFiles.getBannerThumbUrl(model.id).toString();
                width: listItem.height
                height: listItem.height
                onStatusChanged: if (status == Image.Error)source="qrc:///SharedImages/unknownpicture.png"
            }
            ColumnLayout{
                id: columnLayout
                anchors{left:imagem.right;leftMargin:enguia.mediumMargin;verticalCenter:parent.verticalCenter;right:parent.right; rightMargin: enguia.mediumMargin}
                Label{
                    id: lblName
                    font{pointSize: enguia.mediumFontPointSize;bold: true}
                    text: model.contactName
                    color: "black"
                    visible: !isLoadNext
                }
                Label{
                    id: mainText
                    color: "indigo"
                    font{pointSize: enguia.smallFontPointSize}
                    text: model.content
                    Layout.fillWidth: true
                    wrapMode: Text.WrapAnywhere
                    visible: !isLoadNext
                }
            }
            /*VLikeRect{
                id: lblLikes
                anchors{right: parent.right;top: parent.top; topMargin: 5}
                value: model.likesCount.toString()
                visible: !isLoadNext
            }*/
            Label{
                id: lblLoadNext
                anchors{left: parent.left;leftMargin: enguia.mediumMargin; verticalCenter: parent.verticalCenter}
                font{weight: Font.Bold;pointSize: enguia.largeFontPointSize}
                color: "black"
                text: content
                visible: isLoadNext
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
				height:enguia.separatorHeight
				color:enguia.sectionRectColor
            }
            MouseArea{
                id: mouseArea
                anchors.fill: parent
				onClicked: listItemClicked(model.id, model.userID, model.contactID, model.index)
                onPressAndHold: listItemPressAndHold(model.id, model.index, model.userID, model.contactID)
            }
            Component.onCompleted:{
               // var labelsHeight=mainText.height+lblName.height+ enguia.height*0.05;
               // listItem.height=labelsHeight
            }
        }
		section.property: "startDate"
        section.criteria: ViewSection.FullString
		section.delegate: VSharedListSection{
			text: Qt.formatDate(section,Qt.SystemLocaleShortDate)
		}
		onAtYEndChanged: {
			if(listModel.count<enguia.listCount)return;
			if(atYEnd) sigEndOfListReached()
		}
    }
    /*Banner{
        id: bannerNews
    }
    ScrollDecorator{
        flickableItem: listView
    }*/
    function append(id, userID, contactID, groupID, contactName, contactIcon, content, dateInserted, likesCount){
        listModel.append({"id":id,
            "userID":userID,
            "contactID":contactID,
            "contactName":contactName,
            "contactIcon":contactIcon,
            "content":content,
			"startDate":Qt.formatDate(dateInserted,Qt.DefaultLocaleShortDate),
            "likesCount":likesCount,
        isLoadNext:false})
    }
	function clear(){
        listModel.clear();
    }
}


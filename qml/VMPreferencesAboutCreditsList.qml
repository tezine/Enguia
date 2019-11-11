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
    property alias mymodel: listModel

    ListModel{
        id: listModel
    }
    ListView{
        id: listView
        anchors.fill: parent
        model: listModel
        clip: true
        cacheBuffer: 1
        delegate:  Item{
            id: listItem
            height: enguia.screenHeight*0.09
            width: parent.width
			ColumnLayout{
				id: columnLayout
				anchors{left:parent.left;leftMargin:enguia.mediumMargin;verticalCenter:parent.verticalCenter;right:parent.right;rightMargin: enguia.mediumMargin}
				Label{
					id: mainText
					font{weight: Font.Bold;pointSize: enguia.largeFontPointSize}
					color: "black"
					text: model.name
					visible: !isLoadNext
					Layout.fillWidth: true
					wrapMode: Text.Wrap
				}
				Label{
					id: lblLink
					font{pointSize:enguia.smallFontPointSize;}
					color: "gray"
					text: model.link
					Layout.fillWidth: true
					wrapMode: Text.Wrap
				}
				Label{
					id: subText
					font{pointSize: enguia.tinyFontPointSize}
					text: model.description
					color: "gray"
					wrapMode: Text.Wrap
					visible: text.length>0
					Layout.fillWidth: true
				}
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
            }
            Component.onCompleted:{
				var itensHeight=columnLayout.height+imgSeparator.height+ enguia.height*0.02
				if(itensHeight>listItem.height)listItem.height=itensHeight
            }
        }
    }
    VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
        anchors.right: listView.right
        anchors.top: parent.top
    }
	function append(eCredit){
		listModel.append({"tableID":eCredit.id,"name":eCredit.name,"description":eCredit.description,"link":eCredit.link})
	}
}

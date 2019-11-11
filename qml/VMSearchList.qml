import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Shared"
import "qrc:/Components"

Item{
    clip: true
    property alias listModel: listModel
    signal listItemClicked(int range)

    ListModel{
        id: listModel
    }
    ListView{
        id: listView
        anchors.fill: parent
        model: listModel
        clip: true
        delegate:  Item{
            id: listItem
			height: enguia.screenHeight*0.08
			anchors{left: parent.left;  right: parent.right;}
			/*Image{
                id: imagem
                anchors{left: parent.left;verticalCenter: parent.verticalCenter}
                source: model.image
                width: listItem.height*0.9
                height: listItem.height*0.9
                asynchronous: true
			}*/
            Label{
                id: mainText
				anchors{left:parent.left; leftMargin: enguia.hugeMargin; verticalCenter:parent.verticalCenter}
				font{pointSize: enguia.hugeFontPointSize;}
                color: "black"
                text: model.title
            }
            Image{
                id: arrowImage
                source: "qrc:///Images/next.png"
				width: listItem.height*0.5
				height: listItem.height*0.5
				anchors{right: parent.right;rightMargin: enguia.smallMargin;verticalCenter: parent.verticalCenter}
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
                onClicked: listItemClicked(model.range)
            }
			Component.onCompleted: {
				var itensHeight=mainText.height+imgSeparator.height+ enguia.height*0.02
				if(itensHeight>listItem.height)listItem.height=itensHeight
			}
        }
    }
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
		anchors.right: listView.right
		anchors.top: parent.top
	}
}


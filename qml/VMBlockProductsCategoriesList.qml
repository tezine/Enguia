import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/BlockProducts"

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
			height: enguia.screenHeight*0.1
            anchors{left: parent.left; right: parent.right;}
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
				font{pointSize: enguia.largeFontPointSize;weight: Font.Bold}
				color: "black"
				text: model.title
			}
			Image{
				id: arrowImage
				width: listItem.height*0.5
				height: listItem.height*0.5
				source: "qrc:///Images/next.png"
				anchors{right: parent.right;rightMargin: enguia.smallMargin; verticalCenter: parent.verticalCenter}
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
	}
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
		anchors.right: listView.right
		anchors.top: parent.top
	}
	function append(title, id, image) {
		menuModel.append({"title":title,"tableID":id,"image":image})
	}
}


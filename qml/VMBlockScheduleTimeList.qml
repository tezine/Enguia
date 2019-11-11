import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"

Item{
	clip: true
	property alias listModel: menuModel
	property alias visibleArea: listView.visibleArea
	property alias listView: listView
	signal listItemClicked(string name, int status)
	signal listItemPressAndHold(string name, int index, int status)

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
				anchors{left: parent.left; right: parent.right; verticalCenter:parent.verticalCenter}
				font{pointSize: enguia.hugeFontPointSize;weight: Font.Bold}
				color: "black"
				wrapMode: Text.Wrap
				text: model.name
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
				onClicked: listItemClicked(model.name, model.status)
				onPressAndHold: listItemPressAndHold(model.name, model.index, model.status)
			}
		}
	}
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
		anchors.right: listView.right
		anchors.top: parent.top
	}
	function append(name, status) {
		menuModel.append({name:name, status:status})
	}
	function clear(){
		menuModel.clear();
	}
}

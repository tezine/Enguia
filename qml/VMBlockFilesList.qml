import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockFiles"

Item{
	clip: true
	property alias listModel: menuModel
	signal listItemClicked(int fileNumber)
	signal sigMinFilesSelected()
	signal listItemPressAndHold(double unitValue, string productName, int index, int id)

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
			height: enguia.height*0.1
			anchors{left:parent.left;leftMargin: enguia.mediumMargin;right:parent.right;rightMargin: enguia.mediumMargin;}
			RowLayout{
				height: btnFile.height;
				spacing: 0
				anchors{left:parent.left;right:parent.right;verticalCenter: parent.verticalCenter;}
				VSharedTextField{
					id: txtField
					Layout.fillWidth: true
					placeholderText: model.description
					text: model.filePath
				}
				VSharedButton{
					id: btnFile
					text:"..."
					width: parent.width*0.2
					onClicked: listItemClicked(model.fileNumber)
				}
			}
		}
	}
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
		anchors.right: listView.right
		anchors.top: parent.top
	}
	function checkIfMinFilesSelected(){
		var validFileCount=0;
		for(var i=0;i<menuModel.count;i++) {
			var row=menuModel.get(i);
			if(row.filePath.length>0)validFileCount++;
		}
		if(validFileCount>=eBlockFile.minFiles)sigMinFilesSelected()
	}
	function append(fileNumber, description) {
		menuModel.append({fileNumber:fileNumber, description:description, filePath:"" })
	}
	function setFilePath(fileNumber, filePath){
		var completePath=Qt.resolvedUrl("file:///"+filePath)
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).fileNumber===fileNumber){
				menuModel.get(i).filePath=completePath;
				break;
			}
		}
		checkIfMinFilesSelected();
	}
	function clear(){
		menuModel.clear();
	}
}

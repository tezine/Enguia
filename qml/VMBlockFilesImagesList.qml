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
			height: enguia.width*0.7
			width: enguia.width*0.9
			anchors{horizontalCenter: parent.horizontalCenter;}
			Rectangle{
				width:parent.width
				height: parent.height*0.9
				anchors{horizontalCenter: parent.horizontalCenter;}
				border{color: "lightgray";width: 1}
				radius: 10
				BorderImage{
					id: background
					anchors{fill: parent;leftMargin: -parent.anchors.leftMargin;rightMargin: -parent.anchors.rightMargin}
					visible: mouseArea.pressed
				}
				ColumnLayout{
					anchors.fill: parent
					spacing: 0
					Label{
						id: lblDescription
						color:"#484B4E"
						font{pointSize: enguia.imenseFontPointSize; bold:false}
						horizontalAlignment: Text.AlignHCenter
						text: model.description
						Layout.fillWidth: true
						verticalAlignment: Text.AlignVCenter
					}
					Rectangle{
						id: imgSeparator
						Layout.fillWidth: true
						height:1
						color:"lightgray"
					}
					Rectangle{
						id: rectSelect
						visible: model.btnSelectVisible
						color:"#EEEEEE"
						Layout.fillHeight: true
						Layout.fillWidth: true;
						Label{
							id: lblSelect
							anchors.fill: parent
							font{pointSize: enguia.largeFontPointSize;bold:true}
							horizontalAlignment: Text.AlignHCenter
							verticalAlignment: Text.AlignVCenter
							text:enguia.tr("Select")
							color:"#2096F2"
						}
						MouseArea{
							id: mouseArea
							anchors.fill: parent
							onClicked: listItemClicked(model.fileNumber)
						}
					}
					Image{
						visible: (!rectSelect.visible)
						source: model.filePath
						asynchronous: true
						onStatusChanged:{
							if(status===Image.Ready){
								menuModel.get(model.index).fileValid=true;
								checkIfMinFilesSelected()
							}
							//if (status === Image.Error)visible=false
						}
						Layout.fillHeight: true
						Layout.fillWidth: true
					}
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
			if(row.fileValid)validFileCount++;
		}
		if(validFileCount>=eBlockFile.minFiles)sigMinFilesSelected()
	}
	function append(fileNumber, description) {
		menuModel.append({fileNumber:fileNumber, description:description, filePath:"", btnSelectVisible:true, fileValid:false })
	}
	function setFilePath(fileNumber, filePath){
		var completePath=Qt.resolvedUrl("file:///"+filePath)
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).fileNumber===fileNumber){
				menuModel.get(i).btnSelectVisible=false;
				menuModel.get(i).filePath=completePath;
				break;
			}
		}
	}
	function clear(){
		menuModel.clear();
	}
}

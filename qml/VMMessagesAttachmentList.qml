import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Messages"
import "qrc:/Shared"

Rectangle{
	clip: true
	color:"transparent"
	property alias listModel: menuModel
	property alias visibleArea: listView.visibleArea
	property alias listView: listView
	signal listItemClicked(int id, string fileName)
	signal listItemPressAndHold(int id, string fileName)
	signal sigBtnDeleteClicked(string fileName)

	ListModel{
		id: menuModel
	}
	VMListEmptyRect{
		id: listEmptyRect
		anchors{left:parent.left;right:parent.right;top:parent.top}
		visible: menuModel.count===0
		title: enguia.tr("No records");
	}
	Label{
		id: lblTitle
		text: enguia.tr("Attachments")
		font.pointSize: enguia.mediumFontPointSize
		anchors{left:parent.left;right:parent.right;}
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		color: "#484B4E"
	}
	ListView{
		id: listView
		anchors{left:parent.left;right:parent.right;top:lblTitle.bottom;bottom:parent.bottom;}
		model: menuModel
		clip: true
		delegate:  Rectangle{
			id: listItem
			anchors{left: parent.left; right: parent.right; }
			color:model.backColor
			ColumnLayout{
				anchors{left: parent.left; leftMargin: enguia.mediumMargin; verticalCenter:parent.verticalCenter;right:parent.right;rightMargin: enguia.mediumMargin}
				Label{
					id: mainText
					font{pointSize: enguia.mediumFontPointSize;}
					Layout.fillWidth: true
					color: "black"
					elide: Text.ElideRight
					text: model.fileName
				}
				Label{
					id: lblFileSize
					font{pointSize: enguia.smallFontPointSize}
					Layout.fillWidth: true
					color: "#616161"
					text: model.fileSize
					elide: Text.ElideRight
				}
			}
			VMListButton{
				id: deleteImage
				z: 100
				width: listItem.height*0.9
				height: listItem.height*0.9
				anchors{right:parent.right;verticalCenter: parent.verticalCenter;}
				source: "qrc:///Images/delete.png"
				visible: model.showDelete?true:false
				onSigClicked: sigBtnDeleteClicked(model.fileName)
			}
			Rectangle{
				id: rectSeparator
				anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height:1
				color:"lightgray"
			}
			MouseArea{
				id: mouseArea
				anchors.fill: parent
				onClicked: listItemClicked(model.id, model.fileName)
				onPressAndHold: {				
					listItemPressAndHold(model.id, model.fileName)
				}
			}
			Component.onCompleted: {
				var itensHeight=mainText.height+lblFileSize.height+rectSeparator.height+ enguia.height*0.02
				listItem.height=itensHeight
			}
		}
	}
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
		anchors.right: listView.right
		anchors.top: parent.top
	}
	MSTimer {
		id: tmr
		onTriggered: {
			for(var i=0;i<menuModel.count;i++) {
				var modelItem=menuModel.get(i);
				modelItem.showDelete=false;
				modelItem.backColor="transparent"
			}
		}
	}
	function append(eMessageFile) {
		var fileSize="";
		if(eMessageFile.fileSize<1000)fileSize=eMessageFile.fileSize+" bytes"
		else if(eMessageFile.fileSize>1000 && eMessageFile.fileSize<1000000)fileSize=Math.round(eMessageFile.fileSize/1000)+"Kb";
		else if(eMessageFile.fileSize>1000000)fileSize=Math.round(eMessageFile.fileSize/1000000)+"Mb";
		menuModel.append({id:eMessageFile.id, fileName:eMessageFile.fileName, fileSize:fileSize,backColor:"transparent",localFilePath:"",showDelete:false})
	}
	function appendLocalFile(completeFilePath){
		var fileName=mSFiles.getFileName(completeFilePath);
		var fileSize=mSFiles.getFileSize(completeFilePath);
		if(fileSize<1000)fileSize=fileSize+" bytes"
		else if(fileSize>1000 && fileSize<1000000)fileSize=Math.round(fileSize/1000)+"Kb";
		else if(fileSize>1000000)fileSize=Math.round(fileSize/1000000)+"Mb";
		menuModel.append({id:0,fileName:fileName,fileSize:fileSize,backColor:"transparent",localFilePath:completeFilePath,showDelete:false})
	}
	function showDelete(fileName){
		tmr.stop();
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).fileName===fileName) {
				var modelItem=menuModel.get(i);
				modelItem.showDelete=true;
				modelItem.backColor=enguia.sectionRectColor
				tmr.start(5000);
				break;
			}
		}
	}
	function remove(fileName){
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).fileName===fileName) {
				menuModel.remove(i);
				break;
			}
		}
	}
}

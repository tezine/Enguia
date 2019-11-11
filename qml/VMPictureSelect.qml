import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"

Rectangle{
	width:parent.width
	height: parent.height*0.3
	anchors{horizontalCenter: parent.horizontalCenter;}
	border{color: "lightgray";width: 1}
	radius: 10
	property bool btnSelectVisible:true
	property string imgURL:""
	signal sigBtnFileSelected(string completeLocalPath)

	Rectangle{
		id: rectSelect
		anchors.fill: parent
		visible: btnSelectVisible
		color:"#EEEEEE"
		Label{
			id: lblSelect
			anchors.fill: parent
			font{pointSize: enguia.largeFontPointSize;bold:true}
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			text:enguia.tr("Select")
			color:"#2096F2"
		}
		Image{
			id:img
			source: imgURL
			asynchronous: true
			width: parent.width
			height: parent.height
			sourceSize.height: parent.height
			sourceSize.width: parent.width
			onStatusChanged:{
				if(status===Image.Ready){
					img.visible=true;
				}else{
					img.visible=false;
				}
				//if (status === Image.Error)visible=false
			}
		}
		MouseArea{
			id: mouseArea
			anchors.fill: parent
			onClicked: dlgFiles.setup("*.jpg",true);
		}
	}
	VMDlgFileSelection{
		id: dlgFiles
		onSigFileSelected: sigBtnFileSelected(absoluteFilePath);
	}
}


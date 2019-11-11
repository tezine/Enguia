import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/UserBlockPictures"

Rectangle {
	id:rect
	color:"gray"
	property int blockID:0

	VSharedPageTitle{
		id:pageTitle
		title:enguia.tr("Pictures")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
	}
	ListModel{
		id: picsModel
	}
	GridView{
		id: grid1Pics
		anchors{top: pageTitle.bottom;bottom: parent.bottom;left: parent.left;right: parent.right;topMargin: enguia.mediumMargin;}
		cellWidth: parent.width/3;
		cellHeight:parent.width/3;
		clip: true
		model: picsModel
		delegate: Rectangle{
		   width: rect.width/3;
		   height: rect.width/3;
		   border{color: "black";width: 1}
		   radius: 10
			BorderImage{
				id: background
				anchors{fill: parent;leftMargin: -parent.anchors.leftMargin;rightMargin: -parent.anchors.rightMargin}
				visible: mouseArea.pressed
			}
			Image{
				anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter}
				width: rect.width/3.1;
				height: rect.width/3.1;
				source: model.pictureURL
				asynchronous: true
			}
			MouseArea{
				id: mouseArea
				anchors.fill: background
				onClicked: swipeDlg.setup(picsModel,model.index)
			}
		}
	}
	VSharedSwipeDlg{
		id: swipeDlg
	}
	Component.onCompleted: {
		picsModel.clear();
		mSVC.metaInvoke(MSDefines.SUserPictures,"GetUserPictures",function(list){
			for(var i=0;i<list.length;i++){
				var eUserPicture=list[i];
				picsModel.append({"picID":eUserPicture.picNumber, name:eUserPicture.name, description:eUserPicture.description, pictureURL:mSFiles.getUserPictureUrl(mShared.otherUserID, blockID,eUserPicture.id),
									 "author":"",bigPath:'',fileName:''})
			}
		},blockID);
	}
}

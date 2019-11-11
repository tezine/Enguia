import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"

Dialog {
	id: dlg
	visible:false
	modality: Qt.NonModal
	signal sigItemsSelected(var selectedList)

	contentItem: Rectangle {
		implicitWidth:enguia.width*0.8
		implicitHeight:enguia.height*0.7
		VMListMulti{
			id: sharedList
			anchors{top:parent.top;left:parent.left;right:parent.right;bottom:rectCancel.top;}
		}
		Rectangle{
			id: rectCancel
			border.color: "lightgray"
			border.width: 1
			anchors{left:parent.left;bottom:parent.bottom;}
			height: enguia.height*0.08
			width: (parent.width/2)
			Label{
				text:enguia.tr("Cancel")
				anchors.fill: parent
				font.pointSize: enguia.largeFontPointSize
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
			}
			MouseArea{
				anchors.fill: parent
				onClicked: close();
			}
		}
		Rectangle{
			id: rectAccept
			border.color: "lightgray"
			border.width: 1
			anchors{left:rectCancel.right;bottom:parent.bottom;}
			height: enguia.height*0.08
			width: (parent.width/2)
			Label{
				text:enguia.tr("Ok")
				anchors.fill: parent
				font.pointSize: enguia.largeFontPointSize
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
			}
			MouseArea{
				anchors.fill: parent
				onClicked: {
					var listModel=sharedList.listModel;
					var selectedList=[]
					for(var i=0;i<listModel.count;i++){
						if(listModel.get(i).itemSelected){
							var itemSelected={id:listModel.get(i).id, name:listModel.get(i).name};
							selectedList[selectedList.length]=itemSelected;
						}
					}
					sigItemsSelected(selectedList)
					close();
				}
			}
		}		
	}
	Component.onCompleted: {
		sharedList.append(MSDefines.BlockVisibilityMyself,enguia.tr("Myself"))
		sharedList.append(MSDefines.BlockVisibilityFamily,enguia.tr("Family"))
		sharedList.append(MSDefines.BlockVisibilityBestFriends,enguia.tr("Best friends"))
		sharedList.append(MSDefines.BlockVisibilityFriends,enguia.tr("Friends"))
		sharedList.append(MSDefines.BlockVisibilityFellowWorker,enguia.tr("Fellow worker"))
		sharedList.append(MSDefines.BlockVisibilityOthers,enguia.tr("Others"))
	}
}

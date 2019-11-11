import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"

Rectangle {
	signal listItemClicked(int orderType)
	height: listView.height+columnLayout.height

	ListModel{
		id: menuModel
	}
	ListView{
		id: listView
		anchors{left:parent.left;right:parent.right;top:parent.top;}
		height: enguia.screenHeight*0.2
		model: menuModel
		clip: true
		delegate:  Item{
			id: listItem
			height: enguia.screenHeight*0.1
			anchors{left: parent.left; right: parent.right;}
			ColumnLayout{
				anchors{left:parent.left; leftMargin: enguia.hugeMargin; verticalCenter:parent.verticalCenter}
				anchors.right: parent.right
				Label{
					id: mainText
					font{pointSize: enguia.hugeFontPointSize;}
					color: "black"
					text: model.title
					verticalAlignment: Text.AlignVCenter
					Layout.fillHeight: true
					Layout.fillWidth: true
					Layout.alignment: Qt.AlignVCenter
					elide: Text.ElideRight
				}
				Text{
					id: lblSubTitle
					font{pointSize: enguia.smallFontPointSize}
					text:model.subtitle
					elide: Text.ElideRight
					Layout.fillWidth: true
					color: "gray"
					visible: text.length>0
				}
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
				onClicked: {
					switch(model.orderType){
						case MSDefines.OrderTypeExternal:
							listItemClicked(model.orderType)
							break;
						case MSDefines.OrderTypeInternal:
							if(mFlow.getPlaceOpenStatus()!==MSDefines.OpenStatusOpen){statusBar.displayError(enguia.tr("Place is closed"));return;}
							columnLayout.visible=true;
							break;
					}
				}
			}
		}
	}
	ColumnLayout{
		id:columnLayout
		visible: false
		anchors{left:parent.left;right: parent.right;top:listView.bottom;}
		VMTextField{
			id:txtPassword
			Layout.fillWidth: true
			placeholderText: enguia.tr("Type your table password")
		}
		VMButton{
			Layout.fillWidth: true
			text: enguia.tr("Next")
			onClicked: checkTablePassword()
		}
	}
	function checkTablePassword(){
		if(txtPassword.text.length!=4){statusBar.displayError(enguia.tr("Password must have 4 chars"));return;}
		mSVC.metaInvoke(MSDefines.SPlaceTables,"CheckTablePassword",function(tableID){
			if(tableID>0){
				mSOrder.setTableID(tableID);
				listItemClicked(MSDefines.OrderTypeInternal)
			}
			else statusBar.displayError(enguia.tr("Invalid password"));
		},mShared.placeID,mShared.userID,txtPassword.text)
	}
	function hideExternalOrder(){
		menuModel.remove(0)
	}
	Component.onCompleted: {
		menuModel.append({orderType:MSDefines.OrderTypeExternal, title:enguia.tr("External order"),subtitle:enguia.tr("Order outside the place")})
		menuModel.append({orderType:MSDefines.OrderTypeInternal, title:enguia.tr("Internal order"),subtitle:enguia.tr("Order from inside the place")})
	}
}


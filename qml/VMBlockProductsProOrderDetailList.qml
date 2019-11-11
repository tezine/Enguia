import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/BlockProducts"

Rectangle{
	color:"transparent"

	ListModel{
		id: menuModel
	}
	ListView{
		id: listView
		anchors.fill: parent
		model: menuModel
		clip: true
		delegate:  Rectangle{
			id: listItem
			anchors{left: parent.left ; right: parent.right;}
			color:"transparent"
			ColumnLayout{
				id: columnLayout
				anchors{left: parent.left; leftMargin: enguia.mediumMargin; verticalCenter:parent.verticalCenter}
				Label{
					id: mainText
					font{pointSize: enguia.hugeFontPointSize}
					color: "black"
					text: model.amountAndName
					verticalAlignment: Text.AlignVCenter
					Layout.fillHeight: true
					Layout.alignment: Qt.AlignVCenter
				}
				Label{
					id: subOption1
					font{pointSize: enguia.smallFontPointSize;}
					color: "#616161"
					text: model.option1
					visible: text.length>0
				}
				Label{
					id: subOption2
					font{pointSize: enguia.smallFontPointSize;}
					color: "#616161"
					text: model.option2
					visible: text.length>0
				}
				Label{
					id: subOption3
					font{pointSize: enguia.smallFontPointSize;}
					color: "#616161"
					text: model.option3
					visible: text.length>0
				}
				Label{
					id: subAddons
					font{pointSize: enguia.smallFontPointSize;}
					color: "#616161"
					text: model.addons
					visible: text.length>0
				}
			}
			Rectangle{
				id: imgSeparator
				anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height:1
				color:"gray"
			}
			Component.onCompleted: {
				var itensHeight=columnLayout.height+enguia.height*0.02
				listItem.height=itensHeight
			}
		}
	}
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
		anchors.right: listView.right
		anchors.top: parent.top
	}
	function append(eOrderProduct){
		var amountAndName=eOrderProduct.amount.toString()+" "+eOrderProduct.productName;
		var option1, option2, option3,addons;
		option1=option2=option3=addons="";
		menuModel.append({amountAndName:amountAndName, option1:eOrderProduct.option1, option2:eOrderProduct.option2, option3:eOrderProduct.option3,addons:eOrderProduct.addOns})
	}
	function clear(){
		menuModel.clear()
	}
}

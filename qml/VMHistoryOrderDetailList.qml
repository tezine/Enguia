import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Events"
import "qrc:/Components"
import "qrc:/Contacts"
import "qrc:/Favorites"
import "qrc:/Messages"
import "qrc:/News"
import "qrc:/Preferences"
import "qrc:/Qualifications"
import "qrc:/Search"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/History"


Item{
	property alias listModel: listModel
	signal listItemClicked(int id, int index, string name,string countryName)

	ListModel{
		id: listModel
	}
	ListView{
		id: listView
		anchors.fill: parent
		model: listModel
		clip: true
		delegate:  Item{
			id: listItem
			height: enguia.height*0.07
			anchors{left: parent.left;right: parent.right;topMargin: enguia.mediumMargin }
			ColumnLayout{
				id: columnLayout
				anchors{left: parent.left; leftMargin:enguia.mediumMargin; verticalCenter:parent.verticalCenter}
				Label{
					id: mainText
					font{pointSize: enguia.mediumFontPointSize;bold:true}
					color: "black"
					text: productName
				}
				Label{
					id: lblOption1
					font{pointSize: enguia.smallFontPointSize;}
					color: "gray"
					text: option1Selected
					visible: text.length>0
				}
				Label{
					id: lblOption2
					font{pointSize: enguia.smallFontPointSize;}
					color: "gray"
					text: option2Selected
					visible: text.length>0
				}
				Label{
					id: lblOption3
					font{pointSize: enguia.smallFontPointSize;}
					color: "gray"
					text: option3Selected
					visible: text.length>0
				}
				Label{
					id: lblAddons
					font{pointSize: enguia.smallFontPointSize;}
					color: "gray"
					text: addOnsNamesList
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
				onClicked: listItemClicked(model.cityID, model.index, model.cityName,model.countryName)
			}
			Component.onCompleted: {
				var itensHeight=columnLayout.height+mainText.height
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
		var option1=eOrderProduct.option1;
		var option2=eOrderProduct.option2;
		var option3=eOrderProduct.option3;
		var addOns=eOrderProduct.addOns;
		listModel.append({productName:eOrderProduct.amount.toString()+" "+ eOrderProduct.productName,
							 option1Selected:option1,
							option2Selected:option2,
							option3Selected:option3,
							addOnsNamesList:addOns})
	}
}


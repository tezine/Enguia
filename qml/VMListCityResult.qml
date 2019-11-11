import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Item{
    property alias listModel: listModel
    signal listItemClicked(int id, int index, string name,string countryName)
	property int pageNumber:0
	signal sigEndOfListReached()

    ListModel{
        id: listModel
    }
	VMListEmptyRect{
		id: listEmptyRect
		anchors{left:parent.left;right:parent.right;top:parent.top}
		visible: listModel.count===0
		title: enguia.tr("No records");
	}
    ListView{
        id: listView
        anchors.fill: parent
        model: listModel
        clip: true
        delegate:  Item{
            id: listItem
            height: enguia.height*0.1
			anchors{left: parent.left;leftMargin:enguia.mediumMargin;  right: parent.right; rightMargin: enguia.mediumMargin}
            ColumnLayout{
				anchors{left: parent.left; leftMargin:enguia.smallMargin; verticalCenter:parent.verticalCenter}
                Label{
                    id: mainText
                    font{pointSize: enguia.mediumFontPointSize;bold:true}
                    color: "black"
                    text: cityName
                }
                Label{
                    id: txtState
                    font{pointSize: enguia.smallFontPointSize;}
                    color: "gray"
                    text: stateName.length>0?stateName+", "+countryName:countryName
                }
            }
            /*Label{
                id: txtCountry
                anchors{right:parent.right;rightMargin: enguia.mediumMargin;verticalCenter: parent.verticalCenter}
                font{pointSize: enguia.mediumFontPointSize}
                color: "darkorange"
                text: countryName
            }*/
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
                var itensHeight=mainText.height+txtState.height+enguia.height*0.02
				if(itensHeight>listItem.height)listItem.height=itensHeight
			}
        }
		onAtYEndChanged: {
			if(listModel.count<enguia.listCount)return;
			if(atYEnd) sigEndOfListReached()
		}
    }
    VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
        anchors.right: listView.right
        anchors.top: parent.top
    }
    function append(cityID, cityName,stateName,countryName){
        listModel.append({cityID:cityID, cityName:cityName, stateName:stateName,countryName:countryName})
    }
	function clear(){
		pageNumber=0;
		listModel.clear();
	}
}


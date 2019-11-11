import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
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

Item{
    property variant pressedAndHoldItem : null
    property alias listModel: listModel
	property bool loading:false
    signal listItemClicked(int id, int index)
    signal listItemPressAndHold(int id, int index)
	signal sigBtnDeleteClicked(int id)
	property int pageNumber:0
	signal sigEndOfListReached()

    ListModel{
        id: listModel
    }
	VMListEmptyRect{
		id: listEmptyRect
		anchors{left:parent.left;right:parent.right;top:parent.top}
		visible: listModel.count===0
		title: loading?enguia.tr("Loading..."): enguia.tr("No records");
	}
    ListView{
        id: listView
        anchors.fill: parent
        model: listModel
        clip: true
		//highlight: Rectangle { color: "steelblue" }
		//highlightMoveVelocity: 9999999
		delegate:  Item{
            id: listItem
            width: parent.width
            height: enguia.height*0.13
            property variant itemData: model
            Image{
                id: imagem
                anchors{left: parent.left;bottom: imgSeparator.top}
                source: mSFiles.getBannerThumbUrl(model.id).toString();
				width: listItem.height-imgSeparator.height
				height:listItem.height-imgSeparator.height				
                onStatusChanged: if (status == Image.Error)source="qrc:///SharedImages/unknownpicture.png"
            }
            ColumnLayout{
				id: columnLayout
				anchors{left: imagem.right;leftMargin: enguia.smallMargin;verticalCenter:parent.verticalCenter;right:parent.right;rightMargin: enguia.mediumMargin}
                spacing: 0
                Label{
                    id: mainText
                    font{pointSize: enguia.largeFontPointSize}
                    color: "black"
                    text: name
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                }
                VSharedRatingIndicator{
                    id: lblRating
					Layout.preferredHeight: enguia.height*0.02
					rowAnchors.left: lblRating.left//pq o padrao é centralizar
					Layout.preferredWidth: enguia.width*0.3
					rating: model.rating
					visible: rating!==-1//-1 means rating not enabled for the place
                }
				Label{
					id: lblCity
					font{pointSize: enguia.smallFontPointSize}
					color: "#212121"
					text: cityName
				}
                Label{
                    id: subText
                    font{pointSize: enguia.smallFontPointSize}
					Layout.fillWidth: true
                    text: brief
                    color: "gray"
                    visible: text != ""
                    elide: Text.ElideRight
                }
                Label{
                    id: lblViewCount
                    font{pointSize: enguia.tinyFontPointSize}
					text: enguia.tr("views")+": "+model.viewCount
					color: "#9E9E9E"
					visible: true
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
				onSigClicked: sigBtnDeleteClicked(model.id)
			}
            Rectangle{
                id: imgSeparator
                anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height:enguia.separatorHeight
				color:enguia.sectionRectColor
            }
            MouseArea{
                id: mouseArea
                anchors.fill: parent
				onClicked: listItemClicked(id,index)
                onPressAndHold: listItemPressAndHold(id, index)
            }
            Component.onCompleted:{				
                var itensHeight=columnLayout.height+imgSeparator.height+ enguia.height*0.02
				if(itensHeight>listItem.height) listItem.height=itensHeight
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
		//anchors.top: parent.top
    }
	MSTimer {
		id: tmr
		onTriggered: {
			for(var i=0;i<listModel.count;i++) {
				var modelItem=listModel.get(i);
				modelItem.showDelete=false;
				modelItem.backColor="transparent"
			}
		}
	}
	function append(ePlace){
		listModel.append({id:ePlace.id, name:ePlace.name, showDelete:false,backColor:"transparent", brief:ePlace.brief, rating:ePlace.rating, image:"qrc:/Images/"/*+mData.getImageNameFromCategoryID(categoryID)*/, cityName:ePlace.cityName, viewCount:ePlace.viewCount})
    }
	function showDelete(id){
		tmr.stop();
		for(var i=0;i<listModel.count;i++) {
			if(listModel.get(i).id===id) {
				var modelItem=listModel.get(i);
				modelItem.showDelete=true;
				modelItem.backColor=enguia.sectionRectColor
				tmr.start(5000);
				break;
			}
		}
	}
	function remove(id){
		for(var i=0;i<listModel.count;i++) {
			if(listModel.get(i).id===id) {
				listModel.remove(i);
				break;
			}
		}
	}
	function clear(){
		pageNumber=0;
		listModel.clear();
	}
}

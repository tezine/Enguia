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

Item{ property variant pressedAndHoldItem : null
    property alias listModel: listModel
    property int nextBlockID:0
	property bool loading:false
	signal listItemClicked(int id, int transactionType, int index,int type)
    signal listItemPressAndHold(int id, int transactionType)
	property int pageNumber:0
	signal sigEndOfListReached()

    ListModel{
        id: listModel
    }
	VMListEmptyRect{
		id: listEmptyRect
		color: "white"
		anchors{left:parent.left;right:parent.right;top:parent.top}
		visible: loading
		title: enguia.tr("Loading...")
	}
    ListView	{
        id: listView
        anchors.fill: parent
        model: listModel
        clip: true
        delegate:  Item{
            id: listItem
            anchors{left: parent.left ; right: parent.right;}
            height: enguia.height*0.12
            width: parent.width
            property variant itemData: model
            Image{
                id: imagem
				anchors{left: parent.left; verticalCenter: parent.verticalCenter}
                source: model.image
                width: listItem.height
                height: listItem.height
                onStatusChanged: if (status == Image.Error)source="qrc:///SharedImages/unknownpicture.png"
            }
            ColumnLayout{
                id: columnLayout
				spacing: 0
                anchors{left:imagem.right;leftMargin:enguia.smallMargin;verticalCenter:parent.verticalCenter;right:parent.right;rightMargin:enguia.mediumMargin}
                Label{
                    id: mainText
                    color: "black"
                    text: model.name
                    elide: Text.ElideRight
                    Layout.fillWidth: true
					font{pointSize: enguia.largeFontPointSize}
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
					color: "#616161"
					text: model.cityName
                    visible: text.length>0
				}
                Label{
                    id: subText
                    text: model.brief
                    font{pointSize: enguia.smallFontPointSize}
					color: "#616161"
					Layout.fillWidth: true
                    elide: Text.ElideRight
					visible: text!=""
                }
				Label{
					id: lblViewCount
					font{pointSize: enguia.tinyFontPointSize}
					text: model.viewCount
					color: "#616161"
				}
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
				onClicked: listItemClicked(model.tableID,model.transactionType, model.index,model.type)
                onPressAndHold: listItemPressAndHold(model.tableID, model.transactionType)
            }
			Component.onCompleted: {
                var itensHeight=columnLayout.height+imgSeparator.height+ enguia.height*0.02
                if(itensHeight>listItem.height)listItem.height=itensHeight;
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
	function append(id, name, brief, categoryID,rating, viewCount, cityName, type){
		if(type===undefined)type=2;//place
		var image="";
		if(type===2)image=mSFiles.getBannerThumbUrl(id).toString();
		else if(type===1)image=mSFiles.getUserBannerThumbUrl(id).toString();
        listModel.append({"tableID":id,
                             "name":name,
                             "brief":brief,
							 "image":image,
                             rating:rating,
							 cityName:cityName,
							 type:type,
                             viewCount:enguia.tr("views")+": "+ viewCount.toString(),
                             isLoadNext:false})
    }
	function clear(){
		listModel.clear();
		pageNumber=0;
	}
}


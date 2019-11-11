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
	signal listItemClicked(int id, int placeID, int index, int orderID, int agendaID, int visualID, string placeName,string comment)
    signal listItemPressAndHold(int id, int placeID)
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
        delegate:  Item{
            id: listItem
			height: enguia.screenHeight*0.07
            anchors{left: parent.left; right: parent.right;}
            property variant itemData: model
            ColumnLayout{
				id:columnLayout
				anchors{left: parent.left; leftMargin: enguia.mediumMargin; verticalCenter:parent.verticalCenter;right:lblRating.left}
                Label{
                    id: mainText
					font{pointSize: enguia.largeFontPointSize;}
                    color: "black"
                    text: model.placeName
					Layout.fillWidth: true
					elide: Text.ElideRight
                }
				Label{
					id: lblDetail
					font{pointSize: enguia.smallFontPointSize;}
					color: "gray"
					Layout.fillWidth: true
					elide: Text.ElideRight
					wrapMode: Text.NoWrap
					visible: text.length>0
					text: model.detail
				}
                Label{
                    id: subText
                    font{pointSize: enguia.smallFontPointSize;}
					color: "gray"
					Layout.fillWidth: true
					elide: Text.ElideRight
					wrapMode: Text.NoWrap
                    visible: !isLoadNext && text!=""
                    text: model.comment
                }
            }
            VSharedRatingIndicator{
                id: lblRating
				anchors{right: arrowImage.left; verticalCenter: parent.verticalCenter }
				height: enguia.height*0.05
				width: enguia.width/5
                rating: model.rating
                visible: !isLoadNext
            }		
			Image{
				id: arrowImage
				source: "qrc:///Images/next.png"
				width: listItem.height*0.5
				height: listItem.height*0.5
				anchors{right: parent.right;verticalCenter: parent.verticalCenter}
				visible: model.visualID>0
			}
            Rectangle{
                id: imgSeparator
                anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
				height:1
				color:enguia.sectionRectColor
            }
            MouseArea{
                id: mouseArea
                anchors.fill: parent
				onClicked: listItemClicked(model.id, model.placeID,model.index, model.orderID, model.agendaID, model.visualID, model.placeName,model.comment)
                onPressAndHold: listItemPressAndHold(model.id, model.placeID)
            }
			Component.onCompleted: {
				var itensHeight=columnLayout.height+enguia.height*0.02
				if(itensHeight>listItem.height)listItem.height=itensHeight
			}
        }
        section.property: "dateInserted"
		section.criteria: ViewSection.FullString
		section.delegate: VSharedListSection{
			text: Qt.formatDate(section,Qt.SystemLocaleShortDate)
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
	function append(eQualification){
		var detail=""
		if(eQualification.agendaID>0)detail=enguia.tr("Appointment")+ " "+eQualification.visualID
		else if(eQualification.orderID>0)detail=enguia.tr("Order")+" "+eQualification.visualID;
		var dt=enguia.convertToDateOnly(eQualification.dateInserted)
		listModel.append({id:eQualification.id,visualID:eQualification.visualID, placeID:eQualification.placeID,placeName:eQualification.placeName,comment:eQualification.comment,detail:detail,
			orderID:eQualification.orderID, agendaID:eQualification.agendaID, rating:eQualification.rating, dateInserted:dt,isLoadNext:false})
    }
    function clear(){
		pageNumber=0;
        listModel.clear();
    }
    function reset(){
        listModel.clear();
    }
}


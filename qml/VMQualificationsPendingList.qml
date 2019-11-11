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
	property alias listModel: listModel
	property bool loading:false
	signal listItemClicked(int id, int placeID, string placeName, int historyType, string title, date dateInserted)
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
				anchors{left: parent.left; leftMargin: enguia.mediumMargin; verticalCenter:parent.verticalCenter}
				Label{
					id: mainText
					font{pointSize: enguia.largeFontPointSize;}
					color: "black"
					text: model.placeName
				}
				Label{
					id: subText
					font{pointSize: enguia.smallFontPointSize;}
					color: "gray"
					visible: text.length>0
					text: model.title
				}
			}
			Image{
				id: arrowImage
				source: "qrc:///Images/next.png"
				width: listItem.height*0.5
				height: listItem.height*0.5
				anchors{right: parent.right;verticalCenter: parent.verticalCenter}
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
				onClicked: listItemClicked(model.id, model.placeID, model.placeName, model.historyType, model.title, model.dateInserted)
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
	function append(eUserHistory){
		var historyTypeName="";
		var title="";
		switch(eUserHistory.historyType){
			case MMobile.HistoryTypeOrder:
				historyTypeName=enguia.tr("Order")
				title=enguia.tr("Order")+" "+eUserHistory.visualID;
				break;
			case MMobile.HistoryTypeSchedule:
				historyTypeName=enguia.tr("Appointment")
				title=enguia.tr("Appointment")+ " "+eUserHistory.visualID+" ("+eUserHistory.name+")";
				break;
		}
		listModel.append({id:eUserHistory.id, placeID:eUserHistory.placeID, historyType:eUserHistory.historyType, placeName:eUserHistory.placeName, title:title, dateInserted: enguia.convertToDateOnly(eUserHistory.dateInserted)})
	}
	function clear(){
		pageNumber=0;
		listModel.clear();
	}
}


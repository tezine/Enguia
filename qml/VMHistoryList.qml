import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
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
import "qrc:/"
import "qrc:/History"

Item{
    clip: true
    property alias listModel: menuModel
    property alias visibleArea: listView.visibleArea
    property alias listView: listView
	property bool loading:false
	signal listItemClicked(int type, string typeName, int id, string name, int placeID,int visualID)
    signal listItemPressAndHold(string name, int index, int id, string userName)
    signal sigBtnDeleteClicked(int id);
	property int pageNumber:0
	signal sigEndOfListReached()

    ListModel{
        id: menuModel
    }
	VMListEmptyRect{
		id: listEmptyRect
		anchors{left:parent.left;right:parent.right;top:parent.top}
		visible: menuModel.count===0
		title: loading?enguia.tr("Loading..."): enguia.tr("No records");
	}
    ListView{
        id: listView
        anchors.fill: parent
        model: menuModel
        clip: true
        delegate:  Rectangle{
            id: listItem
            height: enguia.screenHeight*0.08
            anchors{left: parent.left; right: parent.right;}
            color:model.backColor
            ColumnLayout{
				id:columnLayout
				anchors{left: parent.left; leftMargin: enguia.hugeMargin; verticalCenter:parent.verticalCenter;right:lblTypeName.left}
                Label{
                    id: mainText
                    font{pointSize: enguia.mediumFontPointSize;weight: Font.Bold}
                    color: "black"
                    text: model.placeName
					Layout.fillWidth: true
					elide: Text.ElideRight
                }
                Label{
                    id: subText
                    font{pointSize: enguia.smallFontPointSize;}
					color: "gray"
                    text: model.name
					Layout.fillWidth: true
					elide: Text.ElideRight
                }
            }
            Label{
                id: lblTypeName
				anchors{right:arrowImage.left ;verticalCenter: parent.verticalCenter;}
                font{pointSize: enguia.smallFontPointSize;}
                color: "black"
                text: model.historyTypeName
            }
			Image{
                id: arrowImage
                source: "qrc:///Images/next.png"
                width: listItem.height*0.9
                height: listItem.height*0.9
                anchors{right: parent.right;verticalCenter: parent.verticalCenter}
			}
            Rectangle{
                id: imgSeparator
                anchors{bottom:parent.bottom; left: parent.left; right: parent.right}
                height: 1;
                color:"lightgray"
            }
			VMListButton{
                id: deleteImage
                z: 1
                width: listItem.height*0.9
                height: listItem.height*0.9
                source: "qrc:///Images/delete.png"
                anchors{right: parent.right;rightMargin: enguia.mediumMargin;verticalCenter: parent.verticalCenter}
                visible: model.showDelete?true:false
                onSigClicked: sigBtnDeleteClicked(model.id)
            }
            MouseArea{
                id: mouseArea
                anchors.fill: parent
				onClicked: listItemClicked(model.historyType, model.historyTypeName, model.id, model.name, model.placeID, model.visualID)
                onPressAndHold: listItemPressAndHold(model.title, model.index, model.id, model.userName)
            }			
			Component.onCompleted: {
				var itensHeight=columnLayout.height+imgSeparator.height+ enguia.height*0.02
				if(itensHeight>listItem.height)listItem.height=itensHeight
			}
        }
        section.property: "dateInserted"
		section.criteria: ViewSection.FullString
		section.delegate: VSharedListSection{
			text: Qt.formatDate(section,Qt.SystemLocaleShortDate)
		}
		onAtYEndChanged: {
			if(menuModel.count<enguia.listCount)return;
			if(atYEnd) sigEndOfListReached()
		}
    }
    VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
        anchors.right: listView.right
        anchors.top: parent.top
    }
	function append(eUserHistory) {
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
			case MMobile.HistoryTypeUserSchedule:
				historyTypeName=enguia.tr("Appointment")
				title=enguia.tr("Appointment")+ " "+eUserHistory.visualID+" ("+eUserHistory.name+")";
				break;
        }
		var dt=enguia.convertToDateOnly(eUserHistory.dateInserted)
		menuModel.append({historyTypeName:historyTypeName, historyType:eUserHistory.historyType,visualID:eUserHistory.visualID,  id:eUserHistory.id, name:title,
							 placeID:eUserHistory.placeID, placeName:eUserHistory.placeName,"showDelete":false,backColor:"transparent", dateInserted:dt})
    }
    function clearBackColor(){
        for(var i=0;i<menuModel.count;i++){
            menuModel.get(i).backColor="transparent"
        }
    }
    function select(id){
        for(var i=0;i<menuModel.count;i++) {
            if(menuModel.get(i).id===id) {
                var modelItem=menuModel.get(i);
                modelItem.backColor="gray";
            }
        }
    }
    function clear(){
		pageNumber=0;
        menuModel.clear();
    }
    function removeCurrent(){
        menuModel.remove(listView.currentIndex);
    }
    function updateOrInsert(name, id){
        var found=false;
        for(var i=0;i<menuModel.count;i++) {
            if(menuModel.get(i).id===id) {
                var modelItem=menuModel.get(i);
                modelItem.title=name;
                modelItem.id=id;
                found=true;
                break;
            }
        }
        if(!found)append(name,"",id)
    }
}



import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"

Item{
    property variant pressedAndHoldItem : null
    property alias listModel: agendaModel
	property bool loading:false
    signal listItemClicked(int id, int index)
    signal listItemPressAndHold(int id)
	property int pageNumber:0
	signal sigEndOfListReached()

    ListModel{
        id: agendaModel
    }
	VMListEmptyRect{
		id: listEmptyRect
		anchors{left:parent.left;right:parent.right;top:parent.top}
		visible: agendaModel.count===0
		title: loading?enguia.tr("Loading..."): enguia.tr("No records");
	}
    ListView{
        id: listView
        anchors.fill: parent
        model: agendaModel
        clip: true
        delegate:  Item{
            id: listItem
            anchors{left: parent.left; right: parent.right; }
			height:enguia.height*0.1
            property variant itemData: model
            Image{
                id: imagem
                anchors{left: parent.left;}
                width: listItem.height
                height: listItem.height
                source: mSFiles.getBannerThumbUrl(model.id)
                onStatusChanged: if (status == Image.Error)source="qrc:///SharedImages/unknownpicture.png"
            }
            ColumnLayout{
				id:columnLayout
				anchors{left:imagem.right;leftMargin: enguia.smallMargin;right:parent.right;rightMargin: enguia.mediumMargin; verticalCenter: parent.verticalCenter}
				spacing: 0
                Label{
                    id: mainText
					font{pointSize: enguia.largeFontPointSize}
                    color: "black"
					text: model.name
					Layout.fillWidth: true
					elide: Text.ElideRight
                }
				VSharedRatingIndicator{
					id: lblRating
					Layout.preferredHeight: enguia.height*0.02
					Layout.preferredWidth: enguia.width*0.3
					rowAnchors.left: lblRating.left//pq o padrao é centralizar
					rating: model.rating
				}
                Label{
                    id: subText
                    font{pointSize: enguia.smallFontPointSize}
					text: model.brief
					color: "gray"
					visible: text.length>0
					elide: Text.ElideRight
					Layout.fillWidth: true
                }
				Label{
					id: lblPeriod
					font{pointSize: enguia.smallFontPointSize}
					text: Qt.formatDate(model.startDate, Qt.SystemLocaleShortDate)+" "+enguia.tr("until")+" "+Qt.formatDate(model.endDate,Qt.SystemLocaleShortDate);
					color: "gray"
				}
				/*Label{
                    id: lblViewCount
					font{pointSize: enguia.tinyFontPointSize}
					color: "gray"
					text: enguia.tr("views")+": "+model.viewCount
					//visible: model.viewCount>0
				}*/
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
				onClicked: listItemClicked(model.id, model.index)
                onPressAndHold: listItemPressAndHold(model.id)
            }
			Component.onCompleted: {
				var itensHeight=columnLayout.height+imgSeparator.height+ enguia.height*0.02
				if(itensHeight>listItem.height)listItem.height=itensHeight
			}
        }
		onAtYEndChanged: {
			if(agendaModel.count<enguia.listCount)return;
			if(atYEnd) sigEndOfListReached()
		}
    }
    VMScrollBar {
		scrollArea: listView; height: listView.height; width: enguia.scrollWidth
        anchors.right: listView.right
        anchors.top: parent.top
    }
	function clear(){
		pageNumber=0;
		agendaModel.clear();
	}
    function sortByName(){
        for(var i=0;i<agendaModel.count;i++)
        agendaModel.move(i, recursiveCheckName(agendaModel.get(i)),1)
    }
    //retorna a posicao correta do objeto
    function recursiveCheckName(obj){
        for(var i=0;i<agendaModel.count;i++){
            if(obj.title.toLowerCase()<agendaModel.get(i).title.toLowerCase())return i;
        }
        return agendaModel.count-1;//last pos
    }
    function sortByDate(){
        for(var i=0;i<agendaModel.count;i++)
        agendaModel.move(i, recursiveCheckDate(agendaModel.get(i)),1)
    }
    function sortByRating(){
        for(var i=0;i<agendaModel.count;i++)
        agendaModel.move(i,recursiveCheckRating(agendaModel.get(i)),1)
    }
    function sortByViews(){
        for(var i=0;i<agendaModel.count;i++)
        agendaModel.move(i,recursiveCheckViews(agendaModel.get(i)),1)
    }
    function recursiveCheckViews(obj){
        for(var i=0;i<agendaModel.count;i++)
        if(obj.viewCount>agendaModel.get(i).viewCount)
        return i;
        return agendaModel.count-1;//lastpos
    }
    function recursiveCheckRating(obj){
        for(var i=0;i<agendaModel.count;i++) {
            if(obj.rating>agendaModel.get(i).rating)
            return i;
        }
        return agendaModel.count-1;//lastpos
    }
    function recursiveCheckDate(obj){
        for(var i=0;i<agendaModel.count;i++){
            if(obj.startDate<agendaModel.get(i).startDate)
            return i;
        }
        return agendaModel.count-1;//last pos
    }
	function append(ePlace){
		listAgenda.listModel.append({id:ePlace.id, name:ePlace.name,rating:ePlace.rating, brief:ePlace.brief, startDate:ePlace.startDate, endDate:ePlace.endDate, viewCount:ePlace.viewCount})
    }
    function reset(){
        listModel.clear();
    }
}

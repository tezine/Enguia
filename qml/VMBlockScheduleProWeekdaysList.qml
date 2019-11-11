import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockSchedule"

Item{
	clip: true
	property alias listModel: menuModel
	property bool loading:false
	signal listItemClicked(int id, string name,int status, bool isSameAsOther, int sameAsWeekDay)
	signal listItemPressAndHold(int id, int index, int status, bool isSameAsOther, int sameAsWeekDay)
	signal sigBtnDeleteClicked(int id)

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
			height: enguia.screenHeight*0.09
			anchors{left: parent.left; right: parent.right;}
			color: model.backColor
			ColumnLayout{
				id:columnLayout
				anchors{left: parent.left; leftMargin: enguia.mediumMargin; right:parent.right;rightMargin:enguia.mediumMargin;  verticalCenter:parent.verticalCenter}
				Label{
					id: mainText
					font{pointSize: enguia.hugeFontPointSize;}
					color: "black"
					text: model.name
					verticalAlignment: Text.AlignVCenter
					Layout.fillHeight: true
					Layout.alignment: Qt.AlignVCenter
				}
				Label{
					id: subText
					font{pointSize: enguia.smallFontPointSize;}
					color: "#424242"
					text: model.otherDay
					wrapMode: Text.Wrap
					visible: model.otherDay.length>0
				}
			}
			VMListButton{
				id: deleteImage
				z: 100
				width: listItem.height*0.9
				height: listItem.height*0.9
				anchors{right:arrowImage.left;verticalCenter: parent.verticalCenter;}
				source: "qrc:///Images/delete.png"
				visible: model.showDelete?true:false
				onSigClicked: sigBtnDeleteClicked(model.id)
			}
			Image{
				id: arrowImage
				source: "qrc:///SharedImages/nextblack.png"
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
				onClicked: listItemClicked(model.id, model.name,model.status, model.isSameAsOther, model.sameAsWeekDay)
				onPressAndHold: listItemPressAndHold(model.id,model.index,model.status, model.isSameAsOther, model.sameAsWeekDay)
			}
			Component.onCompleted:{
				var itensHeight=columnLayout.height+imgSeparator.height+ enguia.height*0.02
				if(itensHeight>listItem.height) listItem.height=itensHeight
			}
		}
	}
	VMScrollBar {
		scrollArea: listView; height: listView.height; width: parent.width*0.02
		anchors.right: listView.right
		anchors.top: parent.top
	}
	MSTimer {
		id: tmr
		onTriggered: {
			for(var i=0;i<menuModel.count;i++) {
				var modelItem=menuModel.get(i);
				modelItem.showDelete=false;
			}
		}
	}
	function append(id, name) {
		menuModel.append({id:id,name:name,showDelete:false, backColor:"transparent",otherDay:"", status:MSDefines.ScheduleStatusUnknown, sameAsWeekDay:0,isSameAsOther:false})
	}
	function showDelete(id){
		tmr.stop();
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===id) {
				var modelItem=menuModel.get(i);
				modelItem.showDelete=true;
				tmr.start(5000);
				break;
			}
		}
	}
	function remove(id){
		for(var i=0;i<menuModel.count;i++) {
			if(menuModel.get(i).id===id) {
				menuModel.remove(i);
				break;
			}
		}
	}
	function setStatus(weekDay, status, isSameAsOther, other){
		switch(weekDay){
			case Qt.Monday:
				setListItem(0,status,isSameAsOther,other)
				break;
			case Qt.Tuesday:
				setListItem(1,status,isSameAsOther,other)
				break;
			case Qt.Wednesday:
				setListItem(2,status,isSameAsOther,other)
				break;
			case Qt.Thursday:
				setListItem(3,status,isSameAsOther,other)
				break;
			case Qt.Friday:
				setListItem(4,status,isSameAsOther,other)
				break;
			case Qt.Saturday:
				setListItem(5,status,isSameAsOther,other)
				break;
			case Qt.Sunday:
				setListItem(6,status,isSameAsOther,other)
				break;
		}
	}
	function setListItem(index, status, isSameAsOther, other){
		var item=menuModel.get(index);
		item.backColor=getBackColor(status);
		if(isSameAsOther)item.otherDay=getOtherSubTitle(other);
		else item.otherDay=mSAgenda.getScheduleStatusName(status)
		item.status=status;
		item.isSameAsOther=isSameAsOther
		if(isSameAsOther)item.sameAsWeekDay=other
		else item.sameAsWeekDay=0;
	}
	function getBackColor(status){
		switch(status){
			case MSDefines.ScheduleStatusOpen:
				return "#81C784";
			case MSDefines.ScheduleStatusClosed:
				return "lightgray";
			case MSDefines.ScheduleStatusGetInTouch:
				return "#FFB74D"
		}
		return "white";//unknown
	}
	function getOtherSubTitle(other){
		switch(other){
			case Qt.Monday:
				return enguia.tr("Same as")+" "+enguia.tr("monday")
			case Qt.Tuesday:
				return enguia.tr("Same as")+" "+enguia.tr("tuesday")
			case Qt.Wednesday:
				return enguia.tr("Same as")+" "+enguia.tr("wednesday")
			case Qt.Thursday:
				return enguia.tr("Same as")+" "+enguia.tr("thursday")
			case Qt.Friday:
				return enguia.tr("Same as")+" "+enguia.tr("friday")
			case Qt.Saturday:
				return enguia.tr("Same as")+" "+enguia.tr("saturday")
			case Qt.Sunday:
				return enguia.tr("Same as")+" "+enguia.tr("sunday")
		}
		return ""
	}
	Component.onCompleted: {
		append(Qt.Monday,enguia.tr("Monday"));//1
		append(Qt.Tuesday,enguia.tr("Tuesday"));
		append(Qt.Wednesday,enguia.tr("Wednesday"));
		append(Qt.Thursday,enguia.tr("Thursday"));
		append(Qt.Friday,enguia.tr("Friday"));
		append(Qt.Saturday,enguia.tr("Saturday"));
		append(Qt.Sunday,enguia.tr("Sunday"));//7
		//append(8,enguia.tr("Exceptions"));
	}
}

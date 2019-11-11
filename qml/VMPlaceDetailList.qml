import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Item {
    clip: true
    property alias listModel: listModel

    ListModel {
        id: listModel
    }
    ListView {
        id: listView
        anchors.fill: parent
        model: listModel
        cacheBuffer: 1
        clip: true
        delegate: Column{
            id: column
            width: parent.width-2
            anchors.horizontalCenter:parent.horizontalCenter
            Rectangle{
                id: rectDescription
                height: 20
                width: parent.width
                color: "lightgrey"
                Text{
                    id: headerDescription
                    anchors{left: parent.left;leftMargin: enguia.smallMargin; right: parent.right; rightMargin: enguia.smallMargin; verticalCenter: rectDescription.verticalCenter}
                    font{pointSize:enguia.mediumFontPointSize;bold: true}
                    text: title
                    color: "black"
                }
            }
            Text{
                id: txtDescription
                anchors{left: parent.left; leftMargin: enguia.smallMargin; right: parent.right; rightMargin: enguia.smallMargin; top: rectDescription.bottom}
                font{pointSize:enguia.mediumFontPointSize}
                wrapMode: Text.Wrap
                width: parent.width
                text: description
            }
            Component.onCompleted:{
                list.height+=column.height
            }
        }
    }
    function append(name, brief, description, address, startDate, endDate,email, capacity, structure, price, agerange, website, postalcode, phone1,
                    mondayStart, mondayEnd, tuesdayStart, tuesdayEnd, wednesdayStart, wednesdayEnd, thursdayStart, thursdayEnd, fridayStart, fridayEnd,
                    saturdayStart, saturdayEnd, sundayStart, sundayEnd) {
        console.debug("fazendo append:",name);
		listModel.append({title:enguia.tr("Name"), description:name})
		if(brief.length>0)listModel.append({title:enguia.tr("Brief"), description:brief})
		if(description.length>0)listModel.append({title:enguia.tr("Description"), description:description})
		if(address.length>0)listModel.append({title:enguia.tr("Address"), description:address})
		if(postalcode.length>0)listModel.append({title:enguia.tr("Zipcode"), description:postalcode})
		if(phone1.length>0)listModel.append({title:enguia.tr("Phone"), description:phone1})
		if(website.length>0)listModel.append({title:enguia.tr("Website"), description:website})
		if(email.length>0)listModel.append({title:enguia.tr("Email"), description:email})
		if(structure.length>0)listModel.append({title:enguia.tr("Structure"), description:structure})
		if(capacity &&capacity>0)listModel.append({title:enguia.tr("Capacity"), description:capacity.toString()})
		if(price && price>0)listModel.append({title:enguia.tr("Price"), description:'arrumarbla' /*mData.getPriceStringFromEnum(price)*/})
        var periodMonday, periodTuesday, periodWednesday, periodThursday, periodFriday, periodSaturday, periodSunday;
        periodMonday=getPeriodForDay(mondayStart,mondayEnd)
        periodTuesday=getPeriodForDay(tuesdayStart,tuesdayEnd)
        periodWednesday=getPeriodForDay(wednesdayStart,wednesdayEnd)
        periodThursday=getPeriodForDay(thursdayStart,thursdayEnd)
        periodFriday=getPeriodForDay(fridayStart,fridayEnd)
        periodSaturday=getPeriodForDay(saturdayStart,saturdayEnd)
        periodSunday=getPeriodForDay(sundayStart,sundayEnd)
        if(periodMonday===periodTuesday &&
                periodTuesday===periodWednesday &&
                periodWednesday===periodThursday &&
                periodThursday===periodFriday &&
                periodFriday===periodSaturday &&
                periodSaturday===periodSunday){
			if(periodSunday==="24h")listModel.append({title:enguia.tr("Monday to Sunday"), description: "24h"})
			else listModel.append({title:enguia.tr("Monday to Sunday"), description: getPeriodForDay(mondayStart,mondayEnd)})
        }
        else {
		/*arrumar    if(!mData.closedTime(mondayStart))listModel.append({title:enguia.tr("Monday"), description: getPeriodForDay(mondayStart,mondayEnd)})
			if(!mData.closedTime(tuesdayStart))listModel.append({title:enguia.tr("Tuesday"), description:getPeriodForDay(tuesdayStart,tuesdayEnd)})
			if(!mData.closedTime(wednesdayStart))listModel.append({title:enguia.tr("Wednesday"), description:getPeriodForDay(wednesdayStart,wednesdayEnd)})
			if(!mData.closedTime(thursdayStart))listModel.append({title:enguia.tr("Thursday"), description:getPeriodForDay(thursdayStart,thursdayEnd)})
			if(!mData.closedTime(fridayStart))listModel.append({title:enguia.tr("Friday"), description:getPeriodForDay(fridayStart,fridayEnd)})
			if(!mData.closedTime(saturdayStart))listModel.append({title:enguia.tr("Saturday"), description:getPeriodForDay(saturdayStart,saturdayEnd)})
			if(!mData.closedTime(sundayStart))listModel.append({title:enguia.tr("Sunday"), description:getPeriodForDay(sundayStart,sundayEnd)})*/
        }
    }
    function getPeriodForDay(tmStart, tmEnd){
       // if(mData.open24h(tmStart,tmEnd))return "24h";
		return Qt.formatTime(tmStart) + enguia.tr(" to ") +Qt.formatTime(tmEnd)
    }
}

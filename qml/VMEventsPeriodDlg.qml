import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

VMDlgBase{
	title: enguia.tr("Agenda default period")

	VMListForDlg{
        id: list
        anchors{top:titleBar.bottom;bottom:parent.bottom;}
        width: parent.width
        onListItemClicked: {//selected(model.get(selectedIndex).tableID,model.get(selectedIndex).modelData)
            sigIconSelected( name, image);
            forceClose();
        }
    }
    Component.onCompleted: {
		list.append(enguia.tr("Day"), MSDefines.PeriodTypeToday)
		list.append(enguia.tr("Week"), MSDefines.PeriodTypeCurrentWeek)
		list.append(enguia.tr("Month"),  MSDefines.PeriodTypeCurrentMonth)
		list.append(enguia.tr("Year"),  MSDefines.PeriodTypeCurrentYear)
    }
}

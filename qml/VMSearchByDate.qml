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

Rectangle{
    id: topWindow
    property date startDate:new Date()
	property date endDate:enguia.addMonths(startDate,1)

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Search by date")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
    }
    GridLayout{
        id: grid
		columns: 1
		rowSpacing: enguia.smallMargin
        anchors{top: pageTitle.bottom;left: parent.left;right: parent.right;rightMargin: enguia.mediumMargin;leftMargin: enguia.mediumMargin;topMargin: enguia.mediumMargin}
        VMButton{
            id: btnStartDate
            Layout.fillWidth: true
            text:Qt.formatDate(startDate,Qt.DefaultLocaleShortDate)
            onClicked: dlgDate.launchDate(startDate,1)
			VMLabel{
				id: lblStartDate
				color: "white"
				text: enguia.tr("Start date")+":"
				anchors{left:parent.left;leftMargin: enguia.mediumMargin;verticalCenter:parent.verticalCenter}
			}
        }
        VMButton{
            id: btnEndDate
            text:Qt.formatDate(endDate,Qt.DefaultLocaleShortDate)
            Layout.fillWidth: true
            onClicked: dlgDate.launchDate(endDate,2)
			VMLabel{
				id: lblEndDate
				color: "white"
				text: enguia.tr("End date")+":"
				anchors{left:parent.left;leftMargin: enguia.mediumMargin;verticalCenter:parent.verticalCenter}
			}
        }
    }
	VMButton{
        id: btnSearch
		text: enguia.tr("Search")
		anchors{top: grid.bottom;topMargin: enguia.smallMargin;left: grid.left;right: grid.right}
		onClicked: btnSearchClicked();
    }
	VMSearchResultList{
		id: listResult
		anchors{top: btnSearch.bottom;topMargin: enguia.mediumMargin; left: parent.left;right: parent.right;bottom: parent.bottom}
		onListItemClicked:mainStack.push({item:Qt.resolvedUrl("qrc:///BlockWelcome/VMBlockWelcome.qml"),destroyOnPop:true,immediate:true, properties:{placeID:id}})
		onSigEndOfListReached: searchByDate();
	}
	VMDlgDate{
        id: dlgDate
		onSigDateSelected:{
            switch(type){
                case 1://startdate
                    startDate=dt;
                    btnStartDate.text=Qt.formatDate(startDate,Qt.DefaultLocaleShortDate);
                    break;
                case 2://enddate
                    endDate=dt;
                    btnEndDate.text=Qt.formatDate(endDate,Qt.DefaultLocaleShortDate);
                    break;
            }
        }
    }
	function btnSearchClicked(){
		listResult.clear();
		statusBar.visible=false;
		Qt.inputMethod.hide();
		if(startDate>endDate){statusBar.displayError(enguia.tr("Start date must be less than end date"));return;}
		searchByDate();
	}
	function searchByDate(){
		var start=enguia.convertToDateISOString(startDate);
		var end=enguia.convertToDateISOString(endDate)
		mSVC.metaInvoke(MSDefines.SPlaces,"SearchByDate",function(list){
			if(list.length>=0)listResult.pageNumber++;
			if(list.length===0){statusBar.displayError(enguia.tr("Nothing found"));return;}
			for(var o=0;o<list.length;o++){
				var p=list[o];
				listResult.append(p.id, p.name, p.brief, p.categoryID, p.rating, p.viewCount,p.cityName);
			}
		},mMobile.cityID,start, end,enguia.listCount,listResult.pageNumber);
	}
}



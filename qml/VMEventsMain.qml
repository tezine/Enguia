import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
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
import "qrc:/BlockWelcome"

Rectangle{
	id:topWindow
	property int periodType: parseInt(MSDefines.PeriodTypeCurrentMonth)
	property int sortType:parseInt(MSDefines.EventSortTypeDate)
    property date dt:new Date()

    VMPageTitle{
        id: pageTitle
		title: enguia.isIOSNotAuthenticated()?"":enguia.tr("Events")
		btnBackVisible:!enguia.isIOSNotAuthenticated();
        onSigBtnBackClicked: mainWindow.popOneLevel();
        VMToolButton{
            id: toolMenu
            source: "qrc:///SharedImages/overflow.png"
            anchors.right: parent.right
            onSigClicked: menuMain.popup();
			visible: !enguia.isIOSNotAuthenticated()
		}
		Label{
			color:"white"
			text:enguia.tr("Events")
			font{pointSize: enguia.imenseFontPointSize;bold: true}
			anchors{left:parent.left;verticalCenter:parent.verticalCenter; leftMargin:enguia.mediumMargin}
			visible: enguia.isIOSNotAuthenticated()
		}
		VMLabelButton{
			id: btnLogin
			text:enguia.tr("Login")
			anchors{right:parent.right; rightMargin: enguia.smallMargin; verticalCenter: parent.verticalCenter;}
			fontPointSize: enguia.imenseFontPointSize
			fontBold: true
			textColor:"#4CAF50"
			onSigClicked: mainWindow.popToLogin();
			visible: enguia.isIOSNotAuthenticated()
		}
    }
	VMEventsList{
        id: listAgenda
		anchors{top: pageTitle.bottom;left: parent.left;right: parent.right;bottom: rectCity.top}
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockWelcome/VMBlockWelcome.qml"),destroyOnPop:true,immediate:true, properties:{placeID:id}})
		onSigEndOfListReached: getEvents(dt,periodType,sortType)
    }
	Rectangle{
		id:rectCity
		height: enguia.height*0.05
		anchors{left:parent.left;right:parent.right;bottom:commonTools.top;}
		color:"#607D8B"
		VMLabel{
			id: lblCity
			text:mMobile.cityName
			anchors.fill: parent
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			color: "white"
		}
		MouseArea{
			anchors.fill: parent
			onClicked:  mainStack.push({item:Qt.resolvedUrl("qrc:///Preferences/VMPreferencesCity.qml"),destroyOnPop:true, immediate:true})
		}
		Component.onCompleted: {
			rectCity.height=lblCity.height
		}
	}
	VMToolBar{//bottom toolbar
        id:commonTools
        color: "#01579B"
        anchors{bottom:parent.bottom; left:parent.left; right: parent.right;}
		VMLabelButton{
            id: toolPeriod
			fontPointSize: enguia.hugeFontPointSize
            anchors.horizontalCenter: parent.horizontalCenter
			text: enguia.tr("Current month")
			onSigClicked: periodMenu.popup();
        }
	}
    Menu{
		id: periodMenu
        MenuItem{
            id: menuToday
			text: enguia.tr("Today")
            onTriggered: changePeriod(MSDefines.PeriodTypeToday,text);
        }
        MenuItem{
            id: menuAll
			text: enguia.tr("Current week")
            onTriggered: changePeriod(MSDefines.PeriodTypeCurrentWeek,text);
        }
        MenuItem{
            id: menuMonth
			text: enguia.tr("Current month")
            onTriggered: changePeriod(MSDefines.PeriodTypeCurrentMonth,text);
        }
		MenuItem{
			id: menuNextMonth
			text: enguia.tr("Next month")
			onTriggered: changePeriod(MSDefines.PeriodTypeNextMonth,text);
		}
        MenuItem{
            id: menuYear
			text: enguia.tr("Current year")
            onTriggered: changePeriod(MSDefines.PeriodTypeCurrentYear,text);
        }
	}
    Menu{
        id: menuMain
        MenuItem{
            id: menuSortByName
			text: enguia.tr("Sort by name")
			onTriggered: changeSortType(MSDefines.EventSortTypeName)
        }
        MenuItem{
            id: menuSortByDate
			text: enguia.tr("Sort by start date")
			onTriggered: changeSortType(MSDefines.EventSortTypeDate)
        }
		/*MenuItem{
            id: menuSortByRating
			text: enguia.tr("Sort by rating")
			onTriggered: changeSortType(MSDefines.EventSortTypeRating)
		}*/
        MenuItem{
            id: menuSortByViews
			text: enguia.tr("Sort by views")
			onTriggered: changeSortType(MSDefines.EVentSortTypeViews)
        }
		MenuItem{
			id: menuAdd
			text: enguia.tr("Add...")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///Tourism/VMTourismEdit.qml"),destroyOnPop:true,immediate:true, properties:{ isEvent:true}})
		}
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileEvents);
		}
    }
	function changeSortType(sortType){
		listAgenda.clear();
		topWindow.sortType=sortType;
		getEvents(dt, periodType, sortType)
	}
	function changePeriod(period, text){
		toolPeriod.text=text;
		topWindow.periodType=period
		listAgenda.clear();
		getEvents(dt,period,sortType)
	}
	function getEvents(dt, periodType, sortType){
		listAgenda.loading=true;
		mSVC.metaInvoke(MSDefines.SPlaces, "GetEvents",function(list){
			listAgenda.loading=false;
			if(list.length>=0)listAgenda.pageNumber++;
			for(var i=0;i<list.length;i++){
				var ePlace=list[i];
				listAgenda.append(ePlace)
			}
		},mMobile.cityID,enguia.convertToDateISOString(dt),periodType,sortType, enguia.listCount,listAgenda.pageNumber);
	}
	Stack.onStatusChanged: {
		if(Stack.status!==Stack.Activating)return;
		listAgenda.clear();
		getEvents(dt,periodType,sortType)
	}
}


import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import QtPositioning 5.3
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
import "qrc:/Tourism"
import "qrc:/"

Rectangle {
	id: tabGeneral
	anchors.fill: parent
	property string gpsPosition:""
	color:enguia.backColor

	Flickable {
		id: flickable
		clip: true
		width: parent.width;
		height: parent.height
		contentWidth: parent.width
		contentHeight: grid.height+enguia.height*0.02+enguia.mediumMargin
		ColumnLayout{
			id: grid
			anchors{left:parent.left;right:parent.right;top:parent.top;}
			anchors.margins: enguia.largeMargin;
			spacing: 0
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Name")
			}
			VMTextField{
				id: txtName
				maximumLength: 50
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text: enguia.tr("Brief")
			}
			VMTextField{
				id: txtBrief
				maximumLength: 100
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text: enguia.tr("Address")
			}
			VMTextField{
				id: txtAddress
				maximumLength: 100
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text: enguia.tr("Phone")
			}
			VMTextField{
				id: txtPhone1
				Layout.fillWidth: true
				maximumLength: 20
				inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text: enguia.tr("Website")
			}
			VMTextField{
				id: txtWebSite
				Layout.fillWidth: true
				maximumLength: 100
				inputMethodHints: Qt.ImhUrlCharactersOnly
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text: enguia.tr("City")
			}
			VMButton{
				id: btnCity
				text: "..."
				Layout.fillWidth: true
				onClicked: dlgCities.open();
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text: enguia.tr("City region")
			}
			VMComboBox{
				id: comboCityRegion
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text: enguia.tr("Category")
			}
			VMComboBox{
				id: comboCategory
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text: enguia.tr("Age")
			}
			VMComboBox{
				id: comboAge
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text: enguia.tr("Price")
			}
			VMComboBox{
				id: comboPrice
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text: enguia.tr("Start")
				visible: comboCategory.getSelected()===MSDefines.MainCategoryTypeEvents
			}
			VMButton{
				id: btnStart
				Layout.fillWidth: true
				visible: comboCategory.getSelected()===MSDefines.MainCategoryTypeEvents
				onClicked: dlgDate.launchDate(btnStart.dt,1)
			}
			Item{
				height: enguia.mediumMargin
				visible: comboCategory.getSelected()===MSDefines.MainCategoryTypeEvents
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text: enguia.tr("End")
				visible: comboCategory.getSelected()===MSDefines.MainCategoryTypeEvents
			}
			VMButton{
				id: btnEnd
				Layout.fillWidth: true
				visible: comboCategory.getSelected()===MSDefines.MainCategoryTypeEvents
				onClicked: dlgDate.launchDate(btnEnd.dt,2)
			}
			Item{
				height: enguia.mediumMargin
				visible: comboCategory.getSelected()===MSDefines.MainCategoryTypeEvents
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text: enguia.tr("GPS position")
			}
			Rectangle{
				Layout.fillWidth: true
				height: btnGPS.height+rectName.height
				VMButton{
					id: btnGPS
					text: enguia.tr("Aquire position...");
					anchors{left:parent.left;right:parent.right;top:parent.top}
					onClicked: {
						if(gpsPosition.length>0)lblGPSPos.text=gpsPosition;//bug do qt. Esta fazendo acquire mesmo sem active
						else{
							lblGPSPos.text=enguia.tr("acquiring...")
							positionSource.update();
						}
					}
				}
				Rectangle{
					id: rectName
					anchors{left:parent.left;right:parent.right;bottom:parent.bottom}
					height: lblGPSPos.height
					color:"gray"
					Label{
						id: lblGPSPos
						anchors{left:parent.left;leftMargin: enguia.mediumMargin}
						color:"white"
						font.pointSize: enguia.smallFontPointSize
					}
				}
			}
		}
	}
	Rectangle {
		id: scrollbar
		anchors.right: flickable.right
		y: flickable.visibleArea.yPosition * flickable.height
		width: enguia.scrollWidth
		height: flickable.visibleArea.heightRatio * flickable.height
		color: "#BDBDBD"
	}
	VMDlgCity{
		id: dlgCities
		onSigCitySelected: btnCity.fill(cityID,cityName)
	}
	PositionSource {
		id: positionSource
		active: false
		updateInterval: 10000
		preferredPositioningMethods: PositionSource.SatellitePositioningMethods
		onSourceErrorChanged: {
			switch(sourceError){
			case PositionSource.AccessError :
				lblGPSPos.text=enguia.tr("Access error");
				break;
			case PositionSource.ClosedError:
				lblGPSPos.text=enguia.tr("Closed error");
				break;
			case PositionSource.UnknownSourceError:
				lblGPSPos.text=enguia.tr("Unknown error")
				break;
			case PositionSource.SocketError:
				lblGPSPos.text=enguia.tr("Socket error");
				break;
			}
		}
		onPositionChanged: {
			var position=positionSource.position;
			if(!position.latitudeValid){lblGPSPos.text=enguia.tr("Invalid latitude");return;}
			if(!position.longitudeValid){lblGPSPos.text=enguia.tr("invalid longitude");return;}
			if(!position.altitudeValid){lblGPSPos.text=enguia.tr("Invalid altitude");return;}
			gpsPosition=position.coordinate.latitude+", "+position.coordinate.longitude
		}
	}
	VMDlgDate{
		id: dlgDate
		onSigDateSelected: {
			switch(type){
				case 1://start
					btnStart.fillDate(dt);
					break;
				case 2://end
					btnEnd.fillDate(dt)
					break;
			}
		}
	}
	function saveFields(){
		if(txtName.text.length<3){statusBar.displayError(enguia.tr("Type a name"));return false;}
		if(txtBrief.text.length<3){statusBar.displayError(enguia.tr("Type a brief"));return false;}
		if(txtAddress.text.length<3){statusBar.displayError(enguia.tr("Type the address"));return false;}
		if(btnCity.tableID<1){statusBar.displayError(enguia.tr("Set the city"));return false;}
		ePlace.name=txtName.text.trim();
		ePlace.brief=txtBrief.text.trim();
		ePlace.address=txtAddress.text.trim();
		ePlace.phone1=txtPhone1.text.trim();
		ePlace.webSite=txtWebSite.text.trim();
		ePlace.cityID=btnCity.tableID
		ePlace.cityRegionID=comboCityRegion.getSelected();
		ePlace.categoryID=comboCategory.getSelected();
		ePlace.ageRange=comboAge.getSelected();
		ePlace.priceRange=comboPrice.getSelected();
		ePlace.userID=mShared.userID;
		ePlace.permissions=1024;
		ePlace.qualificationEnabled=true;
		ePlace.enabled=true;
		if(ePlace.categoryID===MSDefines.MainCategoryTypeEvents){
			ePlace.startDate=enguia.convertToDateOnly(btnStart.dt)
			ePlace.endDate=enguia.convertToDateOnly(btnEnd.dt)
			if(ePlace.startDate>ePlace.endDate){statusBar.displayError(enguia.tr("Start date must be less than end date"));return false;}
		}
		if(gpsPosition.length>0)ePlace.coordinate=gpsPosition;
		return true;
	}
	Component.onCompleted: {
		if(!positionSource.valid)lblGPSPos.text=enguia.tr("GPS is not available")
		comboCityRegion.append(MSDefines.CityRegionNotSpecified,enguia.tr("Not specified"))
		comboCityRegion.append(MSDefines.CityRegionNorth,enguia.tr("North"))
		comboCityRegion.append(MSDefines.CityRegionSouth,enguia.tr("South"))
		comboCityRegion.append(MSDefines.CityRegionEast, enguia.tr("East"))
		comboCityRegion.append(MSDefines.CityRegionWest,enguia.tr("West"))
		comboCityRegion.append(MSDefines.CityRegionCenter,enguia.tr("Center"))
		comboCategory.append(MSDefines.MainCategoryTypeTurism,enguia.tr("Tourism"))
		comboCategory.append(MSDefines.MainCategoryTypeEvents,enguia.tr("Event"))
		//age below
		comboAge.append(MSDefines.AgeRangeNotSpecified,mShared.getAgeRangeName(MSDefines.AgeRangeNotSpecified))
		comboAge.append(MSDefines.AgeRangeAll,mShared.getAgeRangeName(MSDefines.AgeRangeAll))
		comboAge.append(MSDefines.AgeRangeAfter18,mShared.getAgeRangeName(MSDefines.AgeRangeAfter18))
		comboAge.append(MSDefines.AgeRangeUpTo5,mShared.getAgeRangeName(MSDefines.AgeRangeUpTo5))
		comboAge.append(MSDefines.AgeRangeUpTo10,mShared.getAgeRangeName(MSDefines.AgeRangeUpTo10))
		comboAge.append(MSDefines.AgeRangeUpTo17,mShared.getAgeRangeName(MSDefines.AgeRangeUpTo17))
		comboAge.append(MSDefines.AgeRangeUpTo30,mShared.getAgeRangeName(MSDefines.AgeRangeUpTo30))
		comboAge.append(MSDefines.AgeRangeUpTo40,mShared.getAgeRangeName(MSDefines.AgeRangeUpTo40))
		comboAge.append(MSDefines.AgeRangeUpTo50,mShared.getAgeRangeName(MSDefines.AgeRangeUpTo50))
		comboAge.append(MSDefines.AgeRangeAfter50,mShared.getAgeRangeName(MSDefines.AgeRangeAfter50))
		//price below
		comboPrice.append(MSDefines.PriceRangeNotSpecified,mShared.getPriceRangeName(MSDefines.PriceRangeNotSpecified));
		comboPrice.append(MSDefines.PriceRangeAll,mShared.getPriceRangeName(MSDefines.PriceRangeAll));
		comboPrice.append(MSDefines.PriceRangeFree,mShared.getPriceRangeName(MSDefines.PriceRangeFree));
		comboPrice.append(MSDefines.PriceRangeUpTo10,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo10));
		comboPrice.append(MSDefines.PriceRangeUpTo20,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo20));
		comboPrice.append(MSDefines.PriceRangeUpTo30,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo30));
		comboPrice.append(MSDefines.PriceRangeUpTo40,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo40));
		comboPrice.append(MSDefines.PriceRangeUpTo50,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo50));
		comboPrice.append(MSDefines.PriceRangeUpTo60,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo60));
		comboPrice.append(MSDefines.PriceRangeUpTo70,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo70));
		comboPrice.append(MSDefines.PriceRangeUpTo80,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo80));
		comboPrice.append(MSDefines.PriceRangeUpTo90,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo90));
		comboPrice.append(MSDefines.PriceRangeUpTo100,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo100));
		comboPrice.append(MSDefines.PriceRangeUpTo150,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo150));
		comboPrice.append(MSDefines.PriceRangeUpTo200,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo200));
		comboPrice.append(MSDefines.PriceRangeUpTo250,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo250));
		comboPrice.append(MSDefines.PriceRangeUpTo300,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo300));
		comboPrice.append(MSDefines.PriceRangeUpTo350,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo350));
		comboPrice.append(MSDefines.PriceRangeUpTo400,mShared.getPriceRangeName(MSDefines.PriceRangeUpTo400));
		comboPrice.append(MSDefines.PriceRangeBeyond400,mShared.getPriceRangeName(MSDefines.PriceRangeBeyond400));
		if(ePlace.id<1){pageTitle.title=enguia.tr("New place");return;}
		else{
			pageTitle.title=enguia.tr("Edition");
			mSVC.metaInvoke(MSDefines.SPlaces,"GetFun",function(e){
				enguia.copyValues(e,ePlace)
				txtName.text=ePlace.name;
				txtBrief.text=ePlace.brief;
				txtAddress.text=ePlace.address;
				txtPhone1.text=ePlace.phone1;
				txtWebSite.text=ePlace.webSite;
				comboCityRegion.select(ePlace.cityRegionID)
				comboCategory.select(ePlace.categoryID)
				comboAge.select(ePlace.ageRange)
				comboPrice.select(ePlace.priceRange)
				btnCity.fill(ePlace.cityID, ePlace.cityName)
				if(ePlace.coordinate.length>0){gpsPosition=ePlace.coordinate; lblGPSPos.text=gpsPosition;}
				if(ePlace.categoryID===MSDefines.MainCategoryTypeEvents){
					btnStart.fillDate(ePlace.startDate)
					btnEnd.fillDate(ePlace.endDate)
				}
			},mShared.userID,ePlace.id);
		}
	}
}


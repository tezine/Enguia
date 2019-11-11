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
    id: tabAddress
    anchors.fill: parent
	color:enguia.backColor

    GridLayout{
        id: grid
        columns: 2
        anchors{top: parent.top;left: parent.left;right: parent.right;rightMargin:enguia.mediumMargin; leftMargin: enguia.mediumMargin;topMargin: enguia.mediumMargin}
		VMLabel{
			text: enguia.tr("Address")+":"
        }
        VMTextField{
            id: txtHomeAddress
            Layout.fillWidth: true
            maximumLength: 100
        }
		VMLabel{
			text: enguia.tr("Zipcode")+":"
        }
        VMTextField{
            id: txtPostalCode
            Layout.fillWidth: true
            maximumLength: 20
        }
		VMLabel{
			text: enguia.tr("Reference point")+":"
		}
		VMTextField{
			id: txtReferencePoint
			Layout.fillWidth: true
			maximumLength: 400
		}
		VMLabel{
			text: enguia.tr("City")+":"
        }
		VMButton{
            id: btnCity
            text: "..."
            Layout.fillWidth: true
			onClicked: dlgCities.open();
        }
		VMLabel{
			text: enguia.tr("City region")+":"
        }
		VMComboBox{
            id: comboCityRegion
			Layout.fillWidth: true
        }
    }
	VMDlgCity{
        id: dlgCities
		onSigCitySelected: btnCity.fill(cityID,cityName)
    }
	function saveFields(){
		eUser.cityRegion=comboCityRegion.getSelected();
		eUser.homeAddress=txtHomeAddress.text;
		eUser.homePostalCode=txtPostalCode.text;
		eUser.homeAddressReference=txtReferencePoint.text
		eUser.cityID=btnCity.tableID;
		if(eUser.cityID===0){statusBar.displayError("Invalid city");return false;}
		return true;
	}
    Component.onCompleted: {
		txtHomeAddress.text=eUser.homeAddress
		txtPostalCode.text=eUser.homePostalCode
		txtReferencePoint.text=eUser.homeAddressReference;
        btnCity.fill(eUser.cityID, eUser.cityName);
		comboCityRegion.append(MSDefines.CityRegionNorth,enguia.tr("North"))
		comboCityRegion.append(MSDefines.CityRegionSouth,enguia.tr("South"))
		comboCityRegion.append(MSDefines.CityRegionEast, enguia.tr("East"))
		comboCityRegion.append(MSDefines.CityRegionWest,enguia.tr("West"))
		comboCityRegion.append(MSDefines.CityRegionCenter,enguia.tr("Center"))
		comboCityRegion.select(eUser.cityRegion)
    }	
}


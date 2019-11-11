import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"

ComboBox{
    id:comboCityRegion
    style: comboBoxStyleAndroid
    textRole:"text"
    Layout.fillWidth: true
    model: ListModel{
        id: cityRegionModel
    }
    function setup(cityRegion){
        for(var i=0;i<cityRegionModel.count;i++) {
            if(cityRegionModel.get(i).tableID===cityRegion) {
                comboCityRegion.currentIndex=i;
                break;
            }
        }
    }
    function getCityRegionID(){
        return cityRegionModel.get(comboCityRegion.currentIndex).tableID;
    }
	Component.onCompleted: {
		cityRegionModel.append({text:enguia.tr("North"), tableID:MSDefines.CityRegionNorth})
		cityRegionModel.append({text: enguia.tr("South"), tableID:MSDefines.CityRegionSouth})
		cityRegionModel.append({text: enguia.tr("East"), tableID:MSDefines.CityRegionEast})
		cityRegionModel.append({text: enguia.tr("West"), tableID:MSDefines.CityRegionWest})
		cityRegionModel.append({text: enguia.tr("Center"), tableID:MSDefines.CityRegionCenter})
	}
}


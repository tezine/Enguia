import QtQuick 2.4
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.3
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



ComboBox {
	id:combo
	style: comboBoxStyleAndroid
	textRole: 'text'
	model: ListModel{
		id: comboModel
	}

	function select(type){
		for(var i=0;i<comboModel.count;i++) {
			if(comboModel.get(i).type===type) {
				combo.currentIndex=i;
				break;
			}
		}
	}
	function selectByName(name){
		for(var i=0;i<comboModel.count;i++) {
			if(comboModel.get(i).text===name) {
				combo.currentIndex=i;
				break;
			}
		}
	}
	function selectByValue(value){
		for(var i=0;i<comboModel.count;i++) {
			if(comboModel.get(i).value===value) {
				combo.currentIndex=i;
				break;
			}
		}
	}
	function selectByTypeAndValue(type,value){
		for(var i=0;i<comboModel.count;i++) {
			if(comboModel.get(i).type===type && comboModel.get(i).value===value) {
				combo.currentIndex=i;
				break;
			}
		}
	}
	function getSelected(){
		if(comboModel.count===0)return 0;
		return comboModel.get(combo.currentIndex).type;
	}
	function getSelectedName(){
		if(comboModel.count===0)return ""
		return comboModel.get(combo.currentIndex).text
	}	
	function getSelectedValue(){
		return comboModel.get(combo.currentIndex).value
	}
	function append(type, txt, value){
		comboModel.append({type:type, text:txt, value:value})
	}
	function remove(type){
		for(var i=0;i<comboModel.count;i++){
			if(comboModel.get(i).type===type){
				comboModel.remove(i);
				break;
			}
		}
	}

	function clear(){
		comboModel.clear();
	}
}


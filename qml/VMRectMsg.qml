import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Styles"

Rectangle {
    id: rectErro
    color:"darkred"
	anchors{left:parent.left;right:parent.right}
    height: enguia.height*0.1	
    visible: true
	signal sigTimeout();

    Label{
        id: lblError
        anchors{verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter}
        font{pointSize: enguia.largeFontPointSize}
        color: "white"
        wrapMode: Text.WordWrap
    }
    function display(mensagem){
        lblError.text=mensagem;
        rectErro.visible=true;
    }
    function displayWithTimer(mensagem, color){
        rectErro.color=color;
        lblError.text=mensagem;
        rectErro.visible=true;
		timer.start(5000);
        rectErro.z=1000;
    }
	function displaySuccess(msg){
		rectErro.color="#009688";
		lblError.text=msg;
		rectErro.visible=true;
		timer.start(5000)
		rectErro.z=1000;
	}
	function displayError(msg){
		rectErro.color="#F44336";
		lblError.text=msg;
		rectErro.visible=true;
		timer.start(5000)
		rectErro.z=1000;
	}
	function displayResult(ok, successMsg, errorMsg){
		if(ok===undefined){displayError(errorMsg);return;}
		if(ok)displaySuccess(successMsg)
		else displayError(errorMsg)
	}
	MSTimer {
        id: timer
        onTriggered: {
            rectErro.visible=false;
            rectErro.z=1;
			sigTimeout()
        }
    }
}

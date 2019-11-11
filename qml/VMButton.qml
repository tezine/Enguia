import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Button {
    property bool inverted: false
    property int tableID: 0
    property date dt: new Date()
    style: buttonStyleAndroid
    //onClicked: audioEngine.sounds["btnSound"].play();

    function fill(id, txt){
        text=txt;
        tableID=id;
    }
    function fillDate(dt){
        text= Qt.formatDate(dt,Qt.DefaultLocaleShortDate)
        this.dt=dt;
    }
}


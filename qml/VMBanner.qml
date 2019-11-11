import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
//InfoBanner

Rectangle{
    id: banner
    width:enguia.width
    height: enguia.height*0.1
    visible:false
    Label{
        id: lbl
        anchors{left:parent.left; verticalCenter:parent.verticalCenter;}
    }
    function popup(title, timeout) {
        lbl.text=title;
        if(timeout)timeout =timeout
        else timeout=3000
        open()
    }
}

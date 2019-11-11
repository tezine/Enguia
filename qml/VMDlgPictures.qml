import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

VMDlgBase{
    id: dlg
	title: enguia.tr("Pictures available")
    //buttonTexts: [ "Cancel"]
    signal sigPicSelected(string thumbPath, string bigPath, string fileName)

 ListModel{
        id: listModel
    }
   Rectangle{
        anchors{top:titleBar.bottom;bottom:parent.bottom;left:parent.left; leftMargin: enguia.mediumMargin; right:parent.right; rightMargin: enguia.mediumMargin}
        GridView{
            id: gridPics
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width
            cellWidth: 108
            cellHeight: 108
            model: listModel
            delegate: Image{
                source: model.thumbPath
                width: 108
                height: 108
                asynchronous: true
                MouseArea{
                    id: mouseArea
                    anchors.fill: parent
                    onClicked:{
                        sigPicSelected(model.thumbPath, model.bigPath, model.fileName)
                        dlg.close()
                    }
                }
            }
        }
    }
    function popup(completePath){
        listModel.clear();
        var list=mImages.galleryImages;
        for(var i=0;i<list.length;i++){
            listModel.append({thumbPath:list[i].thumbPath, bigPath:list[i].bigPath, fileName:list[i].fileName})
        }
        open()
    }
}

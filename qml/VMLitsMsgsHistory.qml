import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.wikios 1.0
import "qrc:/Agenda"
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

Item{
    clip: true
    property alias listModel: menuModel
    signal listItemClicked(int id, string name)
    signal listItemPressAndHold(int id, int index, int fromUserID, int toUserID)
    signal sigRequestNextPage(int nextPageNumber)
    property int nextBlockID:0
    property variant mXContacts
    property variant mXMessages

    ListModel{
        id: menuModel
    }
    ListView{
        id: listView
        anchors.fill: parent
        model: menuModel
        clip: true
        delegate:  Item{
            id: listItem
            anchors{left: parent.left; leftMargin: wikios.mediumMargin ; right: parent.right; rightMargin: wikios.mediumMargin}
            width: parent.width
            BorderImage{
                id: background
                anchors{left: parent.left;right: parent.right;top: parent.top;topMargin: wikios.mediumMargin;bottom: parent.bottom}
                border { left: model.left; top: model.top; right: model.right; bottom: model.bottom }
                horizontalTileMode: BorderImage.Stretch
                verticalTileMode: BorderImage.Stretch
                source: model.imageSource
                Label{
                    id: mainText
                    anchors{left: parent.left;leftMargin: wikios.smallMargin; top: parent.top;topMargin: wikios.mediumMargin;right: parent.right; rightMargin: wikios.smallMargin}
                    font{pointSize: wikios.mediumFontPointSize}
                    color: "black"
                    text: model.msg
                    wrapMode: Text.Wrap
                }
                Label{
                    id: lblDate
                    anchors{right: parent.right;rightMargin: wikios.smallMargin;bottom: parent.bottom;bottomMargin: wikios.mediumMargin}
                    font{pointSize: wikios.tinyFontPointSize}
                    text: model.dateInserted
                    color: "black"
                    visible: !isLoadNext
                }
                Row{
                    id: btnRow
                    anchors{left:parent.left; leftMargin: wikios.smallMargin; bottom:parent.bottom;}
                    spacing: wikios.largeMargin
                    visible: model.msgType===MsgType.InviteUser?true:false
                    /*IconButton{
                        title:qsTr("Yes")
                        iconSource: "qrc:/Images/accept.png"
                        onSigClicked:{
                            mXContacts.acceptUserAsFriend(model.fromUserID, true)
                            mXMessages.removeMessage(model.tableID);
                            menuModel.remove(index)
                        }
                    }
                    IconButton{
                        title:qsTr("No")
                        iconSource: "qrc:/Images/cancel.png"
                        onSigClicked:{
                            mXContacts.acceptUserAsFriend(model.fromUserID, false)
                            mXMessages.removeMessage(model.tableID);
                            menuModel.remove(index)
                        }
                    }*/
                }
            }
            MouseArea{
                id: mouseArea
                anchors.fill: background
                onPressed: {
                    var child=background.childAt(mouseX,mouseY);
                    if(child && child.objectName==="btnRow")mouse.accepted = false
                }
                onClicked: {
                    if(tableID===-1){
                        sigRequestNextPage(nextBlockID)
                        menuModel.remove(index);
                        return;
                    }
                    listItemClicked(model.page, model.msg)
                }
                onPressAndHold: listItemPressAndHold(model.tableID, model.index, model.fromUserID, model.toUserID)
            }
            Component.onCompleted:{
                listItem.height=mainText.height+lblDate.height+ 30
            }
        }
    }
    /*ScrollDecorator{
        flickableItem: listView
    }*/
    function append(id, msg, dateInserted, fromUserID, toUserID, msgType){
        var imageSource="";
        var left, top, right, bottom=0;
        /*if(fromUserID===mData.userID){
            imageSource="qrc:///Images/bubble1"
            left=20;
            top=10;
            right=10;
            bottom=20
        }
        else{*/
            imageSource="qrc:///Images/comment";
            left=10;
            top=20;
            right=20;
            bottom=10;
        //}
        menuModel.append({"tableID":id,
            "msg":msg,
            "dateInserted":Qt.formatDate(dateInserted,Qt.DefaultLocaleShortDate),
            "fromUserID":fromUserID,
            "toUserID":toUserID,
            "imageSource":imageSource,
            "left":left,
            "top":top,
            "right":right,
            "bottom":bottom,
            msgType:msgType,
        isLoadNext:false})
    }
    function appendFinished(){
        nextBlockID=nextBlockID+1;
        listModel.append({tableID:-1, msg:qsTr("Load Next ")+"25" + qsTr(" Entries..."),
        dateInserted:'',toUserID:0, image:"qrc:///Images/sync",left:0,top:0,right:0,bottom:0, msgType:0, isLoadNext:true})
    }
    function reset(){
        listModel.clear();
        nextBlockID=0;
    }
    function init(){
        reset();
        //mXContacts=mData.mContacts;
    //	mXMessages=mData.mMessages;
    }
    Component.onCompleted: init()
}


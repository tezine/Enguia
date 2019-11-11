import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockWelcome"

Dialog {
    id: dlg
    visible:false
	modality: Qt.NonModal
    property alias title: titlebar.title
    property alias titleBar:titlebar

    contentItem: Rectangle {
        implicitWidth:enguia.width*0.8
		implicitHeight:gridLayout.height+titlebar.height+enguia.height*0.05
        VSharedTitleBar{
            id: titlebar
            anchors{top:parent.top}
            width: parent.width;
			title: enguia.tr("Timetable")
			cancelText: enguia.tr("Ok");
            saveVisible: false
            onSigCancelClicked: close();
        }
       GridLayout{
		   id: gridLayout
           columns:2
		   anchors{top:titleBar.bottom;left:parent.left;right:parent.right;}
		   anchors.margins: enguia.mediumMargin
            VMLabel{
				text:enguia.tr("Monday")
            }
            VMLabel{
				id: lblMonday
            }
            VMLabel{
				text:enguia.tr("Tuesday")
            }
            VMLabel{
				id: lblTuesday
            }
            VMLabel{
				text:enguia.tr("Wednesday")
            }
            VMLabel{
				id: lblWednesday
            }
            VMLabel{
				text:enguia.tr("Thursday")
            }
            VMLabel{
				id: lblThursday
            }
            VMLabel{
				text:enguia.tr("Friday")
            }
            VMLabel{
				id: lblFriday
            }
            VMLabel{
				text:enguia.tr("Saturday")
            }
            VMLabel{
				id: lblSaturday
            }
            VMLabel{
				text:enguia.tr("Sunday")
            }
            VMLabel{
				id: lblSunday
            }
			/*Label{
				text:enguia.tr("Holidays")
			}
			Label{
				id: lblHolidays
			}*/
       }
    }
	function getTime(start, end){
		if(!start)return enguia.tr("Closed");
		if(Qt.formatTime(start,"hh:mm")==="00:00")return enguia.tr("Closed");
		else return Qt.formatTime(start,"hh:mm")+enguia.tr(" until ")+Qt.formatTime(end,"hh:mm")
	}
	function setup(erBlockWelcome){
		lblMonday.text=getTime(erBlockWelcome.mondayStart, erBlockWelcome.mondayEnd)
		lblTuesday.text=getTime(erBlockWelcome.tuesdayStart,erBlockWelcome.tuesdayEnd)
		lblWednesday.text=getTime(erBlockWelcome.wednesdayStart, erBlockWelcome.wednesdayEnd)
		lblThursday.text=getTime(erBlockWelcome.thursdayStart, erBlockWelcome.thursdayEnd)
		lblFriday.text=getTime(erBlockWelcome.fridayStart, erBlockWelcome.fridayEnd)
		lblSaturday.text=getTime(erBlockWelcome.saturdayStart, erBlockWelcome.saturdayEnd)
		lblSunday.text=getTime(erBlockWelcome.sundayStart, erBlockWelcome.sundayEnd)
		//lblHolidays.text=getTime(erBlockWelcome.holidayStart, erBlockWelcome.holidayEnd)
		open();
	}
}

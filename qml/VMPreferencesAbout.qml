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
    signal sigLoadCredits();

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("About")
        busyIndicator.visible: false
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
    }
    TabView{
        id: tabView
        anchors{top: pageTitle.bottom;bottom: parent.bottom}
        width: parent.width
        style: tabViewStyleAndroid
        Tab{
			title:enguia.tr("Info");
			VMPreferencesAboutInfo{
            }
        }
        Tab{
			title:enguia.tr("Credits");
			VMPreferencesAboutCredits{
            }
        }
		Tab{
			title:enguia.tr("License");
			VMPreferencesAboutLicense{
			}
		}
    }
}



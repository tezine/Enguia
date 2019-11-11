include( ../Lib/lib.pri )
include( models/models.pri )
include( entities/entities.pri )
include( ../EnguiaShared/enguiashared.pri )

TEMPLATE = app
TARGET = Enguia
RC_FILE = enguiamobile.rc
DEFINES+=ENGUIAMOBILE
#CONFIG += qtquickcompiler
QT += qml quick widgets core sql network  xml  positioning
android{
    DEFINES+=EnguiaMobileAndroid
    QT+=androidextras
	PROJETOSPATH=C:/ProjetosAntigos
}
ios{
    DEFINES+=EnguiaMobileIOS
	QTPLUGIN= qavfcamera
    PROJETOSPATH=/Users/tezine/Projetos
    #QMAKE_INFO_PLIST = $$PROJETOSPATH/Enguia/EnguiaMobile/otherfiles/Info.plist
    ios_icon.files = $$files($$PWD/images/ios/AppIcon*.png)
    QMAKE_BUNDLE_DATA += ios_icon
    OTHER_FILES+= other/Info.plist
}
windows{
    DEFINES+=EnguiaMobileWindows
	PROJETOSPATH=C:/ProjetosAntigos
}
winphone{
    DEFINES+=EnguiaMobileWinPhone
    PROJETOSPATH=D:/Projetos
}
mac{
    DEFINES+=EnguiaMobileMac
    PROJETOSPATH=/Users/tezine/Projetos
}
DEFINES+= ENGUIAVERSION=\\\"1.12.2\\\"
ENGUIAMOBILEPATH=$$PROJETOSPATH/EnguiaComStudio/EnguiaMobile

INCLUDEPATH+= $$PROJETOSPATH/EnguiaComStudio/Lib \
				$$ENGUIAMOBILEPATH/models \
				$$ENGUIAMOBILEPATH/entities \
				$$ENGUIAMOBILEPATH/EnguiaShared \ #usado qdo compila para ios
				$$ENGUIAMOBILEPATH/EnguiaShared/jsonrpc \#usado qdo compila para ios
				$$PROJETOSPATH/EnguiaComStudio/EnguiaShared \
								$$PROJETOSPATH/EnguiaComStudio/EnguiaShared/jsonrpc \
								$$PROJETOSPATH/EnguiaComStudio/EnguiaMobile

OTHER_FILES+= entities/enguiamobiledataclasses.xml \
                        android/src/com/tezine/enguiamobile/InterJava.java \
						android/src/com/tezine/enguiamobile/MainActivity.java \
						android/src/com/tezine/enguiamobile/RegistrationIntentService.java \
						android/src/com/tezine/enguiamobile/Variables.java

HEADERS+=AppDelegate.h

SOURCES += main.cpp


RESOURCES += qml/qmlfiles.qrc \
    other/otherfiles.qrc \
    images/imagesfiles.qrc \
	$$PROJETOSPATH/EnguiaComStudio/EnguiaShared/enguiasharedfiles.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/AndroidManifest.xml \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OBJECTIVE_SOURCES += \
    AppDelegate.mm \
    EnguiaAppDelegate.mm


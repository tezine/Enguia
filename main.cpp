#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick>
#include "enguia.h"
#include "mmobile.h"
#include "mflow.h"
#include "euser.h"
#include "eplace.h"
#include "dataenguiamobile.h"
#include "pandroid.h"

//shared below
#include "dataenguiashared.h"
#include "msdefines.h"
#include "mshared.h"
#include "msblocks.h"
#include "msfiles.h"
#include "msusers.h"
#include "msorder.h"
#include "msagenda.h"
#include "msvc.h"
#include "bmeta.h"
#include "mstimer.h"
#include "dstore.h"

#include "AppDelegate.h"

/*
 *Enguia Mobile main function
 */
int main(int argc, char *argv[]){
	QApplication app(argc, argv);
	QApplication::setOrganizationName("Tezine Technologies");
	QApplication::setOrganizationDomain("enguia.net");
	QApplication::setApplicationName("Enguia Mobile");
	QQmlApplicationEngine engine;
	Enguia *enguia=new Enguia();
	enguia->setup(320,600);
	new MShared(engine);
	BMeta::obj()->setup(QList<QMetaObject>()<<DATAENGUIAMOBILE::getMeta()<<DATAENGUIASHARED::getMeta());
	qmlRegisterType<MMobile>("com.tezine.enguia", 1, 0, "MMobile");
	engine.rootContext()->setContextProperty("enguia", enguia);//use this to create a global object
	engine.rootContext()->setContextProperty("mMobile", MMobile::obj());
	engine.rootContext()->setContextProperty("mFlow", MFlow::obj());
    //shared below
	qmlRegisterType<MSDefines>("com.tezine.enguia", 1, 0, "MSDefines");
	qmlRegisterType<MSTimer>("com.tezine.enguia", 1, 0, "MSTimer");
	engine.rootContext()->setContextProperty("mShared", MShared::obj());
	engine.rootContext()->setContextProperty("mSBlocks", MSBlocks::obj());
	engine.rootContext()->setContextProperty("mSFiles", MSFiles::obj());
	engine.rootContext()->setContextProperty("mSUsers", MSUsers::obj());
	engine.rootContext()->setContextProperty("mSOrder", MSOrder::obj());
	engine.rootContext()->setContextProperty("mSAgenda", MSAgenda::obj());
	engine.rootContext()->setContextProperty("mSVC", MSVC::obj());
	engine.rootContext()->setContextProperty("dstore", DStore::obj());


	MShared::obj()->setPreviewMode(false);
	engine.load(QUrl(QStringLiteral("qrc:/VMMainWindow.qml")));


    return app.exec();
}

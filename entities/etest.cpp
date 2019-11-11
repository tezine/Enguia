#include <QtCore>
#include "blogger.h"
#include "etest.h"

ETest::ETest(QObject *parent):QObject(parent){
}

QMetaObject ETest::getMeta(){
	if(QMetaType::type("ETest")==0){
		qRegisterMetaType<ETest>();
		qRegisterMetaType<ETest*>();
		qRegisterMetaType<QList<ETest*> >();
		qRegisterMetaType<QList<ETest> >();
	}
	return ETest::staticMetaObject;
}


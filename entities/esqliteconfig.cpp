#include <QtCore>
#include "blogger.h"
#include "esqliteconfig.h"

ESqliteConfig::ESqliteConfig(QObject *parent):QObject(parent){
	languageCodeID=0;
	currentCityID=0;
}

QMetaObject ESqliteConfig::getMeta(){
	if(QMetaType::type("ESqliteConfig")==0){
		qRegisterMetaType<ESqliteConfig>();
		qRegisterMetaType<ESqliteConfig*>();
		qRegisterMetaType<QList<ESqliteConfig*> >();
		qRegisterMetaType<QList<ESqliteConfig> >();
	}
	return ESqliteConfig::staticMetaObject;
}


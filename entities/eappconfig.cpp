#include <QtCore>
#include "blogger.h"
#include "eappconfig.h"

EAppConfig::EAppConfig(QObject *parent):QObject(parent){
	id=0;
	agendaSorting=0;
	agendaPeriod=0;
	cityID=0;
	autoLogin=0;
	swVersion=0;
	agreementVersion=0;
	isValid=0;
	listCount=0;
	lastMsgRead=0;
}

QMetaObject EAppConfig::getMeta(){
	if(QMetaType::type("EAppConfig")==0){
		qRegisterMetaType<EAppConfig>();
		qRegisterMetaType<EAppConfig*>();
		qRegisterMetaType<QList<EAppConfig*> >();
		qRegisterMetaType<QList<EAppConfig> >();
	}
	return EAppConfig::staticMetaObject;
}


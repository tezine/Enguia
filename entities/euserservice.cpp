#include <QtCore>
#include "blogger.h"
#include "euserservice.h"
#include "float.h"

EUserService::EUserService(QObject *parent):QObject(parent){
	id=0;
	professionalUserID=0;
	price=0;
	duration=0;
	maxPerUserOnDay=0;
	maxPerUserOnWeek=0;
	maxPerUserOnMonth=0;
}

QMetaObject EUserService::getMeta(){
	if(QMetaType::type("EUserService")==0){
		qRegisterMetaType<EUserService>();
		qRegisterMetaType<EUserService*>();
		qRegisterMetaType<QList<EUserService*> >();
		qRegisterMetaType<QList<EUserService> >();
	}
	return EUserService::staticMetaObject;
}


#include <QtCore>
#include "blogger.h"
#include "enewgrouped.h"

ENewGrouped::ENewGrouped(QObject *parent):QObject(parent){
	placeID=0;
	contactID=0;
	unreadCount=0;
}

QMetaObject ENewGrouped::getMeta(){
	if(QMetaType::type("ENewGrouped")==0){
		qRegisterMetaType<ENewGrouped>();
		qRegisterMetaType<ENewGrouped*>();
		qRegisterMetaType<QList<ENewGrouped*> >();
		qRegisterMetaType<QList<ENewGrouped> >();
	}
	return ENewGrouped::staticMetaObject;
}


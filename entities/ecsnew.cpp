#include <QtCore>
#include "blogger.h"
#include "ecsnew.h"

ECSNew::ECSNew(QObject *parent):QObject(parent){
	id=0;
	contactID=0;
	userID=0;
	likesCount=0;
}

QMetaObject ECSNew::getMeta(){
	if(QMetaType::type("ECSNew")==0){
		qRegisterMetaType<ECSNew>();
		qRegisterMetaType<ECSNew*>();
		qRegisterMetaType<QList<ECSNew*> >();
		qRegisterMetaType<QList<ECSNew> >();
	}
	return ECSNew::staticMetaObject;
}


#include <QtCore>
#include "blogger.h"
#include "eicon.h"

EIcon::EIcon(QObject *parent):QObject(parent){
	id=0;
	iconType=0;
	typeID=0;
}

QMetaObject EIcon::getMeta(){
	if(QMetaType::type("EIcon")==0){
		qRegisterMetaType<EIcon>();
		qRegisterMetaType<EIcon*>();
		qRegisterMetaType<QList<EIcon*> >();
		qRegisterMetaType<QList<EIcon> >();
	}
	return EIcon::staticMetaObject;
}


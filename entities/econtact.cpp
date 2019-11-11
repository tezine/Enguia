#include <QtCore>
#include "blogger.h"
#include "econtact.h"

EContact::EContact(QObject *parent):QObject(parent){
	userID=0;
	placeID=0;
}

QMetaObject EContact::getMeta(){
	if(QMetaType::type("EContact")==0){
		qRegisterMetaType<EContact>();
		qRegisterMetaType<EContact*>();
		qRegisterMetaType<QList<EContact*> >();
		qRegisterMetaType<QList<EContact> >();
	}
	return EContact::staticMetaObject;
}


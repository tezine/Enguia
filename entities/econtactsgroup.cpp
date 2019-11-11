#include <QtCore>
#include "blogger.h"
#include "econtactsgroup.h"

EContactsGroup::EContactsGroup(QObject *parent):QObject(parent){
	id=0;
	iconID=0;
}

QMetaObject EContactsGroup::getMeta(){
	if(QMetaType::type("EContactsGroup")==0){
		qRegisterMetaType<EContactsGroup>();
		qRegisterMetaType<EContactsGroup*>();
		qRegisterMetaType<QList<EContactsGroup*> >();
		qRegisterMetaType<QList<EContactsGroup> >();
	}
	return EContactsGroup::staticMetaObject;
}


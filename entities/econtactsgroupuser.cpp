#include <QtCore>
#include "blogger.h"
#include "econtactsgroupuser.h"

EContactsGroupUser::EContactsGroupUser(QObject *parent):QObject(parent){
	id=0;
	groupID=0;
	contactID=0;
}

QMetaObject EContactsGroupUser::getMeta(){
	if(QMetaType::type("EContactsGroupUser")==0){
		qRegisterMetaType<EContactsGroupUser>();
		qRegisterMetaType<EContactsGroupUser*>();
		qRegisterMetaType<QList<EContactsGroupUser*> >();
		qRegisterMetaType<QList<EContactsGroupUser> >();
	}
	return EContactsGroupUser::staticMetaObject;
}


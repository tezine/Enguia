#include <QtCore>
#include "blogger.h"
#include "euserclient.h"

EUserClient::EUserClient(QObject *parent):QObject(parent){
	id=0;
	professionalUserID=0;
	clientUserID=0;
	rating=0;
	cityID=0;
	cityRegion=0;
}

QMetaObject EUserClient::getMeta(){
	if(QMetaType::type("EUserClient")==0){
		qRegisterMetaType<EUserClient>();
		qRegisterMetaType<EUserClient*>();
		qRegisterMetaType<QList<EUserClient*> >();
		qRegisterMetaType<QList<EUserClient> >();
	}
	return EUserClient::staticMetaObject;
}


#include <QtCore>
#include "blogger.h"
#include "euserserviceexception.h"

EUserServiceException::EUserServiceException(QObject *parent):QObject(parent){
	id=0;
	professionalUserID=0;
	status=0;
}

QMetaObject EUserServiceException::getMeta(){
	if(QMetaType::type("EUserServiceException")==0){
		qRegisterMetaType<EUserServiceException>();
		qRegisterMetaType<EUserServiceException*>();
		qRegisterMetaType<QList<EUserServiceException*> >();
		qRegisterMetaType<QList<EUserServiceException> >();
	}
	return EUserServiceException::staticMetaObject;
}


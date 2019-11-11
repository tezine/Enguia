#include <QtCore>
#include "blogger.h"
#include "euserschedule.h"

EUserSchedule::EUserSchedule(QObject *parent):QObject(parent){
	id=0;
	visualID=0;
	professionalUserID=0;
	clientUserID=0;
	serviceID=0;
	status=0;
	clientID=0;
}

QMetaObject EUserSchedule::getMeta(){
	if(QMetaType::type("EUserSchedule")==0){
		qRegisterMetaType<EUserSchedule>();
		qRegisterMetaType<EUserSchedule*>();
		qRegisterMetaType<QList<EUserSchedule*> >();
		qRegisterMetaType<QList<EUserSchedule> >();
	}
	return EUserSchedule::staticMetaObject;
}


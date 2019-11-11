#include <QtCore>
#include "blogger.h"
#include "euserblockschedule.h"

EUserBlockSchedule::EUserBlockSchedule(QObject *parent):QObject(parent){
	id=0;
	userID=0;
	visibility=0;
}

QMetaObject EUserBlockSchedule::getMeta(){
	if(QMetaType::type("EUserBlockSchedule")==0){
		qRegisterMetaType<EUserBlockSchedule>();
		qRegisterMetaType<EUserBlockSchedule*>();
		qRegisterMetaType<QList<EUserBlockSchedule*> >();
		qRegisterMetaType<QList<EUserBlockSchedule> >();
	}
	return EUserBlockSchedule::staticMetaObject;
}


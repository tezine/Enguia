#include <QtCore>
#include "blogger.h"
#include "euserservicetimetablestatus.h"

EUserServiceTimetableStatus::EUserServiceTimetableStatus(QObject *parent):QObject(parent){
	id=0;
	professionalUserID=0;
	weekDay=0;
	status=0;
	sameAsWeekDay=0;
}

QMetaObject EUserServiceTimetableStatus::getMeta(){
	if(QMetaType::type("EUserServiceTimetableStatus")==0){
		qRegisterMetaType<EUserServiceTimetableStatus>();
		qRegisterMetaType<EUserServiceTimetableStatus*>();
		qRegisterMetaType<QList<EUserServiceTimetableStatus*> >();
		qRegisterMetaType<QList<EUserServiceTimetableStatus> >();
	}
	return EUserServiceTimetableStatus::staticMetaObject;
}


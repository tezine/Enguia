#include <QtCore>
#include "blogger.h"
#include "euserservicetimetable.h"

EUserServiceTimetable::EUserServiceTimetable(QObject *parent):QObject(parent){
	id=0;
	serviceID=0;
	weekDay=0;
	maximumCount=0;
	gapDisplayed=0;
}

QMetaObject EUserServiceTimetable::getMeta(){
	if(QMetaType::type("EUserServiceTimetable")==0){
		qRegisterMetaType<EUserServiceTimetable>();
		qRegisterMetaType<EUserServiceTimetable*>();
		qRegisterMetaType<QList<EUserServiceTimetable*> >();
		qRegisterMetaType<QList<EUserServiceTimetable> >();
	}
	return EUserServiceTimetable::staticMetaObject;
}


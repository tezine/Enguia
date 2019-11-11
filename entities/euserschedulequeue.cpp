#include <QtCore>
#include "blogger.h"
#include "euserschedulequeue.h"

EUserScheduleQueue::EUserScheduleQueue(QObject *parent):QObject(parent){
	id=0;
	professionalUserID=0;
	clientUserID=0;
	serviceID=0;
}

QMetaObject EUserScheduleQueue::getMeta(){
	if(QMetaType::type("EUserScheduleQueue")==0){
		qRegisterMetaType<EUserScheduleQueue>();
		qRegisterMetaType<EUserScheduleQueue*>();
		qRegisterMetaType<QList<EUserScheduleQueue*> >();
		qRegisterMetaType<QList<EUserScheduleQueue> >();
	}
	return EUserScheduleQueue::staticMetaObject;
}


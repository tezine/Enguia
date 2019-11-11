#include <QtCore>
#include "blogger.h"
#include "euserscheduleconfirmation.h"

EUserScheduleConfirmation::EUserScheduleConfirmation(QObject *parent):QObject(parent){
	serviceID=0;
	professionalUserID=0;
	servicePrice=0;
	currencyType=0;
	status=0;
	minimumCancelTime=0;
}

QMetaObject EUserScheduleConfirmation::getMeta(){
	if(QMetaType::type("EUserScheduleConfirmation")==0){
		qRegisterMetaType<EUserScheduleConfirmation>();
		qRegisterMetaType<EUserScheduleConfirmation*>();
		qRegisterMetaType<QList<EUserScheduleConfirmation*> >();
		qRegisterMetaType<QList<EUserScheduleConfirmation> >();
	}
	return EUserScheduleConfirmation::staticMetaObject;
}


#include <QtCore>
#include "blogger.h"
#include "euserhistory.h"

EUserHistory::EUserHistory(QObject *parent):QObject(parent){
	historyType=0;
	id=0;
	visualID=0;
	placeID=0;
}

QMetaObject EUserHistory::getMeta(){
	if(QMetaType::type("EUserHistory")==0){
		qRegisterMetaType<EUserHistory>();
		qRegisterMetaType<EUserHistory*>();
		qRegisterMetaType<QList<EUserHistory*> >();
		qRegisterMetaType<QList<EUserHistory> >();
	}
	return EUserHistory::staticMetaObject;
}


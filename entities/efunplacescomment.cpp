#include <QtCore>
#include "blogger.h"
#include "efunplacescomment.h"

EFunPlacesComment::EFunPlacesComment(QObject *parent):QObject(parent){
	id=0;
	funID=0;
	userID=0;
	rating=0;
}

QMetaObject EFunPlacesComment::getMeta(){
	if(QMetaType::type("EFunPlacesComment")==0){
		qRegisterMetaType<EFunPlacesComment>();
		qRegisterMetaType<EFunPlacesComment*>();
		qRegisterMetaType<QList<EFunPlacesComment*> >();
		qRegisterMetaType<QList<EFunPlacesComment> >();
	}
	return EFunPlacesComment::staticMetaObject;
}


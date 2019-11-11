#include <QtCore>
#include "blogger.h"
#include "ecsfunplacecomment.h"

ECSFunPlaceComment::ECSFunPlaceComment(QObject *parent):QObject(parent){
	id=0;
	funID=0;
	userID=0;
	rating=0;
	categoryID=0;
}

QMetaObject ECSFunPlaceComment::getMeta(){
	if(QMetaType::type("ECSFunPlaceComment")==0){
		qRegisterMetaType<ECSFunPlaceComment>();
		qRegisterMetaType<ECSFunPlaceComment*>();
		qRegisterMetaType<QList<ECSFunPlaceComment*> >();
		qRegisterMetaType<QList<ECSFunPlaceComment> >();
	}
	return ECSFunPlaceComment::staticMetaObject;
}


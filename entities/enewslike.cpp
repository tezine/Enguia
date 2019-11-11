#include <QtCore>
#include "blogger.h"
#include "enewslike.h"

ENewsLike::ENewsLike(QObject *parent):QObject(parent){
	id=0;
	newsID=0;
	userID=0;
}

QMetaObject ENewsLike::getMeta(){
	if(QMetaType::type("ENewsLike")==0){
		qRegisterMetaType<ENewsLike>();
		qRegisterMetaType<ENewsLike*>();
		qRegisterMetaType<QList<ENewsLike*> >();
		qRegisterMetaType<QList<ENewsLike> >();
	}
	return ENewsLike::staticMetaObject;
}


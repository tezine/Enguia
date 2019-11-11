#include <QtCore>
#include "blogger.h"
#include "ecsnewlike.h"

ECSNewLike::ECSNewLike(QObject *parent):QObject(parent){
	id=0;
	newsID=0;
	userID=0;
	likeIt=0;
}

QMetaObject ECSNewLike::getMeta(){
	if(QMetaType::type("ECSNewLike")==0){
		qRegisterMetaType<ECSNewLike>();
		qRegisterMetaType<ECSNewLike*>();
		qRegisterMetaType<QList<ECSNewLike*> >();
		qRegisterMetaType<QList<ECSNewLike> >();
	}
	return ECSNewLike::staticMetaObject;
}


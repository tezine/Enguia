#include <QtCore>
#include "blogger.h"
#include "enewscomment.h"

ENewsComment::ENewsComment(QObject *parent):QObject(parent){
	id=0;
	newsID=0;
	userID=0;
}

QMetaObject ENewsComment::getMeta(){
	if(QMetaType::type("ENewsComment")==0){
		qRegisterMetaType<ENewsComment>();
		qRegisterMetaType<ENewsComment*>();
		qRegisterMetaType<QList<ENewsComment*> >();
		qRegisterMetaType<QList<ENewsComment> >();
	}
	return ENewsComment::staticMetaObject;
}


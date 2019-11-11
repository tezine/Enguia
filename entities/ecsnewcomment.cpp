#include <QtCore>
#include "blogger.h"
#include "ecsnewcomment.h"

ECSNewComment::ECSNewComment(QObject *parent):QObject(parent){
	id=0;
	newsID=0;
	userID=0;
}

QMetaObject ECSNewComment::getMeta(){
	if(QMetaType::type("ECSNewComment")==0){
		qRegisterMetaType<ECSNewComment>();
		qRegisterMetaType<ECSNewComment*>();
		qRegisterMetaType<QList<ECSNewComment*> >();
		qRegisterMetaType<QList<ECSNewComment> >();
	}
	return ECSNewComment::staticMetaObject;
}


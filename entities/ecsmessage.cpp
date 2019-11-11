#include <QtCore>
#include "blogger.h"
#include "ecsmessage.h"

ECSMessage::ECSMessage(QObject *parent):QObject(parent){
	id=0;
	fromUserID=0;
	toUserID=0;
	msgType=0;
}

QMetaObject ECSMessage::getMeta(){
	if(QMetaType::type("ECSMessage")==0){
		qRegisterMetaType<ECSMessage>();
		qRegisterMetaType<ECSMessage*>();
		qRegisterMetaType<QList<ECSMessage*> >();
		qRegisterMetaType<QList<ECSMessage> >();
	}
	return ECSMessage::staticMetaObject;
}


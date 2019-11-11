#include <QtCore>
#include "blogger.h"
#include "edistinctmsguser.h"

EDistinctMsgUser::EDistinctMsgUser(QObject *parent):QObject(parent){
	userID=0;
	msgID=0;
}

QMetaObject EDistinctMsgUser::getMeta(){
	if(QMetaType::type("EDistinctMsgUser")==0){
		qRegisterMetaType<EDistinctMsgUser>();
		qRegisterMetaType<EDistinctMsgUser*>();
		qRegisterMetaType<QList<EDistinctMsgUser*> >();
		qRegisterMetaType<QList<EDistinctMsgUser> >();
	}
	return EDistinctMsgUser::staticMetaObject;
}


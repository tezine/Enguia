#include <QtCore>
#include "blogger.h"
#include "emobilecounts.h"

EMobileCounts::EMobileCounts(QObject *parent):QObject(parent){
	unreadMsgCount=0;
	unreadNewsCount=0;
	unreadQualificationsCount=0;
}

QMetaObject EMobileCounts::getMeta(){
	if(QMetaType::type("EMobileCounts")==0){
		qRegisterMetaType<EMobileCounts>();
		qRegisterMetaType<EMobileCounts*>();
		qRegisterMetaType<QList<EMobileCounts*> >();
		qRegisterMetaType<QList<EMobileCounts> >();
	}
	return EMobileCounts::staticMetaObject;
}


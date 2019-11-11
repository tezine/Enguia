#include <QtCore>
#include "blogger.h"
#include "euserblocktext.h"

EUserBlockText::EUserBlockText(QObject *parent):QObject(parent){
	id=0;
	userID=0;
}

QMetaObject EUserBlockText::getMeta(){
	if(QMetaType::type("EUserBlockText")==0){
		qRegisterMetaType<EUserBlockText>();
		qRegisterMetaType<EUserBlockText*>();
		qRegisterMetaType<QList<EUserBlockText*> >();
		qRegisterMetaType<QList<EUserBlockText> >();
	}
	return EUserBlockText::staticMetaObject;
}


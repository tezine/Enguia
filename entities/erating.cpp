#include <QtCore>
#include "blogger.h"
#include "erating.h"

ERating::ERating(QObject *parent):QObject(parent){
	rating=0;
	voteCount=0;
}

QMetaObject ERating::getMeta(){
	if(QMetaType::type("ERating")==0){
		qRegisterMetaType<ERating>();
		qRegisterMetaType<ERating*>();
		qRegisterMetaType<QList<ERating*> >();
		qRegisterMetaType<QList<ERating> >();
	}
	return ERating::staticMetaObject;
}


#include <QtCore>
#include "blogger.h"
#include "esearch.h"

ESearch::ESearch(QObject *parent):QObject(parent){
	id=0;
	type=0;
	categoryID=0;
	rating=0;
	viewCount=0;
}

QMetaObject ESearch::getMeta(){
	if(QMetaType::type("ESearch")==0){
		qRegisterMetaType<ESearch>();
		qRegisterMetaType<ESearch*>();
		qRegisterMetaType<QList<ESearch*> >();
		qRegisterMetaType<QList<ESearch> >();
	}
	return ESearch::staticMetaObject;
}


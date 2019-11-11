#include <QtCore>
#include "blogger.h"
#include "ecategory.h"

ECategory::ECategory(QObject *parent):QObject(parent){
	id=0;
	parentID=0;
}

QMetaObject ECategory::getMeta(){
	if(QMetaType::type("ECategory")==0){
		qRegisterMetaType<ECategory>();
		qRegisterMetaType<ECategory*>();
		qRegisterMetaType<QList<ECategory*> >();
		qRegisterMetaType<QList<ECategory> >();
	}
	return ECategory::staticMetaObject;
}


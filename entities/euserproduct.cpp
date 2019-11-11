#include <QtCore>
#include "blogger.h"
#include "euserproduct.h"

EUserProduct::EUserProduct(QObject *parent):QObject(parent){
	id=0;
	userID=0;
	categoryID=0;
	price=0;
	viewCount=0;
}

QMetaObject EUserProduct::getMeta(){
	if(QMetaType::type("EUserProduct")==0){
		qRegisterMetaType<EUserProduct>();
		qRegisterMetaType<EUserProduct*>();
		qRegisterMetaType<QList<EUserProduct*> >();
		qRegisterMetaType<QList<EUserProduct> >();
	}
	return EUserProduct::staticMetaObject;
}


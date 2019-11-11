#include <QtCore>
#include "blogger.h"
#include "euserproductoption.h"

EUserProductOption::EUserProductOption(QObject *parent):QObject(parent){
	id=0;
	productID=0;
	level=0;
	price=0;
}

QMetaObject EUserProductOption::getMeta(){
	if(QMetaType::type("EUserProductOption")==0){
		qRegisterMetaType<EUserProductOption>();
		qRegisterMetaType<EUserProductOption*>();
		qRegisterMetaType<QList<EUserProductOption*> >();
		qRegisterMetaType<QList<EUserProductOption> >();
	}
	return EUserProductOption::staticMetaObject;
}


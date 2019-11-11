#include <QtCore>
#include "blogger.h"
#include "euserproductaddon.h"

EUserProductAddon::EUserProductAddon(QObject *parent):QObject(parent){
	id=0;
	productID=0;
	price=0;
}

QMetaObject EUserProductAddon::getMeta(){
	if(QMetaType::type("EUserProductAddon")==0){
		qRegisterMetaType<EUserProductAddon>();
		qRegisterMetaType<EUserProductAddon*>();
		qRegisterMetaType<QList<EUserProductAddon*> >();
		qRegisterMetaType<QList<EUserProductAddon> >();
	}
	return EUserProductAddon::staticMetaObject;
}


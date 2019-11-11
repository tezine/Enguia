#include <QtCore>
#include "blogger.h"
#include "efunplace.h"

EFunPlace::EFunPlace(QObject *parent):QObject(parent){
	id=0;
	categoryID=0;
	cityID=0;
}

QMetaObject EFunPlace::getMeta(){
	if(QMetaType::type("EFunPlace")==0){
		qRegisterMetaType<EFunPlace>();
		qRegisterMetaType<EFunPlace*>();
		qRegisterMetaType<QList<EFunPlace*> >();
		qRegisterMetaType<QList<EFunPlace> >();
	}
	return EFunPlace::staticMetaObject;
}


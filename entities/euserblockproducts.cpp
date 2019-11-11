#include <QtCore>
#include "blogger.h"
#include "euserblockproducts.h"

EUserBlockProducts::EUserBlockProducts(QObject *parent):QObject(parent){
	id=0;
	userID=0;
	visibility=0;
	deliveryTax=0;
	paymentTypes=0;
	creditCardTypes=0;
	currencyType=0;
	minimumDeliverDays=0;
	nextBlockType=0;
	nextBlockID=0;
}

QMetaObject EUserBlockProducts::getMeta(){
	if(QMetaType::type("EUserBlockProducts")==0){
		qRegisterMetaType<EUserBlockProducts>();
		qRegisterMetaType<EUserBlockProducts*>();
		qRegisterMetaType<QList<EUserBlockProducts*> >();
		qRegisterMetaType<QList<EUserBlockProducts> >();
	}
	return EUserBlockProducts::staticMetaObject;
}


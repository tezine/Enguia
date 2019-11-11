#include <QtCore>
#include "blogger.h"
#include "euserorderconfirmation.h"

EUserOrderConfirmation::EUserOrderConfirmation(QObject *parent):QObject(parent){
	userID=0;
	buyerUserID=0;
	paymentType=0;
	creditCardType=0;
	isCollectAndDeliver=0;
	collectPeriod=0;
	deliveryPeriod=0;
}

QMetaObject EUserOrderConfirmation::getMeta(){
	if(QMetaType::type("EUserOrderConfirmation")==0){
		qRegisterMetaType<EUserOrderConfirmation>();
		qRegisterMetaType<EUserOrderConfirmation*>();
		qRegisterMetaType<QList<EUserOrderConfirmation*> >();
		qRegisterMetaType<QList<EUserOrderConfirmation> >();
	}
	return EUserOrderConfirmation::staticMetaObject;
}


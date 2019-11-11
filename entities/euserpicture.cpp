#include <QtCore>
#include "blogger.h"
#include "euserpicture.h"

EUserPicture::EUserPicture(QObject *parent):QObject(parent){
	id=0;
	userID=0;
	blockID=0;
	picNumber=0;
}

QMetaObject EUserPicture::getMeta(){
	if(QMetaType::type("EUserPicture")==0){
		qRegisterMetaType<EUserPicture>();
		qRegisterMetaType<EUserPicture*>();
		qRegisterMetaType<QList<EUserPicture*> >();
		qRegisterMetaType<QList<EUserPicture> >();
	}
	return EUserPicture::staticMetaObject;
}


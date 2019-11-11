#include <QtCore>
#include "blogger.h"
#include "efunpicture.h"

EFunPicture::EFunPicture(QObject *parent):QObject(parent){
	funID=0;
	picNumber=0;
}

QMetaObject EFunPicture::getMeta(){
	if(QMetaType::type("EFunPicture")==0){
		qRegisterMetaType<EFunPicture>();
		qRegisterMetaType<EFunPicture*>();
		qRegisterMetaType<QList<EFunPicture*> >();
		qRegisterMetaType<QList<EFunPicture> >();
	}
	return EFunPicture::staticMetaObject;
}


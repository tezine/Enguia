#include <QtCore>
#include "blogger.h"
#include "eimage.h"

EImage::EImage(QObject *parent):QObject(parent){
}

QMetaObject EImage::getMeta(){
	if(QMetaType::type("EImage")==0){
		qRegisterMetaType<EImage>();
		qRegisterMetaType<EImage*>();
		qRegisterMetaType<QList<EImage*> >();
		qRegisterMetaType<QList<EImage> >();
	}
	return EImage::staticMetaObject;
}


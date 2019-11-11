#include <QtCore>
#include "blogger.h"
#include "euserblockpictures.h"

EUserBlockPictures::EUserBlockPictures(QObject *parent):QObject(parent){
	id=0;
	userID=0;
	visibility=0;
}

QMetaObject EUserBlockPictures::getMeta(){
	if(QMetaType::type("EUserBlockPictures")==0){
		qRegisterMetaType<EUserBlockPictures>();
		qRegisterMetaType<EUserBlockPictures*>();
		qRegisterMetaType<QList<EUserBlockPictures*> >();
		qRegisterMetaType<QList<EUserBlockPictures> >();
	}
	return EUserBlockPictures::staticMetaObject;
}


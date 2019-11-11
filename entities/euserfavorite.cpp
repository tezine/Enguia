#include <QtCore>
#include "blogger.h"
#include "euserfavorite.h"

EUserFavorite::EUserFavorite(QObject *parent):QObject(parent){
	id=0;
	userID=0;
	otherUserID=0;
	placeID=0;
	visibility=0;
}

QMetaObject EUserFavorite::getMeta(){
	if(QMetaType::type("EUserFavorite")==0){
		qRegisterMetaType<EUserFavorite>();
		qRegisterMetaType<EUserFavorite*>();
		qRegisterMetaType<QList<EUserFavorite*> >();
		qRegisterMetaType<QList<EUserFavorite> >();
	}
	return EUserFavorite::staticMetaObject;
}


#include <QtCore>
#include "blogger.h"
#include "efavorite.h"

EFavorite::EFavorite(QObject *parent):QObject(parent){
	id=0;
	userID=0;
	placeID=0;
}

QMetaObject EFavorite::getMeta(){
	if(QMetaType::type("EFavorite")==0){
		qRegisterMetaType<EFavorite>();
		qRegisterMetaType<EFavorite*>();
		qRegisterMetaType<QList<EFavorite*> >();
		qRegisterMetaType<QList<EFavorite> >();
	}
	return EFavorite::staticMetaObject;
}


#include <QtCore>
#include "blogger.h"
#include "euserblockwelcome.h"

EUserBlockWelcome::EUserBlockWelcome(QObject *parent):QObject(parent){
	id=0;
	userID=0;
	nextBlockType=0;
	nextBlockID=0;
	infoVisibility=0;
	currentUserVisibility=0;
	cityRegionID=0;
	capacity=0;
}

QMetaObject EUserBlockWelcome::getMeta(){
	if(QMetaType::type("EUserBlockWelcome")==0){
		qRegisterMetaType<EUserBlockWelcome>();
		qRegisterMetaType<EUserBlockWelcome*>();
		qRegisterMetaType<QList<EUserBlockWelcome*> >();
		qRegisterMetaType<QList<EUserBlockWelcome> >();
	}
	return EUserBlockWelcome::staticMetaObject;
}


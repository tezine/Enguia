#include <QtCore>
#include "blogger.h"
#include "erblockschedule.h"

ERBlockSchedule::ERBlockSchedule(QObject *parent):QObject(parent){
	id=0;
	placeID=0;
	approvalType=0;
	minimumCancelTime=0;
	nextBlockType=0;
	nextBlockID=0;
	menu1BlockType=0;
	menu2BlockType=0;
	menu3BlockType=0;
	menu4BlockType=0;
	menu1BlockID=0;
	menu2BlockID=0;
	menu3BlockID=0;
	menu4BlockID=0;
}

QMetaObject ERBlockSchedule::getMeta(){
	if(QMetaType::type("ERBlockSchedule")==0){
		qRegisterMetaType<ERBlockSchedule>();
		qRegisterMetaType<ERBlockSchedule*>();
		qRegisterMetaType<QList<ERBlockSchedule*> >();
		qRegisterMetaType<QList<ERBlockSchedule> >();
	}
	return ERBlockSchedule::staticMetaObject;
}


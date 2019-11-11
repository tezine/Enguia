#include <QtCore>
#include "blogger.h"
#include "euserblock.h"

EUserBlock::EUserBlock(QObject *parent):QObject(parent){
	id=0;
	blockType=0;
}

QMetaObject EUserBlock::getMeta(){
	if(QMetaType::type("EUserBlock")==0){
		qRegisterMetaType<EUserBlock>();
		qRegisterMetaType<EUserBlock*>();
		qRegisterMetaType<QList<EUserBlock*> >();
		qRegisterMetaType<QList<EUserBlock> >();
	}
	return EUserBlock::staticMetaObject;
}


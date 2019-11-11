#include <QtCore>
#include "blogger.h"
#include "eusermenu.h"

EUserMenu::EUserMenu(QObject *parent):QObject(parent){
	id=0;
	blockID=0;
	targetBlockType=0;
	targetBlockID=0;
	visibility=0;
	nextBlockVisibility=0;
}

QMetaObject EUserMenu::getMeta(){
	if(QMetaType::type("EUserMenu")==0){
		qRegisterMetaType<EUserMenu>();
		qRegisterMetaType<EUserMenu*>();
		qRegisterMetaType<QList<EUserMenu*> >();
		qRegisterMetaType<QList<EUserMenu> >();
	}
	return EUserMenu::staticMetaObject;
}


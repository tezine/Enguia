#include <QtCore>
#include "blogger.h"
#include "euserblockmenu.h"

EUserBlockMenu::EUserBlockMenu(QObject *parent):QObject(parent){
	id=0;
	userID=0;
}

QMetaObject EUserBlockMenu::getMeta(){
	if(QMetaType::type("EUserBlockMenu")==0){
		qRegisterMetaType<EUserBlockMenu>();
		qRegisterMetaType<EUserBlockMenu*>();
		qRegisterMetaType<QList<EUserBlockMenu*> >();
		qRegisterMetaType<QList<EUserBlockMenu> >();
	}
	return EUserBlockMenu::staticMetaObject;
}


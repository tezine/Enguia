#include <QtCore>
#include "blogger.h"
#include "efunview.h"

EFunView::EFunView(QObject *parent):QObject(parent){
	id=0;
	userID=0;
	funID=0;
}

QMetaObject EFunView::getMeta(){
	if(QMetaType::type("EFunView")==0){
		qRegisterMetaType<EFunView>();
		qRegisterMetaType<EFunView*>();
		qRegisterMetaType<QList<EFunView*> >();
		qRegisterMetaType<QList<EFunView> >();
	}
	return EFunView::staticMetaObject;
}


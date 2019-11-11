#include <QtCore>
#include "blogger.h"
#include "eadscategory.h"

EAdsCategory::EAdsCategory(QObject *parent):QObject(parent){
	id=0;
	parentID=0;
}

QMetaObject EAdsCategory::getMeta(){
	if(QMetaType::type("EAdsCategory")==0){
		qRegisterMetaType<EAdsCategory>();
		qRegisterMetaType<EAdsCategory*>();
		qRegisterMetaType<QList<EAdsCategory*> >();
		qRegisterMetaType<QList<EAdsCategory> >();
	}
	return EAdsCategory::staticMetaObject;
}


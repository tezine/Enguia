#include <QtCore>
#include "blogger.h"
#include "euserproductcategory.h"

EUserProductCategory::EUserProductCategory(QObject *parent):QObject(parent){
	id=0;
	parentID=0;
	userID=0;
}

QMetaObject EUserProductCategory::getMeta(){
	if(QMetaType::type("EUserProductCategory")==0){
		qRegisterMetaType<EUserProductCategory>();
		qRegisterMetaType<EUserProductCategory*>();
		qRegisterMetaType<QList<EUserProductCategory*> >();
		qRegisterMetaType<QList<EUserProductCategory> >();
	}
	return EUserProductCategory::staticMetaObject;
}


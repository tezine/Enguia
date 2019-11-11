#include <QtCore>
#include "blogger.h"
#include "eprofile.h"

QMetaObject EProfile::getMeta(){
	if(QMetaType::type("EProfile")==0){
		qRegisterMetaType<EProfile>();
		qRegisterMetaType<EProfile*>();
		qRegisterMetaType<QList<EProfile*> >();
		qRegisterMetaType<QList<EProfile> >();
	}
	return EProfile::staticMetaObject;
}


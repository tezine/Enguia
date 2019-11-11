#include <QtCore>
#include "blogger.h"
#include "ecity.h"

QMetaObject ECity::getMeta(){
	if(QMetaType::type("ECity")==0){
		qRegisterMetaType<ECity>();
		qRegisterMetaType<ECity*>();
		qRegisterMetaType<QList<ECity*> >();
		qRegisterMetaType<QList<ECity> >();
	}
	return ECity::staticMetaObject;
}


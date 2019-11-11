#include <QtCore>
#include "blogger.h"
#include "eneighborhood.h"

ENeighborhood::ENeighborhood(QObject *parent):QObject(parent){
	id=0;
	cityRegion=0;
}

QMetaObject ENeighborhood::getMeta(){
	if(QMetaType::type("ENeighborhood")==0){
		qRegisterMetaType<ENeighborhood>();
		qRegisterMetaType<ENeighborhood*>();
		qRegisterMetaType<QList<ENeighborhood*> >();
		qRegisterMetaType<QList<ENeighborhood> >();
	}
	return ENeighborhood::staticMetaObject;
}


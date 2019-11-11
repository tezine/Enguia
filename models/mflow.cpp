#include "mflow.h"
#include "msdefines.h"

QPointer<MFlow> MFlow::o=0;
MFlow::MFlow(QObject *parent) : QObject(parent){

}


/*
 *Clears all variables.
 *Called whenever the user opens the welcome screen
 */
void MFlow::clear(){
	placeOpenStatus=MSDefines::OpenStatusClosed;
	acceptOrderWhenClosed=false;
	sellProducts=false;
}


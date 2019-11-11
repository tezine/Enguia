#include <QtCore>
#include <QQuickItem>
#include "mquickview.h"
#include "blogger.h"

MQuickView::MQuickView(QWindow *parent) :QQuickView(parent){
}



/*
 *This is used to control the android back button on exit
 */
void MQuickView::keyPressEvent(QKeyEvent *e){
	if(e->key() != Qt::Key_Back) // pass on everything but the back key
		  QQuickView::keyPressEvent(e);
	  else{
		//qDebug()<<"clicou no back"<<rootObject()->objectName();
		qint32 methodIndex=rootObject()->metaObject()->indexOfMethod("handleBackPressed()");
		if(methodIndex==-1){BLogger::error(this,__FUNCTION__,"handleBackPressed not found");return;}
		rootObject()->metaObject()->method(methodIndex).invoke(rootObject());
	}
}



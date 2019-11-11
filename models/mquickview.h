#ifndef MQUICKVIEW_H
#define MQUICKVIEW_H
#include <QQuickView>

class MQuickView : public QQuickView{
	Q_OBJECT

public:
	MQuickView(QWindow * parent = 0);

protected:
	virtual void keyPressEvent(QKeyEvent * e);
};
#endif


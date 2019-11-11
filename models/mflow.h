#ifndef MFLOW_H
#define MFLOW_H
#include <QPointer>

/*
 *Sets/Gets all variables during the block flow
 */
class MFlow : public QObject{
	Q_OBJECT

public:
	static MFlow *obj(){if(!o)o=new MFlow();return o;}
	Q_INVOKABLE void clear();
	Q_INVOKABLE void setPlaceOpenStatus(qint32 openStatus){this->placeOpenStatus=openStatus;}
	Q_INVOKABLE qint32 getPlaceOpenStatus(){return placeOpenStatus;}
	Q_INVOKABLE void setAcceptExternalOrderWhenClosed(bool accept){acceptOrderWhenClosed=accept;}
	Q_INVOKABLE bool getAcceptExternalOrderWhenClosed(){return acceptOrderWhenClosed;}
	Q_INVOKABLE void setSellProducts(bool sellProducts){this->sellProducts=sellProducts ;}
	Q_INVOKABLE bool getSellProducts(){return sellProducts;}

private:
	explicit MFlow(QObject *parent = 0);
	static QPointer<MFlow> o;
	qint32 placeOpenStatus;
	bool acceptOrderWhenClosed;
	bool sellProducts;
};
#endif

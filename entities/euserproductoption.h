#ifndef EUSERPRODUCTOPTION_H
#define EUSERPRODUCTOPTION_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class EUserProductOption
**/
class  EUserProductOption : public QObject {
	Q_OBJECT
	Q_PROPERTY(qint64 id READ getId WRITE setId USER true)
	Q_PROPERTY(qint64 productID READ getProductID WRITE setProductID USER true)
	Q_PROPERTY(qint32 level READ getLevel WRITE setLevel USER true)
	Q_PROPERTY(QString name READ getName WRITE setName USER true)
	Q_PROPERTY(double price READ getPrice WRITE setPrice USER true)

public:
	Q_INVOKABLE EUserProductOption(QObject *parent=0);
	~EUserProductOption(){}
	static QMetaObject getMeta();
	Q_INVOKABLE EUserProductOption(const EUserProductOption &d) : QObject () { setData(d); }
	Q_INVOKABLE EUserProductOption &operator=(const EUserProductOption &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const EUserProductOption &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const EUserProductOption &other) const{ if(equal(other))return false;return true;}
	inline qint64 getId() const {return id;}
	void setId(qint64 d){id=d;}
	inline qint64 getProductID() const {return productID;}
	void setProductID(qint64 d){productID=d;}
	inline qint32 getLevel() const {return level;}
	void setLevel(qint32 d){level=d;}
	Q_INVOKABLE QString getName() const {return name;}
	void setName(const QString &d){name=d;}
	inline double getPrice() const {return price;}
	void setPrice(double d){price=d;}

protected:
	EUserProductOption &setData(const EUserProductOption &d){
		id=d.id;
		productID=d.productID;
		level=d.level;
		name=d.name;
		price=d.price;
		return *this;
	}
	bool equal(const EUserProductOption &other) const {
		if(id!=other.id)return false;
		if(productID!=other.productID)return false;
		if(level!=other.level)return false;
		if(name!=other.name)return false;
		if(price!=other.price)return false;
		return true;
	}
	qint64 id;
	qint64 productID;
	qint32 level;
	QString name;
	double price;
};

Q_DECLARE_METATYPE(EUserProductOption)
Q_DECLARE_METATYPE(EUserProductOption*)
Q_DECLARE_METATYPE(QList<EUserProductOption*>)
Q_DECLARE_METATYPE(QList<EUserProductOption>)
#endif

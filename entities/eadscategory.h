#ifndef EADSCATEGORY_H
#define EADSCATEGORY_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class EAdsCategory
**/
class  EAdsCategory : public QObject {
	Q_OBJECT
	Q_PROPERTY(qint64 id READ getId WRITE setId USER true)
	Q_PROPERTY(qint64 parentID READ getParentID WRITE setParentID USER true)
	Q_PROPERTY(QString name READ getName WRITE setName USER true)

public:
	Q_INVOKABLE EAdsCategory(QObject *parent=0);
	~EAdsCategory(){}
	static QMetaObject getMeta();
	Q_INVOKABLE EAdsCategory(const EAdsCategory &d) : QObject () { setData(d); }
	Q_INVOKABLE EAdsCategory &operator=(const EAdsCategory &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const EAdsCategory &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const EAdsCategory &other) const{ if(equal(other))return false;return true;}
	inline qint64 getId() const {return id;}
	void setId(qint64 d){id=d;}
	inline qint64 getParentID() const {return parentID;}
	void setParentID(qint64 d){parentID=d;}
	Q_INVOKABLE QString getName() const {return name;}
	void setName(const QString &d){name=d;}

protected:
	EAdsCategory &setData(const EAdsCategory &d){
		id=d.id;
		parentID=d.parentID;
		name=d.name;
		return *this;
	}
	bool equal(const EAdsCategory &other) const {
		if(id!=other.id)return false;
		if(parentID!=other.parentID)return false;
		if(name!=other.name)return false;
		return true;
	}
	qint64 id;
	qint64 parentID;
	QString name;
};

Q_DECLARE_METATYPE(EAdsCategory)
Q_DECLARE_METATYPE(EAdsCategory*)
Q_DECLARE_METATYPE(QList<EAdsCategory*>)
Q_DECLARE_METATYPE(QList<EAdsCategory>)
#endif
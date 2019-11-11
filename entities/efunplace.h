#ifndef EFUNPLACE_H
#define EFUNPLACE_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class EFunPlace
**/
class  EFunPlace : public QObject {
	Q_OBJECT
	Q_PROPERTY(qint64 id READ getId WRITE setId USER true)
	Q_PROPERTY(QString name READ getName WRITE setName USER true)
	Q_PROPERTY(QString description READ getDescription WRITE setDescription USER true)
	Q_PROPERTY(qint64 categoryID READ getCategoryID WRITE setCategoryID USER true)
	Q_PROPERTY(qint64 cityID READ getCityID WRITE setCityID USER true)
	Q_PROPERTY(QString postalCode READ getPostalCode WRITE setPostalCode USER true)
	Q_PROPERTY(QString phone1 READ getPhone1 WRITE setPhone1 USER true)

public:
	Q_INVOKABLE EFunPlace(QObject *parent=0);
	~EFunPlace(){}
	static QMetaObject getMeta();
	Q_INVOKABLE EFunPlace(const EFunPlace &d) : QObject () { setData(d); }
	Q_INVOKABLE EFunPlace &operator=(const EFunPlace &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const EFunPlace &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const EFunPlace &other) const{ if(equal(other))return false;return true;}
	inline qint64 getId() const {return id;}
	void setId(qint64 d){id=d;}
	Q_INVOKABLE QString getName() const {return name;}
	void setName(const QString &d){name=d;}
	Q_INVOKABLE QString getDescription() const {return description;}
	void setDescription(const QString &d){description=d;}
	inline qint64 getCategoryID() const {return categoryID;}
	void setCategoryID(qint64 d){categoryID=d;}
	inline qint64 getCityID() const {return cityID;}
	void setCityID(qint64 d){cityID=d;}
	Q_INVOKABLE QString getPostalCode() const {return postalCode;}
	void setPostalCode(const QString &d){postalCode=d;}
	Q_INVOKABLE QString getPhone1() const {return phone1;}
	void setPhone1(const QString &d){phone1=d;}

protected:
	EFunPlace &setData(const EFunPlace &d){
		id=d.id;
		name=d.name;
		description=d.description;
		categoryID=d.categoryID;
		cityID=d.cityID;
		postalCode=d.postalCode;
		phone1=d.phone1;
		return *this;
	}
	bool equal(const EFunPlace &other) const {
		if(id!=other.id)return false;
		if(name!=other.name)return false;
		if(description!=other.description)return false;
		if(categoryID!=other.categoryID)return false;
		if(cityID!=other.cityID)return false;
		if(postalCode!=other.postalCode)return false;
		if(phone1!=other.phone1)return false;
		return true;
	}
	qint64 id;
	QString name;
	QString description;
	qint64 categoryID;
	qint64 cityID;
	QString postalCode;
	QString phone1;
};

Q_DECLARE_METATYPE(EFunPlace)
Q_DECLARE_METATYPE(EFunPlace*)
Q_DECLARE_METATYPE(QList<EFunPlace*>)
Q_DECLARE_METATYPE(QList<EFunPlace>)
#endif

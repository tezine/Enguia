#ifndef ESEARCH_H
#define ESEARCH_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class ESearch
**/
class  ESearch : public QObject {
	Q_OBJECT
	Q_PROPERTY(qint64 id READ getId WRITE setId USER true)
	Q_PROPERTY(qint32 type READ getType WRITE setType USER true)
	Q_PROPERTY(QString name READ getName WRITE setName USER true)
	Q_PROPERTY(QString brief READ getBrief WRITE setBrief USER true)
	Q_PROPERTY(qint64 categoryID READ getCategoryID WRITE setCategoryID USER true)
	Q_PROPERTY(qint32 rating READ getRating WRITE setRating USER true)
	Q_PROPERTY(qint64 viewCount READ getViewCount WRITE setViewCount USER true)
	Q_PROPERTY(QString cityName READ getCityName WRITE setCityName USER true)

public:
	Q_INVOKABLE ESearch(QObject *parent=0);
	~ESearch(){}
	static QMetaObject getMeta();
	Q_INVOKABLE ESearch(const ESearch &d) : QObject () { setData(d); }
	Q_INVOKABLE ESearch &operator=(const ESearch &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const ESearch &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const ESearch &other) const{ if(equal(other))return false;return true;}
	inline qint64 getId() const {return id;}
	void setId(qint64 d){id=d;}
	inline qint32 getType() const {return type;}
	void setType(qint32 d){type=d;}
	Q_INVOKABLE QString getName() const {return name;}
	void setName(const QString &d){name=d;}
	Q_INVOKABLE QString getBrief() const {return brief;}
	void setBrief(const QString &d){brief=d;}
	inline qint64 getCategoryID() const {return categoryID;}
	void setCategoryID(qint64 d){categoryID=d;}
	inline qint32 getRating() const {return rating;}
	void setRating(qint32 d){rating=d;}
	inline qint64 getViewCount() const {return viewCount;}
	void setViewCount(qint64 d){viewCount=d;}
	Q_INVOKABLE QString getCityName() const {return cityName;}
	void setCityName(const QString &d){cityName=d;}

protected:
	ESearch &setData(const ESearch &d){
		id=d.id;
		type=d.type;
		name=d.name;
		brief=d.brief;
		categoryID=d.categoryID;
		rating=d.rating;
		viewCount=d.viewCount;
		cityName=d.cityName;
		return *this;
	}
	bool equal(const ESearch &other) const {
		if(id!=other.id)return false;
		if(type!=other.type)return false;
		if(name!=other.name)return false;
		if(brief!=other.brief)return false;
		if(categoryID!=other.categoryID)return false;
		if(rating!=other.rating)return false;
		if(viewCount!=other.viewCount)return false;
		if(cityName!=other.cityName)return false;
		return true;
	}
	qint64 id;
	qint32 type;
	QString name;
	QString brief;
	qint64 categoryID;
	qint32 rating;
	qint64 viewCount;
	QString cityName;
};

Q_DECLARE_METATYPE(ESearch)
Q_DECLARE_METATYPE(ESearch*)
Q_DECLARE_METATYPE(QList<ESearch*>)
Q_DECLARE_METATYPE(QList<ESearch>)
#endif

#ifndef ECITY_H
#define ECITY_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class ECity
**/
class  ECity : public QObject {
	Q_OBJECT
	Q_PROPERTY(qint64 id READ getId WRITE setId USER true)
	Q_PROPERTY(qint64 countryID READ getCountryID WRITE setCountryID USER true)
	Q_PROPERTY(qint64 stateID READ getStateID WRITE setStateID USER true)
	Q_PROPERTY(QString name READ getName WRITE setName USER true)
	Q_PROPERTY(QString asciiName READ getAsciiName WRITE setAsciiName USER true)
	Q_PROPERTY(QString stateName READ getStateName WRITE setStateName USER true)
	Q_PROPERTY(QString countryName READ getCountryName WRITE setCountryName USER true)

public:
	Q_INVOKABLE ECity(QObject *parent=0):QObject(parent){}
	~ECity(){}
	static QMetaObject getMeta();
	Q_INVOKABLE ECity(const ECity &d) : QObject () { setData(d); }
	Q_INVOKABLE ECity &operator=(const ECity &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const ECity &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const ECity &other) const{ if(equal(other))return false;return true;}
	inline qint64 getId() const {return id;}
	void setId(qint64 d){id=d;}
	inline qint64 getCountryID() const {return countryID;}
	void setCountryID(qint64 d){countryID=d;}
	inline qint64 getStateID() const {return stateID;}
	void setStateID(qint64 d){stateID=d;}
	Q_INVOKABLE QString getName() const {return name;}
	void setName(const QString &d){name=d;}
	Q_INVOKABLE QString getAsciiName() const {return asciiName;}
	void setAsciiName(const QString &d){asciiName=d;}
	Q_INVOKABLE QString getStateName() const {return stateName;}
	void setStateName(const QString &d){stateName=d;}
	Q_INVOKABLE QString getCountryName() const {return countryName;}
	void setCountryName(const QString &d){countryName=d;}

protected:
	ECity &setData(const ECity &d){
		id=d.id;
		countryID=d.countryID;
		stateID=d.stateID;
		name=d.name;
		asciiName=d.asciiName;
		stateName=d.stateName;
		countryName=d.countryName;
		return *this;
	}
	bool equal(const ECity &other) const {
		if(id!=other.id)return false;
		if(countryID!=other.countryID)return false;
		if(stateID!=other.stateID)return false;
		if(name!=other.name)return false;
		if(asciiName!=other.asciiName)return false;
		if(stateName!=other.stateName)return false;
		if(countryName!=other.countryName)return false;
		return true;
	}
	qint64 id;
	qint64 countryID;
	qint64 stateID;
	QString name;
	QString asciiName;
	QString stateName;
	QString countryName;
};

Q_DECLARE_METATYPE(ECity)
Q_DECLARE_METATYPE(ECity*)
Q_DECLARE_METATYPE(QList<ECity*>)
Q_DECLARE_METATYPE(QList<ECity>)
#endif

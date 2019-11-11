#ifndef EUSERCLIENT_H
#define EUSERCLIENT_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class EUserClient
**/
class  EUserClient : public QObject {
	Q_OBJECT
	Q_PROPERTY(qint64 id READ getId WRITE setId USER true)
	Q_PROPERTY(qint64 professionalUserID READ getProfessionalUserID WRITE setProfessionalUserID USER true)
	Q_PROPERTY(qint64 clientUserID READ getClientUserID WRITE setClientUserID USER true)
	Q_PROPERTY(bool isNew READ getIsNew WRITE setIsNew USER true)
	Q_PROPERTY(QString comment READ getComment WRITE setComment USER true)
	Q_PROPERTY(QDate clientSince READ getClientSince WRITE setClientSince USER true)
	Q_PROPERTY(QString name READ getName WRITE setName USER true)
	Q_PROPERTY(QString login READ getLogin WRITE setLogin USER true)
	Q_PROPERTY(QString countryName READ getCountryName WRITE setCountryName USER true)
	Q_PROPERTY(QString stateName READ getStateName WRITE setStateName USER true)
	Q_PROPERTY(QString cityName READ getCityName WRITE setCityName USER true)
	Q_PROPERTY(QDate bornDate READ getBornDate WRITE setBornDate USER true)
	Q_PROPERTY(QString email READ getEmail WRITE setEmail USER true)
	Q_PROPERTY(QString homePhone READ getHomePhone WRITE setHomePhone USER true)
	Q_PROPERTY(QString homeAddress READ getHomeAddress WRITE setHomeAddress USER true)
	Q_PROPERTY(QString homeAddressReference READ getHomeAddressReference WRITE setHomeAddressReference USER true)
	Q_PROPERTY(QString homePostalCode READ getHomePostalCode WRITE setHomePostalCode USER true)
	Q_PROPERTY(QString mobilePhone READ getMobilePhone WRITE setMobilePhone USER true)
	Q_PROPERTY(QDate subscription READ getSubscription WRITE setSubscription USER true)
	Q_PROPERTY(qint32 rating READ getRating WRITE setRating USER true)
	Q_PROPERTY(QString document READ getDocument WRITE setDocument USER true)
	Q_PROPERTY(qint64 cityID READ getCityID WRITE setCityID USER true)
	Q_PROPERTY(qint32 cityRegion READ getCityRegion WRITE setCityRegion USER true)

public:
	Q_INVOKABLE EUserClient(QObject *parent=0);
	~EUserClient(){}
	static QMetaObject getMeta();
	Q_INVOKABLE EUserClient(const EUserClient &d) : QObject () { setData(d); }
	Q_INVOKABLE EUserClient &operator=(const EUserClient &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const EUserClient &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const EUserClient &other) const{ if(equal(other))return false;return true;}
	inline qint64 getId() const {return id;}
	void setId(qint64 d){id=d;}
	inline qint64 getProfessionalUserID() const {return professionalUserID;}
	void setProfessionalUserID(qint64 d){professionalUserID=d;}
	inline qint64 getClientUserID() const {return clientUserID;}
	void setClientUserID(qint64 d){clientUserID=d;}
	inline bool getIsNew() const {return isNew;}
	void setIsNew(bool d){isNew=d;}
	Q_INVOKABLE QString getComment() const {return comment;}
	void setComment(const QString &d){comment=d;}
	Q_INVOKABLE QDate getClientSince() const {return clientSince;}
	void setClientSince(const QDate &d){clientSince=d;}
	Q_INVOKABLE QString getName() const {return name;}
	void setName(const QString &d){name=d;}
	Q_INVOKABLE QString getLogin() const {return login;}
	void setLogin(const QString &d){login=d;}
	Q_INVOKABLE QString getCountryName() const {return countryName;}
	void setCountryName(const QString &d){countryName=d;}
	Q_INVOKABLE QString getStateName() const {return stateName;}
	void setStateName(const QString &d){stateName=d;}
	Q_INVOKABLE QString getCityName() const {return cityName;}
	void setCityName(const QString &d){cityName=d;}
	Q_INVOKABLE QDate getBornDate() const {return bornDate;}
	void setBornDate(const QDate &d){bornDate=d;}
	Q_INVOKABLE QString getEmail() const {return email;}
	void setEmail(const QString &d){email=d;}
	Q_INVOKABLE QString getHomePhone() const {return homePhone;}
	void setHomePhone(const QString &d){homePhone=d;}
	Q_INVOKABLE QString getHomeAddress() const {return homeAddress;}
	void setHomeAddress(const QString &d){homeAddress=d;}
	Q_INVOKABLE QString getHomeAddressReference() const {return homeAddressReference;}
	void setHomeAddressReference(const QString &d){homeAddressReference=d;}
	Q_INVOKABLE QString getHomePostalCode() const {return homePostalCode;}
	void setHomePostalCode(const QString &d){homePostalCode=d;}
	Q_INVOKABLE QString getMobilePhone() const {return mobilePhone;}
	void setMobilePhone(const QString &d){mobilePhone=d;}
	Q_INVOKABLE QDate getSubscription() const {return subscription;}
	void setSubscription(const QDate &d){subscription=d;}
	inline qint32 getRating() const {return rating;}
	void setRating(qint32 d){rating=d;}
	Q_INVOKABLE QString getDocument() const {return document;}
	void setDocument(const QString &d){document=d;}
	inline qint64 getCityID() const {return cityID;}
	void setCityID(qint64 d){cityID=d;}
	inline qint32 getCityRegion() const {return cityRegion;}
	void setCityRegion(qint32 d){cityRegion=d;}

protected:
	EUserClient &setData(const EUserClient &d){
		id=d.id;
		professionalUserID=d.professionalUserID;
		clientUserID=d.clientUserID;
		isNew=d.isNew;
		comment=d.comment;
		clientSince=d.clientSince;
		name=d.name;
		login=d.login;
		countryName=d.countryName;
		stateName=d.stateName;
		cityName=d.cityName;
		bornDate=d.bornDate;
		email=d.email;
		homePhone=d.homePhone;
		homeAddress=d.homeAddress;
		homeAddressReference=d.homeAddressReference;
		homePostalCode=d.homePostalCode;
		mobilePhone=d.mobilePhone;
		subscription=d.subscription;
		rating=d.rating;
		document=d.document;
		cityID=d.cityID;
		cityRegion=d.cityRegion;
		return *this;
	}
	bool equal(const EUserClient &other) const {
		if(id!=other.id)return false;
		if(professionalUserID!=other.professionalUserID)return false;
		if(clientUserID!=other.clientUserID)return false;
		if(isNew!=other.isNew)return false;
		if(comment!=other.comment)return false;
		if(clientSince!=other.clientSince)return false;
		if(name!=other.name)return false;
		if(login!=other.login)return false;
		if(countryName!=other.countryName)return false;
		if(stateName!=other.stateName)return false;
		if(cityName!=other.cityName)return false;
		if(bornDate!=other.bornDate)return false;
		if(email!=other.email)return false;
		if(homePhone!=other.homePhone)return false;
		if(homeAddress!=other.homeAddress)return false;
		if(homeAddressReference!=other.homeAddressReference)return false;
		if(homePostalCode!=other.homePostalCode)return false;
		if(mobilePhone!=other.mobilePhone)return false;
		if(subscription!=other.subscription)return false;
		if(rating!=other.rating)return false;
		if(document!=other.document)return false;
		if(cityID!=other.cityID)return false;
		if(cityRegion!=other.cityRegion)return false;
		return true;
	}
	qint64 id;
	qint64 professionalUserID;
	qint64 clientUserID;
	bool isNew;
	QString comment;
	QDate clientSince;
	QString name;
	QString login;
	QString countryName;
	QString stateName;
	QString cityName;
	QDate bornDate;
	QString email;
	QString homePhone;
	QString homeAddress;
	QString homeAddressReference;
	QString homePostalCode;
	QString mobilePhone;
	QDate subscription;
	qint32 rating;
	QString document;
	qint64 cityID;
	qint32 cityRegion;
};

Q_DECLARE_METATYPE(EUserClient)
Q_DECLARE_METATYPE(EUserClient*)
Q_DECLARE_METATYPE(QList<EUserClient*>)
Q_DECLARE_METATYPE(QList<EUserClient>)
#endif
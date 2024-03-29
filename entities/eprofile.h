#ifndef EPROFILE_H
#define EPROFILE_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class EProfile
**/
class  EProfile : public QObject {
	Q_OBJECT
	Q_PROPERTY(qint64 id READ getId WRITE setId USER true)
	Q_PROPERTY(QString name READ getName WRITE setName USER true)
	Q_PROPERTY(QString login READ getLogin WRITE setLogin USER true)
	Q_PROPERTY(QString password READ getPassword WRITE setPassword USER true)
	Q_PROPERTY(QString email1 READ getEmail1 WRITE setEmail1 USER true)
	Q_PROPERTY(QByteArray icon READ getIcon WRITE setIcon USER true)
	Q_PROPERTY(qint32 sex READ getSex WRITE setSex USER true)
	Q_PROPERTY(qint64 currentCountryID READ getCurrentCountryID WRITE setCurrentCountryID USER true)
	Q_PROPERTY(qint64 currentStateID READ getCurrentStateID WRITE setCurrentStateID USER true)
	Q_PROPERTY(qint64 currentCityID READ getCurrentCityID WRITE setCurrentCityID USER true)
	Q_PROPERTY(qint32 currentCityRegion READ getCurrentCityRegion WRITE setCurrentCityRegion USER true)
	Q_PROPERTY(QString homeAddress READ getHomeAddress WRITE setHomeAddress USER true)
	Q_PROPERTY(QString homePhone READ getHomePhone WRITE setHomePhone USER true)
	Q_PROPERTY(QString mobilePhone READ getMobilePhone WRITE setMobilePhone USER true)
	Q_PROPERTY(QString homePostalCode READ getHomePostalCode WRITE setHomePostalCode USER true)
	Q_PROPERTY(QDate bornDate READ getBornDate WRITE setBornDate USER true)
	Q_PROPERTY(QString currentCountryName READ getCurrentCountryName WRITE setCurrentCountryName USER true)
	Q_PROPERTY(QString currentStateName READ getCurrentStateName WRITE setCurrentStateName USER true)
	Q_PROPERTY(QString currentCityName READ getCurrentCityName WRITE setCurrentCityName USER true)

public:
	Q_INVOKABLE EProfile(QObject *parent=0):QObject(parent){}
	~EProfile(){}
	static QMetaObject getMeta();
	Q_INVOKABLE EProfile(const EProfile &d) : QObject () { setData(d); }
	Q_INVOKABLE EProfile &operator=(const EProfile &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const EProfile &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const EProfile &other) const{ if(equal(other))return false;return true;}
	inline qint64 getId() const {return id;}
	void setId(qint64 d){id=d;}
	inline QString getName() const {return name;}
	void setName(const QString &d){name=d;}
	inline QString getLogin() const {return login;}
	void setLogin(const QString &d){login=d;}
	inline QString getPassword() const {return password;}
	void setPassword(const QString &d){password=d;}
	inline QString getEmail1() const {return email1;}
	void setEmail1(const QString &d){email1=d;}
	inline QByteArray getIcon() const {return icon;}
	void setIcon(const QByteArray &d){icon=d;}
	inline qint32 getSex() const {return sex;}
	void setSex(qint32 d){sex=d;}
	inline qint64 getCurrentCountryID() const {return currentCountryID;}
	void setCurrentCountryID(qint64 d){currentCountryID=d;}
	inline qint64 getCurrentStateID() const {return currentStateID;}
	void setCurrentStateID(qint64 d){currentStateID=d;}
	inline qint64 getCurrentCityID() const {return currentCityID;}
	void setCurrentCityID(qint64 d){currentCityID=d;}
	inline qint32 getCurrentCityRegion() const {return currentCityRegion;}
	void setCurrentCityRegion(qint32 d){currentCityRegion=d;}
	inline QString getHomeAddress() const {return homeAddress;}
	void setHomeAddress(const QString &d){homeAddress=d;}
	inline QString getHomePhone() const {return homePhone;}
	void setHomePhone(const QString &d){homePhone=d;}
	inline QString getMobilePhone() const {return mobilePhone;}
	void setMobilePhone(const QString &d){mobilePhone=d;}
	inline QString getHomePostalCode() const {return homePostalCode;}
	void setHomePostalCode(const QString &d){homePostalCode=d;}
	inline QDate getBornDate() const {return bornDate;}
	void setBornDate(const QDate &d){bornDate=d;}
	inline QString getCurrentCountryName() const {return currentCountryName;}
	void setCurrentCountryName(const QString &d){currentCountryName=d;}
	inline QString getCurrentStateName() const {return currentStateName;}
	void setCurrentStateName(const QString &d){currentStateName=d;}
	inline QString getCurrentCityName() const {return currentCityName;}
	void setCurrentCityName(const QString &d){currentCityName=d;}

protected:
	EProfile &setData(const EProfile &d){
		id=d.id;
		name=d.name;
		login=d.login;
		password=d.password;
		email1=d.email1;
		icon=d.icon;
		sex=d.sex;
		currentCountryID=d.currentCountryID;
		currentStateID=d.currentStateID;
		currentCityID=d.currentCityID;
		currentCityRegion=d.currentCityRegion;
		homeAddress=d.homeAddress;
		homePhone=d.homePhone;
		mobilePhone=d.mobilePhone;
		homePostalCode=d.homePostalCode;
		bornDate=d.bornDate;
		currentCountryName=d.currentCountryName;
		currentStateName=d.currentStateName;
		currentCityName=d.currentCityName;
		return *this;
	}
	bool equal(const EProfile &other) const {
		if(id!=other.id)return false;
		if(name!=other.name)return false;
		if(login!=other.login)return false;
		if(password!=other.password)return false;
		if(email1!=other.email1)return false;
		if(icon!=other.icon)return false;
		if(sex!=other.sex)return false;
		if(currentCountryID!=other.currentCountryID)return false;
		if(currentStateID!=other.currentStateID)return false;
		if(currentCityID!=other.currentCityID)return false;
		if(currentCityRegion!=other.currentCityRegion)return false;
		if(homeAddress!=other.homeAddress)return false;
		if(homePhone!=other.homePhone)return false;
		if(mobilePhone!=other.mobilePhone)return false;
		if(homePostalCode!=other.homePostalCode)return false;
		if(bornDate!=other.bornDate)return false;
		if(currentCountryName!=other.currentCountryName)return false;
		if(currentStateName!=other.currentStateName)return false;
		if(currentCityName!=other.currentCityName)return false;
		return true;
	}
	qint64 id;
	QString name;
	QString login;
	QString password;
	QString email1;
	QByteArray icon;
	qint32 sex;
	qint64 currentCountryID;
	qint64 currentStateID;
	qint64 currentCityID;
	qint32 currentCityRegion;
	QString homeAddress;
	QString homePhone;
	QString mobilePhone;
	QString homePostalCode;
	QDate bornDate;
	QString currentCountryName;
	QString currentStateName;
	QString currentCityName;
};

Q_DECLARE_METATYPE(EProfile)
Q_DECLARE_METATYPE(EProfile*)
Q_DECLARE_METATYPE(QList<EProfile*>)
Q_DECLARE_METATYPE(QList<EProfile>)
#endif

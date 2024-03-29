#ifndef EAPPCONFIG_H
#define EAPPCONFIG_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class EAppConfig
**/
class  EAppConfig : public QObject {
	Q_OBJECT
	Q_PROPERTY(qint64 id READ getId WRITE setId USER true)
	Q_PROPERTY(QString defaultAuthor READ getDefaultAuthor WRITE setDefaultAuthor USER true)
	Q_PROPERTY(qint32 agendaSorting READ getAgendaSorting WRITE setAgendaSorting USER true)
	Q_PROPERTY(qint32 agendaPeriod READ getAgendaPeriod WRITE setAgendaPeriod USER true)
	Q_PROPERTY(qint64 cityID READ getCityID WRITE setCityID USER true)
	Q_PROPERTY(QString cityName READ getCityName WRITE setCityName USER true)
	Q_PROPERTY(QString login READ getLogin WRITE setLogin USER true)
	Q_PROPERTY(QString password READ getPassword WRITE setPassword USER true)
	Q_PROPERTY(qint32 autoLogin READ getAutoLogin WRITE setAutoLogin USER true)
	Q_PROPERTY(qint32 swVersion READ getSwVersion WRITE setSwVersion USER true)
	Q_PROPERTY(qint32 agreementVersion READ getAgreementVersion WRITE setAgreementVersion USER true)
	Q_PROPERTY(qint32 isValid READ getIsValid WRITE setIsValid USER true)
	Q_PROPERTY(qint32 listCount READ getListCount WRITE setListCount USER true)
	Q_PROPERTY(qint32 lastMsgRead READ getLastMsgRead WRITE setLastMsgRead USER true)

public:
	Q_INVOKABLE EAppConfig(QObject *parent=0);
	~EAppConfig(){}
	static QMetaObject getMeta();
	Q_INVOKABLE EAppConfig(const EAppConfig &d) : QObject () { setData(d); }
	Q_INVOKABLE EAppConfig &operator=(const EAppConfig &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const EAppConfig &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const EAppConfig &other) const{ if(equal(other))return false;return true;}
	inline qint64 getId() const {return id;}
	void setId(qint64 d){id=d;}
	Q_INVOKABLE QString getDefaultAuthor() const {return defaultAuthor;}
	void setDefaultAuthor(const QString &d){defaultAuthor=d;}
	inline qint32 getAgendaSorting() const {return agendaSorting;}
	void setAgendaSorting(qint32 d){agendaSorting=d;}
	inline qint32 getAgendaPeriod() const {return agendaPeriod;}
	void setAgendaPeriod(qint32 d){agendaPeriod=d;}
	inline qint64 getCityID() const {return cityID;}
	void setCityID(qint64 d){cityID=d;}
	Q_INVOKABLE QString getCityName() const {return cityName;}
	void setCityName(const QString &d){cityName=d;}
	Q_INVOKABLE QString getLogin() const {return login;}
	void setLogin(const QString &d){login=d;}
	Q_INVOKABLE QString getPassword() const {return password;}
	void setPassword(const QString &d){password=d;}
	inline qint32 getAutoLogin() const {return autoLogin;}
	void setAutoLogin(qint32 d){autoLogin=d;}
	inline qint32 getSwVersion() const {return swVersion;}
	void setSwVersion(qint32 d){swVersion=d;}
	inline qint32 getAgreementVersion() const {return agreementVersion;}
	void setAgreementVersion(qint32 d){agreementVersion=d;}
	inline qint32 getIsValid() const {return isValid;}
	void setIsValid(qint32 d){isValid=d;}
	inline qint32 getListCount() const {return listCount;}
	void setListCount(qint32 d){listCount=d;}
	inline qint32 getLastMsgRead() const {return lastMsgRead;}
	void setLastMsgRead(qint32 d){lastMsgRead=d;}

protected:
	EAppConfig &setData(const EAppConfig &d){
		id=d.id;
		defaultAuthor=d.defaultAuthor;
		agendaSorting=d.agendaSorting;
		agendaPeriod=d.agendaPeriod;
		cityID=d.cityID;
		cityName=d.cityName;
		login=d.login;
		password=d.password;
		autoLogin=d.autoLogin;
		swVersion=d.swVersion;
		agreementVersion=d.agreementVersion;
		isValid=d.isValid;
		listCount=d.listCount;
		lastMsgRead=d.lastMsgRead;
		return *this;
	}
	bool equal(const EAppConfig &other) const {
		if(id!=other.id)return false;
		if(defaultAuthor!=other.defaultAuthor)return false;
		if(agendaSorting!=other.agendaSorting)return false;
		if(agendaPeriod!=other.agendaPeriod)return false;
		if(cityID!=other.cityID)return false;
		if(cityName!=other.cityName)return false;
		if(login!=other.login)return false;
		if(password!=other.password)return false;
		if(autoLogin!=other.autoLogin)return false;
		if(swVersion!=other.swVersion)return false;
		if(agreementVersion!=other.agreementVersion)return false;
		if(isValid!=other.isValid)return false;
		if(listCount!=other.listCount)return false;
		if(lastMsgRead!=other.lastMsgRead)return false;
		return true;
	}
	qint64 id;
	QString defaultAuthor;
	qint32 agendaSorting;
	qint32 agendaPeriod;
	qint64 cityID;
	QString cityName;
	QString login;
	QString password;
	qint32 autoLogin;
	qint32 swVersion;
	qint32 agreementVersion;
	qint32 isValid;
	qint32 listCount;
	qint32 lastMsgRead;
};

Q_DECLARE_METATYPE(EAppConfig)
Q_DECLARE_METATYPE(EAppConfig*)
Q_DECLARE_METATYPE(QList<EAppConfig*>)
Q_DECLARE_METATYPE(QList<EAppConfig>)
#endif

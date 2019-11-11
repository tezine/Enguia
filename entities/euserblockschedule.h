#ifndef EUSERBLOCKSCHEDULE_H
#define EUSERBLOCKSCHEDULE_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class EUserBlockSchedule
**/
class  EUserBlockSchedule : public QObject {
	Q_OBJECT
	Q_PROPERTY(qint64 id READ getId WRITE setId USER true)
	Q_PROPERTY(qint64 userID READ getUserID WRITE setUserID USER true)
	Q_PROPERTY(QString name READ getName WRITE setName USER true)
	Q_PROPERTY(qint32 visibility READ getVisibility WRITE setVisibility USER true)

public:
	Q_INVOKABLE EUserBlockSchedule(QObject *parent=0);
	~EUserBlockSchedule(){}
	static QMetaObject getMeta();
	Q_INVOKABLE EUserBlockSchedule(const EUserBlockSchedule &d) : QObject () { setData(d); }
	Q_INVOKABLE EUserBlockSchedule &operator=(const EUserBlockSchedule &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const EUserBlockSchedule &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const EUserBlockSchedule &other) const{ if(equal(other))return false;return true;}
	inline qint64 getId() const {return id;}
	void setId(qint64 d){id=d;}
	inline qint64 getUserID() const {return userID;}
	void setUserID(qint64 d){userID=d;}
	Q_INVOKABLE QString getName() const {return name;}
	void setName(const QString &d){name=d;}
	inline qint32 getVisibility() const {return visibility;}
	void setVisibility(qint32 d){visibility=d;}

protected:
	EUserBlockSchedule &setData(const EUserBlockSchedule &d){
		id=d.id;
		userID=d.userID;
		name=d.name;
		visibility=d.visibility;
		return *this;
	}
	bool equal(const EUserBlockSchedule &other) const {
		if(id!=other.id)return false;
		if(userID!=other.userID)return false;
		if(name!=other.name)return false;
		if(visibility!=other.visibility)return false;
		return true;
	}
	qint64 id;
	qint64 userID;
	QString name;
	qint32 visibility;
};

Q_DECLARE_METATYPE(EUserBlockSchedule)
Q_DECLARE_METATYPE(EUserBlockSchedule*)
Q_DECLARE_METATYPE(QList<EUserBlockSchedule*>)
Q_DECLARE_METATYPE(QList<EUserBlockSchedule>)
#endif
#ifndef ERBLOCKSCHEDULE_H
#define ERBLOCKSCHEDULE_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class ERBlockSchedule
**/
class  ERBlockSchedule : public QObject {
	Q_OBJECT
	Q_PROPERTY(qint64 id READ getId WRITE setId USER true)
	Q_PROPERTY(qint64 placeID READ getPlaceID WRITE setPlaceID USER true)
	Q_PROPERTY(QString name READ getName WRITE setName USER true)
	Q_PROPERTY(qint32 approvalType READ getApprovalType WRITE setApprovalType USER true)
	Q_PROPERTY(bool clientsMayCancel READ getClientsMayCancel WRITE setClientsMayCancel USER true)
	Q_PROPERTY(qint32 minimumCancelTime READ getMinimumCancelTime WRITE setMinimumCancelTime USER true)
	Q_PROPERTY(qint32 nextBlockType READ getNextBlockType WRITE setNextBlockType USER true)
	Q_PROPERTY(qint64 nextBlockID READ getNextBlockID WRITE setNextBlockID USER true)
	Q_PROPERTY(qint32 menu1BlockType READ getMenu1BlockType WRITE setMenu1BlockType USER true)
	Q_PROPERTY(qint32 menu2BlockType READ getMenu2BlockType WRITE setMenu2BlockType USER true)
	Q_PROPERTY(qint32 menu3BlockType READ getMenu3BlockType WRITE setMenu3BlockType USER true)
	Q_PROPERTY(qint32 menu4BlockType READ getMenu4BlockType WRITE setMenu4BlockType USER true)
	Q_PROPERTY(qint64 menu1BlockID READ getMenu1BlockID WRITE setMenu1BlockID USER true)
	Q_PROPERTY(qint64 menu2BlockID READ getMenu2BlockID WRITE setMenu2BlockID USER true)
	Q_PROPERTY(qint64 menu3BlockID READ getMenu3BlockID WRITE setMenu3BlockID USER true)
	Q_PROPERTY(qint64 menu4BlockID READ getMenu4BlockID WRITE setMenu4BlockID USER true)
	Q_PROPERTY(QString menu1Text READ getMenu1Text WRITE setMenu1Text USER true)
	Q_PROPERTY(QString menu2Text READ getMenu2Text WRITE setMenu2Text USER true)
	Q_PROPERTY(QString menu3Text READ getMenu3Text WRITE setMenu3Text USER true)
	Q_PROPERTY(QString menu4Text READ getMenu4Text WRITE setMenu4Text USER true)

public:
	Q_INVOKABLE ERBlockSchedule(QObject *parent=0);
	~ERBlockSchedule(){}
	static QMetaObject getMeta();
	Q_INVOKABLE ERBlockSchedule(const ERBlockSchedule &d) : QObject () { setData(d); }
	Q_INVOKABLE ERBlockSchedule &operator=(const ERBlockSchedule &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const ERBlockSchedule &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const ERBlockSchedule &other) const{ if(equal(other))return false;return true;}
	inline qint64 getId() const {return id;}
	void setId(qint64 d){id=d;}
	inline qint64 getPlaceID() const {return placeID;}
	void setPlaceID(qint64 d){placeID=d;}
	Q_INVOKABLE QString getName() const {return name;}
	void setName(const QString &d){name=d;}
	inline qint32 getApprovalType() const {return approvalType;}
	void setApprovalType(qint32 d){approvalType=d;}
	inline bool getClientsMayCancel() const {return clientsMayCancel;}
	void setClientsMayCancel(bool d){clientsMayCancel=d;}
	inline qint32 getMinimumCancelTime() const {return minimumCancelTime;}
	void setMinimumCancelTime(qint32 d){minimumCancelTime=d;}
	inline qint32 getNextBlockType() const {return nextBlockType;}
	void setNextBlockType(qint32 d){nextBlockType=d;}
	inline qint64 getNextBlockID() const {return nextBlockID;}
	void setNextBlockID(qint64 d){nextBlockID=d;}
	inline qint32 getMenu1BlockType() const {return menu1BlockType;}
	void setMenu1BlockType(qint32 d){menu1BlockType=d;}
	inline qint32 getMenu2BlockType() const {return menu2BlockType;}
	void setMenu2BlockType(qint32 d){menu2BlockType=d;}
	inline qint32 getMenu3BlockType() const {return menu3BlockType;}
	void setMenu3BlockType(qint32 d){menu3BlockType=d;}
	inline qint32 getMenu4BlockType() const {return menu4BlockType;}
	void setMenu4BlockType(qint32 d){menu4BlockType=d;}
	inline qint64 getMenu1BlockID() const {return menu1BlockID;}
	void setMenu1BlockID(qint64 d){menu1BlockID=d;}
	inline qint64 getMenu2BlockID() const {return menu2BlockID;}
	void setMenu2BlockID(qint64 d){menu2BlockID=d;}
	inline qint64 getMenu3BlockID() const {return menu3BlockID;}
	void setMenu3BlockID(qint64 d){menu3BlockID=d;}
	inline qint64 getMenu4BlockID() const {return menu4BlockID;}
	void setMenu4BlockID(qint64 d){menu4BlockID=d;}
	Q_INVOKABLE QString getMenu1Text() const {return menu1Text;}
	void setMenu1Text(const QString &d){menu1Text=d;}
	Q_INVOKABLE QString getMenu2Text() const {return menu2Text;}
	void setMenu2Text(const QString &d){menu2Text=d;}
	Q_INVOKABLE QString getMenu3Text() const {return menu3Text;}
	void setMenu3Text(const QString &d){menu3Text=d;}
	Q_INVOKABLE QString getMenu4Text() const {return menu4Text;}
	void setMenu4Text(const QString &d){menu4Text=d;}

protected:
	ERBlockSchedule &setData(const ERBlockSchedule &d){
		id=d.id;
		placeID=d.placeID;
		name=d.name;
		approvalType=d.approvalType;
		clientsMayCancel=d.clientsMayCancel;
		minimumCancelTime=d.minimumCancelTime;
		nextBlockType=d.nextBlockType;
		nextBlockID=d.nextBlockID;
		menu1BlockType=d.menu1BlockType;
		menu2BlockType=d.menu2BlockType;
		menu3BlockType=d.menu3BlockType;
		menu4BlockType=d.menu4BlockType;
		menu1BlockID=d.menu1BlockID;
		menu2BlockID=d.menu2BlockID;
		menu3BlockID=d.menu3BlockID;
		menu4BlockID=d.menu4BlockID;
		menu1Text=d.menu1Text;
		menu2Text=d.menu2Text;
		menu3Text=d.menu3Text;
		menu4Text=d.menu4Text;
		return *this;
	}
	bool equal(const ERBlockSchedule &other) const {
		if(id!=other.id)return false;
		if(placeID!=other.placeID)return false;
		if(name!=other.name)return false;
		if(approvalType!=other.approvalType)return false;
		if(clientsMayCancel!=other.clientsMayCancel)return false;
		if(minimumCancelTime!=other.minimumCancelTime)return false;
		if(nextBlockType!=other.nextBlockType)return false;
		if(nextBlockID!=other.nextBlockID)return false;
		if(menu1BlockType!=other.menu1BlockType)return false;
		if(menu2BlockType!=other.menu2BlockType)return false;
		if(menu3BlockType!=other.menu3BlockType)return false;
		if(menu4BlockType!=other.menu4BlockType)return false;
		if(menu1BlockID!=other.menu1BlockID)return false;
		if(menu2BlockID!=other.menu2BlockID)return false;
		if(menu3BlockID!=other.menu3BlockID)return false;
		if(menu4BlockID!=other.menu4BlockID)return false;
		if(menu1Text!=other.menu1Text)return false;
		if(menu2Text!=other.menu2Text)return false;
		if(menu3Text!=other.menu3Text)return false;
		if(menu4Text!=other.menu4Text)return false;
		return true;
	}
	qint64 id;
	qint64 placeID;
	QString name;
	qint32 approvalType;
	bool clientsMayCancel;
	qint32 minimumCancelTime;
	qint32 nextBlockType;
	qint64 nextBlockID;
	qint32 menu1BlockType;
	qint32 menu2BlockType;
	qint32 menu3BlockType;
	qint32 menu4BlockType;
	qint64 menu1BlockID;
	qint64 menu2BlockID;
	qint64 menu3BlockID;
	qint64 menu4BlockID;
	QString menu1Text;
	QString menu2Text;
	QString menu3Text;
	QString menu4Text;
};

Q_DECLARE_METATYPE(ERBlockSchedule)
Q_DECLARE_METATYPE(ERBlockSchedule*)
Q_DECLARE_METATYPE(QList<ERBlockSchedule*>)
Q_DECLARE_METATYPE(QList<ERBlockSchedule>)
#endif

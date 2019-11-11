#ifndef ECSMESSAGE_H
#define ECSMESSAGE_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class ECSMessage
**/
class  ECSMessage : public QObject {
	Q_OBJECT
	Q_PROPERTY(qint64 id READ getId WRITE setId USER true)
	Q_PROPERTY(qint64 fromUserID READ getFromUserID WRITE setFromUserID USER true)
	Q_PROPERTY(qint64 toUserID READ getToUserID WRITE setToUserID USER true)
	Q_PROPERTY(QString title READ getTitle WRITE setTitle USER true)
	Q_PROPERTY(QString content READ getContent WRITE setContent USER true)
	Q_PROPERTY(QDateTime dateInserted READ getDateInserted WRITE setDateInserted USER true)
	Q_PROPERTY(qint32 msgType READ getMsgType WRITE setMsgType USER true)
	Q_PROPERTY(QString fromUserName READ getFromUserName WRITE setFromUserName USER true)
	Q_PROPERTY(QByteArray toUserIcon READ getToUserIcon WRITE setToUserIcon USER true)

public:
	Q_INVOKABLE ECSMessage(QObject *parent=0);
	~ECSMessage(){}
	static QMetaObject getMeta();
	Q_INVOKABLE ECSMessage(const ECSMessage &d) : QObject () { setData(d); }
	Q_INVOKABLE ECSMessage &operator=(const ECSMessage &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const ECSMessage &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const ECSMessage &other) const{ if(equal(other))return false;return true;}
	inline qint64 getId() const {return id;}
	void setId(qint64 d){id=d;}
	inline qint64 getFromUserID() const {return fromUserID;}
	void setFromUserID(qint64 d){fromUserID=d;}
	inline qint64 getToUserID() const {return toUserID;}
	void setToUserID(qint64 d){toUserID=d;}
	Q_INVOKABLE QString getTitle() const {return title;}
	void setTitle(const QString &d){title=d;}
	Q_INVOKABLE QString getContent() const {return content;}
	void setContent(const QString &d){content=d;}
	Q_INVOKABLE QDateTime getDateInserted() const {return dateInserted;}
	void setDateInserted(const QDateTime &d){dateInserted=d;}
	inline qint32 getMsgType() const {return msgType;}
	void setMsgType(qint32 d){msgType=d;}
	Q_INVOKABLE QString getFromUserName() const {return fromUserName;}
	void setFromUserName(const QString &d){fromUserName=d;}
	Q_INVOKABLE QByteArray getToUserIcon() const {return toUserIcon;}
	void setToUserIcon(const QByteArray &d){toUserIcon=d;}

protected:
	ECSMessage &setData(const ECSMessage &d){
		id=d.id;
		fromUserID=d.fromUserID;
		toUserID=d.toUserID;
		title=d.title;
		content=d.content;
		dateInserted=d.dateInserted;
		msgType=d.msgType;
		fromUserName=d.fromUserName;
		toUserIcon=d.toUserIcon;
		return *this;
	}
	bool equal(const ECSMessage &other) const {
		if(id!=other.id)return false;
		if(fromUserID!=other.fromUserID)return false;
		if(toUserID!=other.toUserID)return false;
		if(title!=other.title)return false;
		if(content!=other.content)return false;
		if(dateInserted!=other.dateInserted)return false;
		if(msgType!=other.msgType)return false;
		if(fromUserName!=other.fromUserName)return false;
		if(toUserIcon!=other.toUserIcon)return false;
		return true;
	}
	qint64 id;
	qint64 fromUserID;
	qint64 toUserID;
	QString title;
	QString content;
	QDateTime dateInserted;
	qint32 msgType;
	QString fromUserName;
	QByteArray toUserIcon;
};

Q_DECLARE_METATYPE(ECSMessage)
Q_DECLARE_METATYPE(ECSMessage*)
Q_DECLARE_METATYPE(QList<ECSMessage*>)
Q_DECLARE_METATYPE(QList<ECSMessage>)
#endif
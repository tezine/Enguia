#ifndef ENEWSCOMMENT_H
#define ENEWSCOMMENT_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class ENewsComment
**/
class  ENewsComment : public QObject {
	Q_OBJECT
	Q_PROPERTY(qint64 id READ getId WRITE setId USER true)
	Q_PROPERTY(qint64 newsID READ getNewsID WRITE setNewsID USER true)
	Q_PROPERTY(qint64 userID READ getUserID WRITE setUserID USER true)
	Q_PROPERTY(QString comment READ getComment WRITE setComment USER true)
	Q_PROPERTY(QDateTime dateInserted READ getDateInserted WRITE setDateInserted USER true)

public:
	Q_INVOKABLE ENewsComment(QObject *parent=0);
	~ENewsComment(){}
	static QMetaObject getMeta();
	Q_INVOKABLE ENewsComment(const ENewsComment &d) : QObject () { setData(d); }
	Q_INVOKABLE ENewsComment &operator=(const ENewsComment &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const ENewsComment &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const ENewsComment &other) const{ if(equal(other))return false;return true;}
	inline qint64 getId() const {return id;}
	void setId(qint64 d){id=d;}
	inline qint64 getNewsID() const {return newsID;}
	void setNewsID(qint64 d){newsID=d;}
	inline qint64 getUserID() const {return userID;}
	void setUserID(qint64 d){userID=d;}
	Q_INVOKABLE QString getComment() const {return comment;}
	void setComment(const QString &d){comment=d;}
	Q_INVOKABLE QDateTime getDateInserted() const {return dateInserted;}
	void setDateInserted(const QDateTime &d){dateInserted=d;}

protected:
	ENewsComment &setData(const ENewsComment &d){
		id=d.id;
		newsID=d.newsID;
		userID=d.userID;
		comment=d.comment;
		dateInserted=d.dateInserted;
		return *this;
	}
	bool equal(const ENewsComment &other) const {
		if(id!=other.id)return false;
		if(newsID!=other.newsID)return false;
		if(userID!=other.userID)return false;
		if(comment!=other.comment)return false;
		if(dateInserted!=other.dateInserted)return false;
		return true;
	}
	qint64 id;
	qint64 newsID;
	qint64 userID;
	QString comment;
	QDateTime dateInserted;
};

Q_DECLARE_METATYPE(ENewsComment)
Q_DECLARE_METATYPE(ENewsComment*)
Q_DECLARE_METATYPE(QList<ENewsComment*>)
Q_DECLARE_METATYPE(QList<ENewsComment>)
#endif

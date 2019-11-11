#ifndef ETEST_H
#define ETEST_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class ETest
**/
class  ETest : public QObject {
	Q_OBJECT
	Q_PROPERTY(QTime tm READ getTm WRITE setTm USER true)

public:
	Q_INVOKABLE ETest(QObject *parent=0);
	~ETest(){}
	static QMetaObject getMeta();
	Q_INVOKABLE ETest(const ETest &d) : QObject () { setData(d); }
	Q_INVOKABLE ETest &operator=(const ETest &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const ETest &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const ETest &other) const{ if(equal(other))return false;return true;}
	Q_INVOKABLE QTime getTm() const {return tm;}
	void setTm(const QTime &d){tm=d;}

protected:
	ETest &setData(const ETest &d){
		tm=d.tm;
		return *this;
	}
	bool equal(const ETest &other) const {
		if(tm!=other.tm)return false;
		return true;
	}
	QTime tm;
};

Q_DECLARE_METATYPE(ETest)
Q_DECLARE_METATYPE(ETest*)
Q_DECLARE_METATYPE(QList<ETest*>)
Q_DECLARE_METATYPE(QList<ETest>)
#endif

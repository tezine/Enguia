#ifndef EIMAGE_H
#define EIMAGE_H
/**
*@author Tezine Technologies
*Machine generated. DO NOT EDIT THIS FILE!
**/
#include "QStringList"
#include "QDateTime"
#include "QVariant"
#include "QObject"


/**
*@class EImage
**/
class  EImage : public QObject {
	Q_OBJECT
	Q_PROPERTY(QString thumbPath READ getThumbPath WRITE setThumbPath USER true)
	Q_PROPERTY(QString bigPath READ getBigPath WRITE setBigPath USER true)
	Q_PROPERTY(QString fileName READ getFileName WRITE setFileName USER true)

public:
	Q_INVOKABLE EImage(QObject *parent=0);
	~EImage(){}
	static QMetaObject getMeta();
	Q_INVOKABLE EImage(const EImage &d) : QObject () { setData(d); }
	Q_INVOKABLE EImage &operator=(const EImage &d){ return setData(d); }
	Q_INVOKABLE bool operator== (const EImage &other) const{ if(equal(other))return true;return false;}
	Q_INVOKABLE inline bool operator!= (const EImage &other) const{ if(equal(other))return false;return true;}
	Q_INVOKABLE QString getThumbPath() const {return thumbPath;}
	void setThumbPath(const QString &d){thumbPath=d;}
	Q_INVOKABLE QString getBigPath() const {return bigPath;}
	void setBigPath(const QString &d){bigPath=d;}
	Q_INVOKABLE QString getFileName() const {return fileName;}
	void setFileName(const QString &d){fileName=d;}

protected:
	EImage &setData(const EImage &d){
		thumbPath=d.thumbPath;
		bigPath=d.bigPath;
		fileName=d.fileName;
		return *this;
	}
	bool equal(const EImage &other) const {
		if(thumbPath!=other.thumbPath)return false;
		if(bigPath!=other.bigPath)return false;
		if(fileName!=other.fileName)return false;
		return true;
	}
	QString thumbPath;
	QString bigPath;
	QString fileName;
};

Q_DECLARE_METATYPE(EImage)
Q_DECLARE_METATYPE(EImage*)
Q_DECLARE_METATYPE(QList<EImage*>)
Q_DECLARE_METATYPE(QList<EImage>)
#endif

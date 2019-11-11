#ifndef MDEFINES_H
#define MDEFINES_H
#include <QPointer>
#include <QJSValue>

#define MAXTIMEOUT 20000
#define ListCount 25

class QJsonRpcMessage;

class MMobile : public QObject{
    Q_OBJECT
	Q_ENUMS(SortType SexType MsgType SearchType HistoryType MyPortalMng)
	Q_PROPERTY(int cityID READ getCityID NOTIFY sigCityChanged USER true)
	Q_PROPERTY(QString cityName READ getCityName NOTIFY sigCityNameChanged USER true)	
	Q_PROPERTY(qint32 currentUserVisibility READ getCurrentUserVisibility WRITE setCurrentUserVisibility NOTIFY sigVisibilityChanged USER true)

public:
    enum SortType{
        SortTypeName=1,
        SortTypeDate=2,
        SortTypeRating=3
    };
    enum SexType{
        SexTypeMale=1,
        SexTypeFemale=2
    };
    enum MsgType{
        MsgTypeRegular=1,
        MsgTypeInviteUser=2
    };
    enum SearchType{
        SearchTypeName=1,
        SearchTypeAddress=2,
        SearchTypeCategory=3,
        SearchTypeDate=4,
        SearchTypeAge=5,
        SearchTypeUser=6,
        SearchTypePrice=7
    };
	enum HistoryType{
		HistoryTypeOrder=1,
		HistoryTypeSchedule=2,
		HistoryTypeUserSchedule=3
	};
	enum MyPortalMng{
		MyPortalMngAgenda=1,
		MyPortalMngOrders=2,
		MyPortalMngClients=3
	};

	explicit MMobile(QObject *parent = 0);
	static MMobile *obj(){if(!o)o=new MMobile();return o;}
	Q_INVOKABLE void setCurrentCity(qint64 userID, qint64 cityID, const QString &cityName);
	Q_INVOKABLE void setCurrentUserVisibility(qint32 visibility){this->visibility=visibility;}
	Q_INVOKABLE bool testVisibility(qint32 currentUserVisibility, qint32 allowedVisibility);
	int getCityID();
	QString getCityName();
	Q_INVOKABLE qint32 getOpenStatus(QObject *erBlockWelcome);	
	Q_INVOKABLE qint32 getUserBlockWelcomeOpenStatus(QObject *eUserBlockWelcome);
	Q_INVOKABLE QString getVisibilityName(qint32 visibility);
	Q_INVOKABLE bool istBlockVisibilityEveryone(qint32 visibility);
	Q_INVOKABLE qint32 getCurrentUserVisibility(){return visibility;}
	Q_INVOKABLE void emitPictureChanged(const QString &picturePath){emit sigPictureChanged(picturePath);}
	Q_INVOKABLE void testJson(QJSValue callBackFunction);
	Q_INVOKABLE QString getUrlFromMyPortalMngMenu(qint32 myPortalMngType);

signals:
	void sigCityNameChanged(const QString &cityName);
	void sigCityChanged(int cityID);
	void sigPictureChanged(const QString &path);
	void sigVisibilityChanged(qint32 visibility);

private:
	static QPointer<MMobile> o;
    int listCount;
	qint32 visibility;
};
#endif

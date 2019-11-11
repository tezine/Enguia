#include <QtCore>
#include <QtGui>
#include "mmobile.h"
#include "qjsonrpcmessage.h"
#include "msvc.h"
#include "blogger.h"
#include "msdefines.h"
#include "mshared.h"
#include "erblockwelcome.h"
#include "esqliteconfig.h"
#include "enguia.h"
#include "pandroid.h"
#include "base.h"
#include "etest.h"
#include "bjson.h"
#include "euserblockwelcome.h"

QPointer<MMobile> MMobile::o=0;
MMobile::MMobile(QObject *parent) :QObject(parent){

}


/*
 *Sets the current city
 */
void MMobile::setCurrentCity(qint64 userID, qint64 cityID, const QString &cityName){
	ESqliteConfig *sqliteConfig= (ESqliteConfig*)Enguia::obj()->getSqliteConfig();
	sqliteConfig->setCurrentCityID(cityID);
	sqliteConfig->setCurrentCityName(cityName);
	Enguia::obj()->saveSqliteConfig(sqliteConfig);
	emit sigCityChanged(cityID);
	emit sigCityNameChanged(cityName);
}


bool MMobile::testVisibility(qint32 currentUserVisibility, qint32 allowedVisibility){
	MSDefines::BlockVisibilitys allowedVisibilities=(MSDefines::BlockVisibilitys)allowedVisibility;
	if(allowedVisibilities.testFlag((MSDefines::BlockVisibility) currentUserVisibility))return true;
	else return false;
}


/*
 *Returns the current city. Not the users' profile city
 */
int MMobile::getCityID(){
	ESqliteConfig *sqliteConfig= (ESqliteConfig*)Enguia::obj()->getSqliteConfig();
	qint64 cityID= sqliteConfig->getCurrentCityID();
	if(cityID==0)return 5341;
	else return cityID;
}


/*
 * Returns the current city. Not the users' profile city
 */
QString MMobile::getCityName(){
	ESqliteConfig *sqliteConfig= (ESqliteConfig*)Enguia::obj()->getSqliteConfig();
	QString cityName=sqliteConfig->getCurrentCityName();
	if(cityName.trimmed().isEmpty())return "São Paulo";
	else return cityName;
}


/*
 *Returns if the place is open or closed right now
 */
qint32 MMobile::getOpenStatus(QObject *o){
	ERBlockWelcome *e=(ERBlockWelcome*)o;
	QTime currentTime=QTime::currentTime();
	switch(QDate::currentDate().dayOfWeek()){
		case Qt::Monday:
			if(currentTime>=e->getMondayStart() && currentTime<=e->getMondayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
		case Qt::Tuesday:
			if(currentTime>=e->getTuesdayStart() && currentTime<=e->getTuesdayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
		case Qt::Wednesday:
			if(currentTime>=e->getWednesdayStart() && currentTime<=e->getWednesdayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
		case Qt::Thursday:
			if(currentTime>=e->getThursdayStart() && currentTime<=e->getThursdayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
		case Qt::Friday:
			if(currentTime>=e->getFridayStart() && currentTime<=e->getFridayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
		case Qt::Saturday:
			if(currentTime>=e->getSaturdayStart() && currentTime<=e->getSaturdayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
		case Qt::Sunday:
			if(currentTime>=e->getSundayStart() && currentTime<=e->getSundayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
	}
	return MSDefines::OpenStatusClosed;
}


/*
 * Returns the UserBlockWelcome
 */
qint32 MMobile::getUserBlockWelcomeOpenStatus(QObject *o){
	EUserBlockWelcome *e=(EUserBlockWelcome*)o;
	QTime currentTime=QTime::currentTime();
	switch(QDate::currentDate().dayOfWeek()){
		case Qt::Monday:
			if(currentTime>=e->getMondayStart() && currentTime<=e->getMondayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
		case Qt::Tuesday:
			if(currentTime>=e->getTuesdayStart() && currentTime<=e->getTuesdayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
		case Qt::Wednesday:
			if(currentTime>=e->getWednesdayStart() && currentTime<=e->getWednesdayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
		case Qt::Thursday:
			if(currentTime>=e->getThursdayStart() && currentTime<=e->getThursdayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
		case Qt::Friday:
			if(currentTime>=e->getFridayStart() && currentTime<=e->getFridayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
		case Qt::Saturday:
			if(currentTime>=e->getSaturdayStart() && currentTime<=e->getSaturdayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
		case Qt::Sunday:
			if(currentTime>=e->getSundayStart() && currentTime<=e->getSundayEnd())return MSDefines::OpenStatusOpen;
			else return MSDefines::OpenStatusClosed;
			break;
	}
	return MSDefines::OpenStatusClosed;
}


/*
 *Returns the block visiblity
 */
QString MMobile::getVisibilityName(qint32 visibility){
	if(istBlockVisibilityEveryone(visibility))return Enguia::obj()->translate("Everyone");
	MSDefines::BlockVisibilitys permissions=(MSDefines::BlockVisibilitys)visibility;
	QStringList list;
	if(permissions.testFlag(MSDefines::BlockVisibilityMyself))list.append(Enguia::obj()->translate("Myself"));
	if(permissions.testFlag(MSDefines::BlockVisibilityFamily))list.append(Enguia::obj()->translate("Family"));
	if(permissions.testFlag(MSDefines::BlockVisibilityBestFriends))list.append(Enguia::obj()->translate("Best friends"));
	if(permissions.testFlag(MSDefines::BlockVisibilityFriends))list.append(Enguia::obj()->translate("Friends"));
	if(permissions.testFlag(MSDefines::BlockVisibilityFellowWorker))list.append(Enguia::obj()->translate("Fellow worker"));
	if(permissions.testFlag(MSDefines::BlockVisibilityOthers))list.append(Enguia::obj()->translate("Others"));
	return list.join(",");
}


bool MMobile::istBlockVisibilityEveryone(qint32 visibility){
	MSDefines::BlockVisibilitys permissions=(MSDefines::BlockVisibilitys)visibility;
	if(!permissions.testFlag(MSDefines::BlockVisibilityMyself))return false;
	if(!permissions.testFlag(MSDefines::BlockVisibilityFamily))return false;
	if(!permissions.testFlag(MSDefines::BlockVisibilityBestFriends))return false;
	if(!permissions.testFlag(MSDefines::BlockVisibilityFriends))return false;
	if(!permissions.testFlag(MSDefines::BlockVisibilityFellowWorker))return false;
	if(!permissions.testFlag(MSDefines::BlockVisibilityOthers))return false;
	return true;
}

void MMobile::testJson(QJSValue callBackFunction){
	ETest e;
	e.setTm(QTime::currentTime());
	QJsonDocument jDoc;
	QJsonArray jArray;
	jArray.append(QJsonValue(BJSON::convertObjectToJsonObject(e)));
	jDoc.setArray(jArray);
	QString jsonString(jDoc.toJson());
//	e.setDt(QDate::currentDate());
	MSVC::obj()->metaInvoke(MSDefines::SAbout,"TestJson",callBackFunction,jsonString, true);
}


QString MMobile::getUrlFromMyPortalMngMenu(qint32 myPortalMngType){
	switch(myPortalMngType){
		case MMobile::MyPortalMngAgenda:
			return "qrc:///UserBlockSchedule/VMUserBlockScheduleMngAgenda.qml";
		case MMobile::MyPortalMngOrders:
			return "qrc:///UserBlockProducts/VMUserBlockProductsMngOrders.qml";
		case MMobile::MyPortalMngClients:
			return "qrc:///Clients/VMClients.qml";
	}
	qDebug()<<"url not found";
	return "";
}

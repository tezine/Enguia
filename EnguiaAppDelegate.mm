#include <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "msusers.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)



@interface QIOSApplicationDelegate
@end
//! Add a category to QIOSApplicationDelegate
@interface QIOSApplicationDelegate (QFacebookApplicationDelegate)
@end
//! Now add method for handling the openURL from Facebook Login
@implementation QIOSApplicationDelegate (QFacebookApplicationDelegate)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
	NSLog(@"entrou no finish");
	if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]){
		NSLog(@"usando ios 8");
		[[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
	}
	else{
		[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
		 (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
	}
	return true;
}

- (void)application:(UIApplication*)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
	//NSString *token=(NSString*)deviceToken;
	NSString* token = [[[[[deviceToken description]
								stringByReplacingOccurrencesOfString: @"<" withString: @""]
							   stringByReplacingOccurrencesOfString: @">" withString: @""]
							  stringByReplacingOccurrencesOfString: @" " withString: @""] retain];
	//NSLog(@"My token is: %@",token);
	MSUsers::obj()->saveAppleDeviceToken(QString::fromNSString(token));
}


- (void)application:(UIApplication*)application
didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{
	NSLog(@"Failed to get token, error: %@", error);
}

#ifdef __IPHONE_8_0

- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings{
	//register to receive notifications
	NSLog(@"dentro do digRegisterUserNotificationSettings");
	[application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString   *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler{
	//handle the actions
	if ([identifier isEqualToString:@"declineAction"]){
		NSLog(@"user delined notification");
	}
	else if ([identifier isEqualToString:@"answerAction"]){
		NSLog(@"user accepts notification");
	}
}
#endif


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
	NSLog(@"Notification received: %@", userInfo);
	// This works only if the app started the GCM service
//	[[GCMService sharedInstance] appDidReceiveMessage:userInfo];
	// Handle the received message
	// ...
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
	NSLog(@"Notification received: %@", userInfo);
	if(application.applicationState == UIApplicationStateInactive) {
		NSLog(@"Inactive");
		//Show the view with the content of the push
		handler(UIBackgroundFetchResultNewData);
	} else if (application.applicationState == UIApplicationStateBackground) {
		NSLog(@"Background");
		//Refresh the local model
		handler(UIBackgroundFetchResultNewData);
	} else {
		NSLog(@"Active");
		//Show an in-app banner
		handler(UIBackgroundFetchResultNewData);
	}
	
/*	NSDictionary* params = userInfo; // based on userInfo
	[self fetchInfoWithParams:params completion:^(NSData* result, NSError* error){
		UIBackgroundFetchResult fetchResult;
		if (error) {
			fetchResult = UIBackgroundFetchResultFailed;
		}
		else if (result) {
			fetchResult = UIBackgroundFetchResultNewData;
		}
		else {
			// data is nil
			fetchResult = UIBackgroundFetchResultNoData;
		}
		
		// call the handler (if any):
		if (handler) {
			handler(fetchResult);
		}
	}];*/
}
@end

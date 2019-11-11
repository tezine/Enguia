#include <UIKit/UIKit.h>
#import "AppDelegate.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//.mm file
@interface MyObject :NSObject{
}
-(int)doSomethingWith:(void *) aParam;
@end

@implementation MyObject

AppDelegate::AppDelegate(){

}

int AppDelegate::MyCPPMethod(void *self, void * aParam){
    self = [[MyObject alloc] init];
    return [(id) self doSomethingWith:aParam];
}

-(int)doSomethingWith:(void *) aParam{
    //NSLog(@"Result: %d" , 21);
    NSLog(@"vai registrar push");
	/*outra forma
	if(IS_IOS_8_OR_LATER) {
		UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIRemoteNotificationTypeBadge
																							  |UIRemoteNotificationTypeSound
																							  |UIRemoteNotificationTypeAlert) categories:nil];
		[[UIApplication sharedApplication] registerUserNotificationSettings:settings];
	}*/
	if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]){
		NSLog(@"usando ios 8");
		[[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
	}
	else{
		[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
		 (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
	}
    return 21;
}

- (void)application:(UIApplication*)application
	didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    NSLog(@"My token is: %@", deviceToken);
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
@end


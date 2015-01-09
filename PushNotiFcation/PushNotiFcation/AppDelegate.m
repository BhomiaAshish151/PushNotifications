
//  AppDelegate.m
//  SelfieGame
//
//  Created by NOTOITSOLUTIONS on 21/11/13.
//  Copyright (c) 2013 NOTO SOLUTIONS. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
#pragma mark Properties
@property(nonatomic, retain) NSString *deviceToken, *payload, *certificate;
@end

@implementation AppDelegate

@synthesize window = _window;






//https://parse.com/docs/push_guide#top/iOS
- (id)init {
	self = [super init];
	if(self != nil) {
		self.deviceToken = @"";
		self.payload = @"{\"aps\":{\"alert\":\"This is some fancy message.\",\"badge\":1}}";
		self.certificate = [[NSBundle mainBundle] pathForResource:@"apns" ofType:@"cer"];
	}
	return self;
}




- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    
    
    
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    
    NSString *alert = [apsInfo objectForKey:@"alert"];
    
    
    
    
    
    if (application.applicationState == UIApplicationStateActive)
        
    {
        
    }
    else
    {
        if ([alert isEqualToString:@"New thread posted on timeline"])
        {
            NewsFeedClass=[[NewFeedViewController alloc]initWithNibName:@"NewFeedViewController" bundle:Nil];
            [navigations pushViewController:NewsFeedClass animated:YES];
            
        }
        
        if ([alert rangeOfString:@"reply"].location != NSNotFound) {
            
            NSString *postid = [apsInfo objectForKey:@"post_id"];
            tempDetailsClass=[[tempDetailsViewController alloc]initWithNibName:@"tempDetailsViewController" bundle:Nil];
            tempDetailsClass.NewsFeedId=postid;
            [navigations pushViewController:tempDetailsClass animated:YES];
        }
        
        if ([alert rangeOfString:@"Chat"].location != NSNotFound) {
            
            
        }
        
    }
}
-(void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *str_device = [NSString
                            stringWithFormat:@"%@",deviceToken];
    
    NSString * search = [str_device stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * devicestr = [search stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSString * devicestr1 = [devicestr stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    GlobalDevice=devicestr1;
    
    GlobalDevice = [[NSString alloc] initWithFormat: devicestr1, 7];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    self.window.backgroundColor=[UIColor blackColor];
    //    NSUUID *UUID = [[ASIdentifierManager sharedManager] advertisingIdentifier];
   
    
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication]
     registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeAlert |
      UIRemoteNotificationTypeBadge |
      UIRemoteNotificationTypeSound)];
    NSDictionary* userInfo = [launchOptions valueForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    NSString *params=[[launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"] objectForKey:@"aps"];
    
    
//    if ([params length] > 0 ) {//app launch when VIEW button of push notification clicked
//        
//        //do some processing
//        //
//        //        masterViewController *masterViewClass =
//        //        [[masterViewController alloc] initWithNibName:@"masterViewController" bundle:[NSBundle    mainBundle]];
//        //        // Put your custom code
//        //
//        //
//        //        [[self navigationController ] pushViewController:masterViewClass animated:YES];
//        //        [_window addSubview:masterViewClass.view];
//        //        [masterViewClass release];
//    }
//    
//    NSString *alertMsg = @"";
//    NSString *badge = @"";
//    NSString *sound = @"";
//    
//    if( [apsInfo objectForKey:@"alert"] != NULL)
//    {
//        alertMsg = [apsInfo objectForKey:@"alert"];
//    }
//    
//    
//    if( [apsInfo objectForKey:@"badge"] != NULL)
//    {
//        badge = [apsInfo objectForKey:@"badge"];
//    }
//    
//    
//    if( [apsInfo objectForKey:@"sound"] != NULL)
//    {
//        sound = [apsInfo objectForKey:@"sound"];
//    }
//    
//    if (    ! [alertMsg isEqualToString:@""] ||
//        ! [badge isEqualToString:@""]  ||
//        ! [sound isEqualToString:@""]
//        )
//    {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
//                                                        message:alertMsg
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//        
//    }
//    
    return YES;
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
//-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSLog(@"APN device token: %@", deviceToken);
//    //NSString *deviceTokenString = [NSString stringWithFormat:@"%@",deviceToken];
//}
//-(void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//     NSLog(@"deviceToken%@",deviceToken);
//    NSString *str_device = [NSString
//                            stringWithFormat:@"%@",deviceToken];
//    NSString *search = [str_device stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSString * devicestr = [search stringByReplacingOccurrencesOfString:@"<" withString:@""];
//    NSString * devicestr1 = [devicestr stringByReplacingOccurrencesOfString:@">" withString:@""];
//    //    NSString *trimmedDeviceToken = [str_device stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    // int intLoginId = [devicestr1 intValue];
//    NSLog(@"devicestr1%@",devicestr1);
//    //     int LoginId = [devicestr1 intValue];
//    GlobalDevice=devicestr1;
//    NSLog(@"GlobalDevice%@",GlobalDevice);
//    GlobalDevice = [[NSString alloc] initWithFormat: devicestr1, 7];
//
//}


// Show an alert message

@end

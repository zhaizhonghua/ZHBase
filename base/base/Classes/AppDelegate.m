//
//  AppDelegate.m
//  base
//
//  Created by 翟中华 on 16/11/3.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHThemeManger.h"
#import "IQKeyboardManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "ZHTabBarController.h"
#import "ZHGuideViewController.h"
#import "AppDelegate+LaunchAd.h"
#import "XHLaunchAd.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初始化主题
    [ZHThemeManger configTheme];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:GUIDE_KEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:GUIDE_KEY];
        UINavigationController *guideNav = [[UINavigationController alloc] initWithRootViewController:[ZHGuideViewController alloc]];
        self.window.rootViewController = guideNav;
    }else{
        [self startLaunchAd];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)pushMainRootController
{
    ZHTabBarController *tabBarC = [[ZHTabBarController alloc] init];
    UINavigationController *tabBarNav = [[UINavigationController alloc] initWithRootViewController:tabBarC];
    tabBarNav.navigationBarHidden = YES;
    [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
        self.window.rootViewController = tabBarNav;
    }completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

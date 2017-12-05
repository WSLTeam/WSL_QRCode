//
//  AppDelegate.m
//  SL_QRCode
//
//  Created by 王胜龙 on 2017/8/24.
//  Copyright © 2017年 王胜龙. All rights reserved.
//

#import "AppDelegate.h"
#import "QRCodeCreateViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self customizeInterface];
    
    QRCodeCreateViewController *rootController = [[QRCodeCreateViewController alloc] init];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:rootController];
    
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)customizeInterface {
    //设置Nav的背景色和title色
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
//    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setShadowImage:[UIImage new]];
//    [navigationBarAppearance setTintColor:[UIColor whiteColor]];//返回按钮的箭头颜色
    [navigationBarAppearance setTranslucent:false];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont systemFontOfSize:18],
                                     NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];//标题属性
    
//    [[UITextField appearance] setTintColor:navigationBarColor];//设置UITextField的光标颜色
//    [[UITextView appearance] setTintColor:navigationBarColor];//设置UITextView的光标颜色
    
    //设置搜索框背景色，文字颜色
//    [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:navigationBarColor] forBarPosition:0 barMetrics:UIBarMetricsDefault];
//    [[UISearchBar appearance] setTintColor:[UIColor whiteColor]];
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

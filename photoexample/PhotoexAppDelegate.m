//
//  PhotoexAppDelegate.m
//  photoexample
//
//  Created by 龍野翔 on 2014/03/08.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import "PhotoexAppDelegate.h"
#import "PhotoexViewController.h"

@interface PhotoexAppDelegate()

@property (nonatomic, strong) UINavigationController *naviCtrl;

@end

@implementation PhotoexAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //self.viewController = [[PhotoexViewController alloc] init];
    //self.window.rootViewController = self.viewController;
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    PhotoexViewController *c = PhotoexViewController.new;
    self.naviCtrl = [[UINavigationController alloc] initWithRootViewController:c];
    self.window.rootViewController = self.naviCtrl;
    self.naviCtrl.navigationBar.translucent = NO;
    self.naviCtrl.toolbar.translucent = NO;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}
							
@end

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
    self.models = [NSUserDefaults standardUserDefaults];
    [self.models setObject:@"-1" forKey:@"MAX_PHOTO_NUMBER"];
    
    self.camera = CameraViewController.new;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    
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

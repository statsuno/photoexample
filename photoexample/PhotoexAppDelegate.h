//
//  PhotoexAppDelegate.h
//  photoexample
//
//  Created by 龍野翔 on 2014/03/08.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoexViewController.h"
#import "CameraViewController.h"

@interface PhotoexAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PhotoexViewController *viewController;
@property (strong, nonatomic) NSUserDefaults *models;
@property (strong, nonatomic) CameraViewController *camera;

@end

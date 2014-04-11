//
//  FirstViewController.h
//  photoexample
//
//  Created by 龍野翔 on 2014/03/08.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"

@protocol FilterDelegate <NSObject>

@end


@interface CameraViewController : UIViewController
{
    GPUImageStillCamera *stillCamera;
    GPUImageOutput<GPUImageInput> *filter, *secondFilter, *terminalFilter;
    //UISlider *filterSettingsSlider;
    UIButton *photoCaptureButton;
}

@property (nonatomic, assign) id<FilterDelegate> delegate;
// デリゲートメソッド
- (void)filterch:(NSInteger)val;

- (IBAction)updateSliderValue:(id)sender;
- (IBAction)takePhoto:(id)sender;
@end



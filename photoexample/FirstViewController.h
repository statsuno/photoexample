//
//  FirstViewController.h
//  photoexample
//
//  Created by 龍野翔 on 2014/03/08.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"

@interface FirstViewController : UIViewController
{
    GPUImageStillCamera *stillCamera;
    GPUImageOutput<GPUImageInput> *filter, *secondFilter, *terminalFilter;
    //UISlider *filterSettingsSlider;
    UIButton *photoCaptureButton;
}

- (IBAction)updateSliderValue:(id)sender;
- (IBAction)takePhoto:(id)sender;
@end



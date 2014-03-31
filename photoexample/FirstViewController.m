//
//  FirstViewController.m
//  photoexample
//
//  Created by 龍野翔 on 2014/03/08.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import "FirstViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoexAppDelegate.h"
#import "Subview.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
	CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
    
    // Yes, I know I'm a caveman for doing all this by hand
	GPUImageView *primaryView = [[GPUImageView alloc] initWithFrame:mainScreenFrame];
	primaryView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    /*
    filterSettingsSlider = [[UISlider alloc] initWithFrame:CGRectMake(25.0, mainScreenFrame.size.height - 50.0, mainScreenFrame.size.width - 50.0, 40.0)];
    [filterSettingsSlider addTarget:self action:@selector(updateSliderValue:) forControlEvents:UIControlEventValueChanged];
	filterSettingsSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    filterSettingsSlider.minimumValue = 0.0;
    filterSettingsSlider.maximumValue = 3.0;
    filterSettingsSlider.value = 1.0;
     */
    
    //[primaryView addSubview:filterSettingsSlider];
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePhoto:)];
    UIBarButtonItem *spacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *filterbutton =[[UIBarButtonItem alloc] initWithTitle:@"F"  style:UIBarButtonItemStyleBordered target:self action:@selector(pushfilterview)
                                    ];
    NSArray *buttons=[NSArray arrayWithObjects:spacer,button,spacer,filterbutton,nil];
    //NSArray *buttons=[NSArray arrayWithObjects:spacer,button,spacer,nil];
    [self setToolbarItems:buttons animated:YES];
    
    /*
    photoCaptureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    photoCaptureButton.frame = CGRectMake(round(mainScreenFrame.size.width / 2.0 - 150.0 / 2.0), mainScreenFrame.size.height - 90.0, 150.0, 40.0);
    [photoCaptureButton setTitle:@"Capture Photo" forState:UIControlStateNormal];
	photoCaptureButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [photoCaptureButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [photoCaptureButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
     */
    
    //[primaryView addSubview:photoCaptureButton];
    
	self.view = primaryView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    stillCamera = [[GPUImageStillCamera alloc] init];
    //    stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    //    filter = [[GPUImageGammaFilter alloc] init];
    filter = [[GPUImageSketchFilter alloc] init];
    //    filter = [[GPUImageUnsharpMaskFilter alloc] init];
    //    [(GPUImageSketchFilter *)filter setTexelHeight:(1.0 / 1024.0)];
    //    [(GPUImageSketchFilter *)filter setTexelWidth:(1.0 / 768.0)];
    //    filter = [[GPUImageSmoothToonFilter alloc] init];
    //    filter = [[GPUImageSepiaFilter alloc] init];
    //    filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.5, 0.5, 0.5, 0.5)];
    //    secondFilter = [[GPUImageSepiaFilter alloc] init];
    //    terminalFilter = [[GPUImageSepiaFilter alloc] init];
    //    [filter addTarget:secondFilter];
    //    [secondFilter addTarget:terminalFilter];
    
    //	[filter prepareForImageCapture];
    //	[terminalFilter prepareForImageCapture];
    
    [stillCamera addTarget:filter];
    GPUImageView *filterView = (GPUImageView *)self.view;
    [filter addTarget:filterView];
    //    [terminalFilter addTarget:filterView];
    
    //    [stillCamera.inputCamera lockForConfiguration:nil];
    //    [stillCamera.inputCamera setFlashMode:AVCaptureFlashModeOn];
    //    [stillCamera.inputCamera unlockForConfiguration];
    
    
    
    [stillCamera startCameraCapture];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)updateSliderValue:(id)sender
{
    //    [(GPUImagePixellateFilter *)filter setFractionalWidthOfAPixel:[(UISlider *)sender value]];
    //    [(GPUImageGammaFilter *)filter setGamma:[(UISlider *)sender value]];
}

- (IBAction)takePhoto:(id)sender;
{
    [photoCaptureButton setEnabled:NO];
    
    //    [stillCamera capturePhotoAsJPEGProcessedUpToFilter:terminalFilter withCompletionHandler:^(NSData *processedJPEG, NSError *error){
    [stillCamera capturePhotoAsJPEGProcessedUpToFilter:filter withCompletionHandler:^(NSData *processedJPEG, NSError *error){
        
        //NSData *data = UIImagePNGRepresentation(image);
        int i= [[app models] integerForKey:@"KEY_I"];
        [[app models] setInteger:i+1 forKey:@"KEY_I"];
        NSLog(@"i=%d",i);
        NSString *filePath = [NSString stringWithFormat:@"%@/test%d.jpg" , [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],i];
        //NSLog(@"%@", filePath);
        if ([processedJPEG writeToFile:filePath atomically:YES]) {
            //NSLog(@"OK");
        } else {
            NSLog(@"Error");
        }

    }];
}

-(void)pushfilterview
{
    /*
     if ([SubView isDescendantOfView:self])
     {
     for (UIView *view in [self.view subviews]) {
     [view removeFromSuperview];
     }
     
     }
     else{ */
     Subview *uv = Subview.new;
     [self.view addSubview:uv];
     //}

}


@end
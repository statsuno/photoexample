//
//  FirstViewController.m
//  photoexample
//
//  Created by 龍野翔 on 2014/03/08.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import "CameraViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoexAppDelegate.h"
#import "FilterchoiceView.h"

@interface CameraViewController ()
@property (nonatomic, strong) FilterchoiceView *filterchoiceView;
@property BOOL isFilterViewOpen;
@property GPUImageView *filterView;

@end

@implementation CameraViewController

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
    
    //ツールバーやボタンのセット
    UIBarButtonItem *capturebutton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePhoto:)];
    UIBarButtonItem *spacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *filterbutton =[[UIBarButtonItem alloc] initWithTitle:@"F"  style:UIBarButtonItemStyleBordered target:self action:@selector(pushfilterview)];
    UIBarButtonItem *returnbutton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    NSArray *buttons=[NSArray arrayWithObjects:returnbutton,spacer,capturebutton,spacer,filterbutton,nil];
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
    self.filterView = (GPUImageView *)self.view;
    [filter addTarget:self.filterView];
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
    //[(GPUImagePixellateFilter *)filter setFractionalWidthOfAPixel:[(UISlider *)sender value]];
    //[(GPUImageGammaFilter *)filter setGamma:[(UISlider *)sender value]];
}

// 当画面表示時
- (void)viewWillAppear:(BOOL)animated
{
    // NavigationBar 非表示
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

// 当画面から別画面遷移時
- (void)viewWillDisappear:(BOOL)animated
{
    // NavigationBar 表示
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//写真を撮ってDocumentsフォルダに保存
- (IBAction)takePhoto:(id)sender;
{
    [photoCaptureButton setEnabled:NO];
    
    [stillCamera capturePhotoAsJPEGProcessedUpToFilter:filter withCompletionHandler:^(NSData *processedJPEG, NSError *error){
        int i= (int)[[app models] integerForKey:@"MAX_PHOTO_NUMBER"]+1;
        [[app models] setInteger:i forKey:@"MAX_PHOTO_NUMBER"];
        NSString *filePath = [NSString stringWithFormat:@"%@/test%d.jpg" , [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],i];
        if ([processedJPEG writeToFile:filePath atomically:YES]) {
            NSLog(@"OK");
        } else {
            NSLog(@"Error");
        }

    }];
}

//filter選択ビューを開く
-(void)pushfilterview{
    if(!self.filterchoiceView){
        self.filterchoiceView = FilterchoiceView.new;
    }
    if(self.isFilterViewOpen){
        [self.filterchoiceView removeFromSuperview];
        self.isFilterViewOpen = NO;
    }else{
        [self.view addSubview:self.filterchoiceView];
        self.isFilterViewOpen = YES;
    }
}

//filter選択ビューの値をもらってフィルタを切り替える
-(void)filterch:(NSInteger)val
{
    if (val==1) {
        [filter removeTarget:self.filterView];
        [stillCamera removeTarget:filter];
        filter = [[GPUImageToonFilter alloc] init];
        [stillCamera addTarget:filter];
        [filter addTarget:self.filterView];
        
    }else if(val==2){
        [filter removeTarget:self.filterView];
        [stillCamera removeTarget:filter];
        filter = [[GPUImageSepiaFilter alloc] init];
        [stillCamera addTarget:filter];
        [filter addTarget:self.filterView];
        
    }else if(val==3){
        [filter removeTarget:self.filterView];
        [stillCamera removeTarget:filter];
        filter = [[GPUImageSketchFilter alloc] init];
        [stillCamera addTarget:filter];
        [filter addTarget:self.filterView];
    }
}

-(void)refresh
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.view removeFromSuperview];
}


@end
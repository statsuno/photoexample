//
//  SubView.m
//  subview
//
//  Created by 龍野翔 on 2014/03/29.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import "FilterchoiceView.h"

@interface FilterchoiceView ()

@end

@implementation FilterchoiceView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:CGRectMake(0,300,350,50)];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        UIButton *filter1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        filter1.frame = CGRectMake(20,0,50,50);
        [filter1 setTitle:@"filter1" forState:UIControlStateNormal];
        [filter1 addTarget:self action:@selector(pushed_button:) forControlEvents:UIControlEventTouchUpInside];
        filter1.tag=1;
        [self addSubview:filter1];
        
        UIButton *filter2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        filter2.frame = CGRectMake(140,0,50,50);
        [filter2 setTitle:@"filter2" forState:UIControlStateNormal];
        [filter2 addTarget:self action:@selector(pushed_button:) forControlEvents:UIControlEventTouchUpInside];
        filter2.tag=2;
        [self addSubview:filter2];
        
        UIButton *filter3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        filter3.frame = CGRectMake(260,0,50,50);
        [filter3 setTitle:@"filter3" forState:UIControlStateNormal];
        [filter3 addTarget:self action:@selector(pushed_button:) forControlEvents:UIControlEventTouchUpInside];
        filter3.tag=3;
        [self addSubview:filter3];
        
    }
    return self;
}

-(void)pushed_button:(id)sender
{
    CameraViewController *filterchoice = [[CameraViewController alloc]init];
    filterchoice.delegate = self;
    if ([sender tag] == 1) {
        [filterchoice filterch:1];
    } else if ([sender tag] == 2) {
        [filterchoice filterch:2];
    } else if ([sender tag] == 3) {
        [filterchoice filterch:3];
    }
}

@end
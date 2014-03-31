//
//  SubView.m
//  subview
//
//  Created by 龍野翔 on 2014/03/29.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import "SubView.h"

@implementation Subview

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:CGRectMake(0,300,350,50)];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        for(int i = 1;i<4;i++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            //[btn setBackgroundImage:[UIImage imageNamed:[gazou objectAtIndex:i]] forState:UIControlStateNormal];
            btn.frame=CGRectMake((i*110-100),0,50,50);
            [btn setTitle:@"filter" forState:UIControlStateNormal];
            [btn sizeToFit];
            [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            [self addSubview:btn];
        }
        
        /*
         // Initialization code
         UIButton *filter1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         [filter1 setTitle:@"filter1" forState:UIControlStateNormal];
         [filter1 sizeToFit];
         [filter1 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
         filter1.frame = CGRectMake(20,0,50,50);
         [self addSubview:filter1];
         
         UIButton *filter2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         [filter2 setTitle:@"filter2" forState:UIControlStateNormal];
         [filter2 sizeToFit];
         [filter2 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
         filter2.frame = CGRectMake(140,0,50,50);
         [self addSubview:filter2];
         
         UIButton *filter3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         [filter3 setTitle:@"filter3" forState:UIControlStateNormal];
         [filter3 sizeToFit];
         [filter3 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
         filter3.frame = CGRectMake(250,0,50,50);
         [self addSubview:filter3];
         */
    }
    return self;
}

-(void)action:(UIButton*)btn
{
    NSLog(@"%d",btn.tag);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
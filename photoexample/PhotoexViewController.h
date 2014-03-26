//
//  PhotoexViewController.h
//  photoexample
//
//  Created by 龍野翔 on 2014/03/08.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoexViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
{
    UICollectionViewFlowLayout *_flowLayout;
    UICollectionView *_collectionView;
}

@property (retain, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (retain, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *array;

@end

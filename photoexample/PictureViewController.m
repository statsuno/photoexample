//
//  SecondViewController.m
//  photoexample
//
//  Created by 龍野翔 on 2014/03/08.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import "PictureViewController.h"

@interface PictureViewController ()
@property long n;
@property NSString *path;
@property NSFileManager *fileManager;
@property NSString *documentsDirectory;
@end

@implementation PictureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    
    //ボタンのセット
    UIBarButtonItem *right = [[UIBarButtonItem alloc]
                              initWithTitle:@"delete"
                              style:UIBarButtonItemStylePlain
                              target:self action:@selector(delete)];
    self.navigationItem.rightBarButtonItem = right;
    
    //選ばれた写真の番号を受け取る
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.n = [ud integerForKey:@"SELECTED_PHOTO_NUMBER"];
    
    //パスを作成
    NSData *myData;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.documentsDirectory = [paths objectAtIndex:0];
    NSString *filename= [NSString stringWithFormat:@"test%ld.jpg",self.n];
    self.path = [self.documentsDirectory stringByAppendingPathComponent:filename];
    self.fileManager = [NSFileManager defaultManager];
    BOOL success = [self.fileManager fileExistsAtPath:self.path];
    if(success) {
        myData = [[NSData alloc] initWithContentsOfFile:self.path];
    }
    
    //枠を作って追加
    CGRect rect = CGRectMake(10, 10, 300, 350);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    
    // 画像の読み込み
    imageView.image = [[UIImage alloc] initWithData:myData];
    imageView.tag=100;
    
    // UIImageViewのインスタンスをビューに追加
    [self.view addSubview:imageView];
    
}


-(void)viewDidDisappear:(BOOL)animated
{
    [self.view removeFromSuperview];
}

//削除用アクションシート
-(void)delete
{
    [self.navigationController setToolbarHidden:YES animated:NO];
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:@"削除" otherButtonTitles:nil, nil];
    [sheet showInView:self.view.window];
    self.navigationController.toolbarHidden = NO;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        //削除選択時
        case 0:
        {
            NSLog(@"Red");
            NSError *error;
            // 写真の削除
            BOOL result = [self.fileManager removeItemAtPath:self.path error:&error];
            if (result) {
                NSLog(@"ファイルを削除に成功：%@", self.path);
            } else {
                NSLog(@"ファイルの削除に失敗：%@", error.description);
            }
            
            //トータル枚数
            long k= [[app models] integerForKey:@"MAX_PHOTO_NUMBER"];
            
            if (k>=0){
                //トータル枚数-1
                [[app models] setInteger:k-1 forKey:@"MAX_PHOTO_NUMBER"];
            
                //リネームして写真番号を再度つけ直す
                for(int i=(int)self.n;i<k;i++){
                    NSString *beforename= [NSString stringWithFormat:@"test%d.jpg",i+1];
                    NSString *aftername= [NSString stringWithFormat:@"test%d.jpg",i];
                    NSString *beforepath = [self.documentsDirectory stringByAppendingPathComponent:beforename];
                    NSString *afterpath = [self.documentsDirectory stringByAppendingPathComponent:aftername];
                    NSLog(@"%@ to %@", beforepath,afterpath);
                    BOOL result = [self.fileManager moveItemAtPath:beforepath toPath:afterpath error:&error];
                    if (result) {
                        NSLog(@"ファイルを移動に成功：%@ to %@", beforepath,afterpath);
                    } else {
                        NSLog(@"ファイルの移動に失敗：%@ ", error.description);
                    }
                }
            }
            
            //前の画面に戻る
            [self.navigationController popViewControllerAnimated:YES];
            [self.view removeFromSuperview];
            
            break;
        }
            
        //キャンセル時
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

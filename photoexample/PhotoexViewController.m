#import "PhotoexAppDelegate.h"
#import "CameraViewController.h"
#import "PictureViewController.h"
#import "PhotoexViewController.h"

@interface PhotoexViewController ()

@end

@implementation PhotoexViewController

- (id)init{
    if (self = [super init]) {
        self.title = @"カメラ";
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    /*UIBarButtonItem *right = [[UIBarButtonItem alloc]
                              initWithTitle:@"next"
                              style:UIBarButtonItemStylePlain
                              target:self action:@selector(actionNext)];
    self.navigationItem.rightBarButtonItem = right;
     */
    
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(beginCamera)];
    UIBarButtonItem *spacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *buttons=[NSArray arrayWithObjects:spacer,button,spacer,nil];
    [self setToolbarItems:buttons animated:YES];
    
    // collectionViewにcellのクラスを登録
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
}

/*
- (void)actionNext{
    SecondViewController *c = SecondViewController.new;
    [self.navigationController pushViewController:c animated:YES];
}
*/

-(void)beginCamera{
    [self.navigationController pushViewController:[app camera] animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self createCollectionView];
    self.navigationController.toolbarHidden = NO;
    [self.navigationController setToolbarHidden:NO animated:YES];
}


-(void)createCollectionView
{
    NSMutableArray *photo1 = [NSMutableArray array];
    int n = [[app models] integerForKey:@"MAX_PHOTO_NUMBER"];
    NSLog(@"n=%d",n);
    
    if (n<0) {
        self.array = 0;
    }
    else{
        for (int i = 0; i < n+1; i++) {
            NSData *myData;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *filename= [NSString stringWithFormat:@"test%d.jpg",i];
            NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            BOOL success = [fileManager fileExistsAtPath:path];
            if(success) {
                myData = [[NSData alloc] initWithContentsOfFile:path];
            }
            UIImage *img = [[UIImage alloc] initWithData:myData];
            [photo1 addObject:img];
        }
        self.array = @[photo1];
    }
    
    /*UICollectionViewのコンテンツの設定 UICollectionViewFlowLayout*/
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.itemSize = CGSizeMake(96, 72);  //表示するアイテムのサイズ
    self.flowLayout.minimumLineSpacing = 10.0f;  //セクションとアイテムの間隔
    self.flowLayout.minimumInteritemSpacing = 12.0f;  //アイテム同士の間隔
    
    /*UICollectionViewの土台を作成*/
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];  //collectionViewにcellのクラスを登録。セルの表示に使う
    
    [self.view addSubview:self.collectionView];
}

#pragma mark -
#pragma mark UICollectionViewDelegate

/*セクションの数*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.array count];
}

/*セクションに応じたセルの数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.array objectAtIndex:section] count];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

/*セルの内容を返す*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.item]];
    imgView.frame = CGRectMake(0.0, 0.0, 96.0, 72.0);
    
    // cellにimgViewをセット
    [cell addSubview:imgView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //クリックされたらよばれる
    PictureViewController *c = PictureViewController.new;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //0から始めてクリックしたアイテムの順番をSELECTED_ITEM_NUMBERに格納
    [ud setInteger:(int)indexPath.row forKey:@"SELECTED_PHOTO_NUMBER"];
    [self.navigationController pushViewController:c animated:YES];
    NSLog(@"Clicked %ld-%ld",(long)indexPath.section,(long)indexPath.row);
}



@end
//
//  XZPhotoAlbumViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZPhotoAlbumViewController.h"
#import "XZPhotoAblumCell.h"
#import "XZImageBrowserViewController.h"

@interface XZPhotoAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    __weak IBOutlet UICollectionView *_collectionView;
    
    NSArray *_imageNameArray;
}

@end

@implementation XZPhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageNameArray = @[@"1",@"2",@"3",@"4",@"5"];
    
    [self setUpCollectionView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    layout.itemSize = CGSizeMake(UISCREEN_WIDTH/4, UISCREEN_WIDTH/4);
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.collectionViewLayout = layout;
    [_collectionView registerNib:[UINib nibWithNibName:@"XZPhotoAblumCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"photoAblumCell"];
}

#pragma mark - UICollectionView_DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imageNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZPhotoAblumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoAblumCell" forIndexPath:indexPath];
    
    [cell setUpCellWithImageName:_imageNameArray[indexPath.row]];

    return cell;
}
#pragma mark - UICollectionView_Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZImageBrowserViewController *imageBrowserVc = [[XZImageBrowserViewController alloc] initWithNibName:@"XZImageBrowserViewController" bundle:[NSBundle mainBundle]];
    
    imageBrowserVc.imageNameArray = _imageNameArray;
    imageBrowserVc.indexPath = indexPath;
    
    [self presentViewController:imageBrowserVc animated:YES completion:nil];
}

@end

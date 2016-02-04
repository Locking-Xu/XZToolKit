//
//  XZPhotoAlbumViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZPhotoAlbumViewController.h"
#import "XZPhotoCell.h"
#import "XZImageBrowserViewController.h"
#import <Photos/Photos.h>
#import "XZAlbumHelper.h"
#import "XZUtils.h"

@interface XZPhotoAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    __weak IBOutlet UICollectionView *_collectionView;
    
    NSMutableArray *_dataArray;

}

@end

@implementation XZPhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[XZAlbumHelper shareInstance] getAlbumAssetWithGroupUrl:self.groupUrl identifier:self.groupID successful:^(NSMutableArray *fileArray) {
        
        _dataArray = fileArray;
        
        [_collectionView reloadData];
        
    } fail:^(NSString *error) {
       
        [XZUtils showAlertView:error];
        
    }];
    
    [self setUpCollectionView];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1.0f;
    layout.minimumInteritemSpacing = 1.0f;
    layout.itemSize = CGSizeMake((UISCREEN_WIDTH-1*3)/4, (UISCREEN_WIDTH-1*3)/4);
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.collectionViewLayout = layout;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"XZPhotoCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"photoCell"];
}

#pragma mark - UICollectionView_DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    id object = _dataArray[indexPath.row];
    
    [cell setUpCellWithObject:object];
    
    return cell;
}
#pragma mark - UICollectionView_Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    XZImageBrowserViewController *imageBrowserVc = [[XZImageBrowserViewController alloc] initWithNibName:@"XZImageBrowserViewController" bundle:[NSBundle mainBundle]];
//    
//    imageBrowserVc.imageNameArray = _imageNameArray;
//    imageBrowserVc.indexPath = indexPath;
//    
//    [self presentViewController:imageBrowserVc animated:YES completion:nil];
}

@end

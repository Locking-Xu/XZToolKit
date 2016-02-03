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
#import <Photos/Photos.h>
#import "XZAlbumHelper.h"

@interface XZPhotoAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    __weak IBOutlet UICollectionView *_collectionView;
    
    NSArray *_imageNameArray;
//    PHFetchResult *_result;
}

@end

@implementation XZPhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCollectionView];
    
    
    
//    [_result enumerateObjectsUsingBlock:^(PHAsset *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        if (obj) {
//            
//            [array addObject:obj];
//        }
//        
//        if (idx == _result.count-1) {
//            
//            [_collectionView reloadData];
//        }
//    }];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 2.0f;
    layout.minimumInteritemSpacing = 2.0f;
    layout.itemSize = CGSizeMake((UISCREEN_WIDTH-2*3)/4, (UISCREEN_WIDTH-5*3)/4);
    
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
    
    ALAsset *asset = _imageNameArray[indexPath.row];
    
    
    CGImageRef imageRef = asset.thumbnail;
    
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    
    [cell setUpCellWithImage:image];
    
    
//    PHAsset *asset = _result[indexPath.row];
//    
////    CGImageRef imageRef = asset
//    
//    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake((UISCREEN_WIDTH-2*3)/4, (UISCREEN_WIDTH-5*3)/4) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage *result, NSDictionary *info){
//        
//        [cell setUpCellWithImageName:result];
//        
//    }];
    
    

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

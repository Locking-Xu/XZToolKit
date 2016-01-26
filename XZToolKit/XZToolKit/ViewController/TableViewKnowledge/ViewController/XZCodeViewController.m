//
//  XZCodeViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCodeViewController.h"
#import "XZImageCell.h"
#import "XZImageBrowserViewController.h"

@interface XZCodeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
    __weak IBOutlet UITextView *_textView;
    
    __weak IBOutlet UICollectionView *_collectionView;
    
    
}

@end

@implementation XZCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.knowledgeTitle;
    
    [self setUpTextView];
    
    [self setUpCollectionView];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpTextView{

    NSString *path = [[NSBundle mainBundle] pathForResource:self.knowledgeTitle ofType:@"txt"];
    
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    _textView.text = content;
    
    _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)setUpCollectionView{
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"XZImageCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"imageCell"];
}

#pragma mark - UICollectionViewFlowout_Delegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    //横向间距
    return 5.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    //纵向间距
    return 0.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((UISCREEN_WIDTH-5*3)/4, [XZImageCell heightOfCell:self.imageArray width:(UISCREEN_WIDTH-5*3)/4]);
}

#pragma mark - UICollectionView_DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    
    [cell setUpCellWithTitle:self.imageTitleArray[indexPath.row] imageName:self.imageArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UICollectionView_Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZImageBrowserViewController *imageBrowserVc = [[XZImageBrowserViewController alloc] initWithNibName:@"XZImageBrowserViewController" bundle:nil];
    
    imageBrowserVc.imageArray = self.imageArray;
    imageBrowserVc.imageTitleArray = self.imageTitleArray;
    imageBrowserVc.indexPath = indexPath;
    
    [self presentViewController:imageBrowserVc animated:YES completion:nil];
}

@end

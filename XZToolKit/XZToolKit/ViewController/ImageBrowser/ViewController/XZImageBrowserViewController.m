//
//  XZImageBrowserViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZImageBrowserViewController.h"

#import "XZImageBrowserLayout.h"
#import "XZImageBrowserCell.h"

@interface XZImageBrowserViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    __weak IBOutlet UIButton *_closeBtn;
    
    __weak IBOutlet UICollectionView *_collectionView;
    
    __weak IBOutlet UILabel *_titleLabel;
    
}

@end

@implementation XZImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _closeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _closeBtn.layer.borderWidth = 1.0f;
    _closeBtn.layer.cornerRadius = 5.0f;
    
    [self.view bringSubviewToFront:_titleLabel];
    
    [self setUpCollectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpCollectionView{

    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.collectionViewLayout = [[XZImageBrowserLayout alloc] init];
    [_collectionView registerNib:[UINib nibWithNibName:@"XZImageBrowserCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"imageBorwserCell"];
}
#pragma mark - UIButton_Actions
- (IBAction)closeBtn_Pressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UICollectionView_DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZImageBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageBorwserCell" forIndexPath:indexPath];
    
    [cell setUpWithImageName:self.imageArray[indexPath.row]];
    
    
    return cell;
}

#pragma mark 
@end

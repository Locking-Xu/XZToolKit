//
//  XZImageBrowserViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZImageBrowserViewController.h"

#import "XZImageBrowserCell.h"

@interface XZImageBrowserViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    __weak IBOutlet UIButton *_closeBtn;
    
//    __weak IBOutlet UICollectionView *_collectionView;
    
    __weak IBOutlet UILabel *_titleLabel;
    
    __weak IBOutlet UILabel *_pageLabel;
    
}

@end

@implementation XZImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _closeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _closeBtn.layer.borderWidth = 1.0f;
    _closeBtn.layer.cornerRadius = 5.0f;
    
    _pageLabel.text = [NSString stringWithFormat:@"1/%ld",(long)self.imageNameArray.count];
    _titleLabel.text = self.imageNameArray[0];
    
    [self setUpCollectionView];
    
    [self.view bringSubviewToFront:_closeBtn];
    [self.view bringSubviewToFront:_pageLabel];
    [self.view bringSubviewToFront:_titleLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT - 70);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 0.0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT) collectionViewLayout:layout];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled =YES;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"XZImageBrowserCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"imageBorwserCell"];
    
     [_collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    [self.view addSubview:_collectionView];
}

#pragma mark - UIButton_Actions
- (IBAction)closeBtn_Pressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UICollectionView_DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.imageNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZImageBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageBorwserCell" forIndexPath:indexPath];
    
    [cell setUpWithImageName:self.imageNameArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UIScrollView_Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    NSInteger page = offset.x/UISCREEN_WIDTH;

    _pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)page+1,(long)self.imageNameArray.count];
    _titleLabel.text = self.imageNameArray[page];
}

@end

//
//  XZLabelFlowOneViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLabelFlowOneViewController.h"
#import "XZLabelFlowCell.h"

#define ContentArray @[@"中国",@"泰兴市",@"江苏省黄桥中学",@"济川实验初中",@"溪桥镇中心小学",@"徐章"]

@interface XZLabelFlowOneViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    XZLabelFlowCell *_cell;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XZLabelFlowOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XZLabelFlowCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([XZLabelFlowCell class])];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Setter && Getter
- (UICollectionView *)collectionView{

    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 0, 5.0);
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewLayout_Delegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 5.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 5.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (!_cell) {
        _cell = [[[NSBundle mainBundle] loadNibNamed:@"XZLabelFlowCell" owner:[NSBundle mainBundle] options:nil] lastObject];
    }
    return [_cell sizeForCell:ContentArray[indexPath.row]];
}

#pragma mark - UICollectionView_DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return ContentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XZLabelFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XZLabelFlowCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.titleLab.backgroundColor = [UIColor redColor];
    cell.titleLab.text = ContentArray[indexPath.row];
    return cell;
}
#pragma mark - UICollectionView_Delegate


@end

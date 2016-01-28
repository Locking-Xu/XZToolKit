//
//  XZDayCalendarViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/25.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZDayCalendarViewController.h"
#import "XZDayCalendarCell.h"
#import "NSDate+String.h"
#import "XZTimeRecordCell.h"

@interface XZDayCalendarViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>{

    __weak IBOutlet UICollectionView *_collectionView;
    
    
    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet NSLayoutConstraint *_collectionViewConstraint_Height;
    
    NSInteger _day;
    
    NSInteger _weekDayOfFirstDay;
    
    NSInteger _weekDayOfLastDay;
    
    NSInteger _numberOfItems;
    
    NSInteger _selectIndex;
    
}

@end

@implementation XZDayCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = [NSDate stringFromDate:self.date format:@"yyyy年MM月"];
    
    self.title = title;
    
    _day = [self.date getValueForUnit:NSCalendarUnitDay];
    
    _weekDayOfFirstDay = [self.date weekdayOfFirstDay];

    _weekDayOfLastDay = [self.date weekDayOfLastDay];
    
    _selectIndex = _day + _weekDayOfFirstDay - 1;

    [self setCollectionView];
    
    [self setTableView];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSInteger column = ceilf(_selectIndex / 7.0);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:column*7-1 inSection:0];
    
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
}

- (void)setCollectionView{
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionViewConstraint_Height.constant = UISCREEN_WIDTH/7;
    _collectionView.pagingEnabled = YES;
    
    _collectionView.bounces = NO;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"XZDayCalendarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"dayCell"];
}

- (void)setTableView{
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView_Flowout
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat itemWidth = UISCREEN_WIDTH/7;
    
    return CGSizeMake(itemWidth, itemWidth-1);
    
}

#pragma mark - UICollectionView_DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    _numberOfItems = (_weekDayOfFirstDay -1) + [self.date numberOfDayInCurrentMonth] + (7 - _weekDayOfLastDay);
    
    return _numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZDayCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dayCell" forIndexPath:indexPath];
    
    if (indexPath.row < _weekDayOfFirstDay-1) {
        
        [cell setUpCellWithDate:self.date month:-1 day:[self.date numberOfDayInPreviousMonth] - _weekDayOfFirstDay+2 + indexPath.row];
        
    }else if(indexPath.row < _weekDayOfFirstDay - 1 + [self.date numberOfDayInCurrentMonth]){
        
        [cell setUpCellWithDate:self.date month:0 day:indexPath.row - _weekDayOfFirstDay +2];

    }else{
        
        [cell setUpCellWithDate:self.date month:1 day:7 - _weekDayOfLastDay + 1 - (_numberOfItems - indexPath.row)];
    }
    
    if (_selectIndex -1 == indexPath.row) {
        
        cell.gregorianLabel.layer.cornerRadius = cell.frame.size.height/3;
        cell.gregorianLabel.layer.masksToBounds = YES;
        cell.gregorianLabel.backgroundColor = [UIColor redColor];

    }
    return cell;
}
#pragma mark - UICollectionView_Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _selectIndex = indexPath.row + 1;
    
    [_collectionView reloadData];

}

#pragma mark - UITableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 24;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}
#pragma mark - UITableView_Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"timeRecordCell";
    
    XZTimeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XZTimeRecordCell" owner:self options:nil] lastObject];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
@end

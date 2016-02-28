//
//  XZLabelFlowView.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLabelFlowView.h"
#import "XZLabelFlowCell.h"
#import "XZLabelFlowLayout.h"
#import "XZLabelFlowConfig.h"
@interface XZLabelFlowView()<UICollectionViewDataSource,UICollectionViewDelegate,XZLabelFlowLayoutDataSource,XZLabelFlowLayoutDelegate>


@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, copy) selectBlock select;
@end
@implementation XZLabelFlowView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles selectBlock:(selectBlock)selectBlock{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.titles = [titles mutableCopy];
        self.select = selectBlock;
        [self addSubview:self.collectionView];
    }
    return self;
    
}

- (UICollectionView *)collectionView{

    if (!_collectionView) {
        
        XZLabelFlowLayout *layout = [[XZLabelFlowLayout alloc] init];
        layout.dataSource = self;
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor greenColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"XZLabelFlowCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([XZLabelFlowCell class])];
        
    }
    return _collectionView;
}

#pragma mark - XZLabelFlow_DataSource
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath{

    return self.titles[indexPath.item];
}

#pragma mark - XZLabelFlow_Delegate
- (void)layoutFinishWithLineNumber:(NSInteger)number{

    static NSInteger lineNumber = 0;
    if (lineNumber == number) return;
    
    lineNumber = number;
    XZLabelFlowConfig *config = [XZLabelFlowConfig shareInstance];
    CGFloat height = config.contentInsets.top+config.contentInsets.bottom+config.textHeight*number+config.lineSpace*(number-1);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    [UIView animateWithDuration:0.2 animations:^{
        self.collectionView.frame = self.bounds;
    }];
 
}

#pragma mark - UICollectionView_DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XZLabelFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XZLabelFlowCell class]) forIndexPath:indexPath];
    
    cell.titleLab.text = self.titles[indexPath.row];
    return cell;
}
#pragma mark - UICollectionView_Delegate


#pragma mark - Operation_Methods
- (void)performBatchUpdateWithAction:(UICollectionUpdateAction)action indexPaths:(NSArray *)indexPaths animation:(BOOL)animation{

    [UIView setAnimationsEnabled:animation];
    [self.collectionView performBatchUpdates:^{
        
        switch (action) {
            case UICollectionUpdateActionInsert:
                [self.collectionView insertItemsAtIndexPaths:indexPaths];
                break;
            case UICollectionUpdateActionDelete:
                [self.collectionView deleteItemsAtIndexPaths:indexPaths];
                break;
            default:
                break;
        }
        
    } completion:^(BOOL finished) {
        if (!animation) {
            [UIView setAnimationsEnabled:YES];
        }
    }];
    
    
}

- (void)insertLabelWithTitle:(NSString *)title index:(NSInteger)index animation:(BOOL)animation{

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.titles insertObject:title atIndex:index];
    [self performBatchUpdateWithAction:UICollectionUpdateActionInsert indexPaths:@[indexPath] animation:animation];
}

- (void)insertMultiLabelWithTitles:(NSArray *)titles index:(NSMutableIndexSet *)set animation:(BOOL)animation{

    NSArray *array = [self indexPathsWithIndex:set];
    [self.titles insertObjects:titles atIndexes:set];
    [self performBatchUpdateWithAction:UICollectionUpdateActionInsert indexPaths:array animation:animation];
}

- (void)deleteLabelAtIndex:(NSInteger)index animation:(BOOL)aniamtion{

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.titles removeObjectAtIndex:index];
    [self performBatchUpdateWithAction:UICollectionUpdateActionDelete indexPaths:@[indexPath] animation:aniamtion];
}

- (void)deleteMultiLabelAtIndex:(NSMutableIndexSet *)set animation:(BOOL)animation{
    
    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx > self.titles.count - 1) {
            
            [set removeIndex:idx];
            NSLog(@"%@",[NSString stringWithFormat:@"%lu越界",(unsigned long)idx]);
        }
    }];
    
    if (set.count == 0) {
        return;
    }
    
    NSArray *indexPaths = [self indexPathsWithIndex:set];
    [self.titles removeObjectsAtIndexes:set];
    
    [self performBatchUpdateWithAction:UICollectionUpdateActionDelete indexPaths:indexPaths animation:animation];
}

- (NSArray *)indexPathsWithIndex:(NSIndexSet *)set{

    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:set.count];
    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }];
    
    return [indexPaths copy];
}
@end

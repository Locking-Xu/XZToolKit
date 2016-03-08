//
//  XZLabelFlowView.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock)(NSUInteger index,NSString *title);

@interface XZLabelFlowView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles selectBlock:(selectBlock)selectBlock;

- (void)insertLabelWithTitle:(NSString *)title index:(NSInteger)index animation:(BOOL)animation;
- (void)insertMultiLabelWithTitles:(NSArray *)titles index:(NSIndexSet *)set animation:(BOOL)animation;

- (void)deleteLabelAtIndex:(NSInteger)index animation:(BOOL)aniamtion;
- (void)deleteMultiLabelAtIndex:(NSIndexSet *)set animation:(BOOL)animation;
@end

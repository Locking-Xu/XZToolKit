//
//  XZLabelFlowTwoLayout.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XZLabelFlowTwoLayoutDataSource <NSObject>

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol XZLabelFlowTwoLayoutDelegate <NSObject>

- (void)layoutFinishWithLineNumber:(NSInteger)number;

@end

@interface XZLabelFlowTwoLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<XZLabelFlowTwoLayoutDataSource> dataSource;
@property (nonatomic, weak) id<XZLabelFlowTwoLayoutDelegate> delegate;
@end

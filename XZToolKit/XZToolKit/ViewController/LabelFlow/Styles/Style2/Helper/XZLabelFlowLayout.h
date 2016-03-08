//
//  XZLabelFlowLayout.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XZLabelFlowLayoutDataSource <NSObject>

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol XZLabelFlowLayoutDelegate <NSObject>

- (void)layoutFinishWithLineNumber:(NSInteger)number;

@end

@interface XZLabelFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<XZLabelFlowLayoutDataSource> dataSource;
@property (nonatomic, weak) id<XZLabelFlowLayoutDelegate> delegate;

@end

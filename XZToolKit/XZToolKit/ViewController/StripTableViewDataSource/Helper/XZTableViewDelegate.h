//
//  XZTableViewDelegate.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/23.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class XZBaseModel;
typedef void(^TableViewSelectCellBlock)(XZBaseModel *model,UITableViewCell *cell);

@interface XZTableViewDelegate : NSObject<UITableViewDelegate>

- (instancetype)initWithItems:(NSArray *)items cellClass:(Class)cellClass selectCellBlock:(TableViewSelectCellBlock) selectCellBlock;
@end

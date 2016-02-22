//
//  XZTableViewDataSource.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/22.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XZBaseCell,XZBaseModel;

typedef void(^TableViewCellConfigureBlock)(XZBaseModel *model,XZBaseCell *cell);

@interface XZTableViewDataSource : NSObject<UITableViewDataSource>

/**
 *  创建数据源管理
 *
 *  @param items           数据源
 *  @param cellClass       cell类
 *  @param configCellblock 设置cell回调
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithItems:(NSArray *)items cellClass:(Class)cellClass configCellBlock:(TableViewCellConfigureBlock)configCellblock;


@end

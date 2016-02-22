//
//  XZBaseCell.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/22.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZBaseCell : UITableViewCell

/**
 *  使用alloc创建cell
 *
 *  @param tableView 所在表示图
 *  @param cellStyle cell的样式
 *
 *  @return cell
 */
+ (instancetype)cellAllocWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle;

/**
 *  使用xib加载cell
 *
 *  @param tableView 所在的表示图
 *
 *  @return cell
 */
+ (instancetype)cellLoadXibWithTableView:(UITableView *)tableView;

@end

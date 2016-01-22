//
//  XZMonthCalendarCell.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/21.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZMonthCalendarCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) NSDate *date;

/**
 *  设置cell具体的内容
 *
 *  @param date 内容相对应的时间
 */
- (void)setUpCellWithDate:(NSDate *)date;

+ (CGFloat)heightOfCell;
@end

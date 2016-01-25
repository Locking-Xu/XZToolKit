//
//  XZCalendarCell.h
//  XZYearCalendar
//
//  Created by 徐章 on 16/1/16.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZCalendarCell : UITableViewCell

@property (nonatomic, strong) UILabel *yearLabel;

/**
 *  cell的高度
 */
+ (CGFloat)heightOfCell;

/**
 *  设置cell具体的内容
 *
 *  @param date 内容相对应的时间
 */
- (void)setUpCellWithDate:(NSDate *)date;
@end

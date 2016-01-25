//
//  XZMonthView.h
//  XZYearCalendar
//
//  Created by 徐章 on 16/1/16.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZMonthView : UIView

@property (nonatomic, strong) UIImageView *imageView;
/** MonthView是属于哪一年*/
@property (nonatomic, assign) NSInteger year;
/** MonthView是哪一月*/
@property (nonatomic, assign) NSUInteger month;

- (void)setMonthImageWithDate:(NSDate *)date size:(CGSize)size;
@end

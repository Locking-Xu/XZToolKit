//
//  XZDayCalendarCell.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/25.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZDayCalendarCell.h"
#import "NSDate+String.h"

@implementation XZDayCalendarCell

- (void)awakeFromNib {
    // Initialization code

}

- (void)setUpCellWithDate:(NSDate *)date month:(NSInteger)month day:(NSInteger)day{
    self.gregorianLabel.backgroundColor = [UIColor whiteColor];
    
    if (month == 0) {
        self.gregorianLabel.textColor = [UIColor blackColor];
        
        self.lunarLabel.textColor = [UIColor blackColor];
        self.userInteractionEnabled = YES;
    }else{
        self.gregorianLabel.textColor = [UIColor lightGrayColor];
        
        self.lunarLabel.textColor = [UIColor lightGrayColor];
        
        self.userInteractionEnabled = NO;
    }
    
    self.gregorianLabel.text = XZIntToString(day);
    NSDateComponents *dateComponent= [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    [dateComponent setDay:day];
    dateComponent.month += month;
    
    NSDate *tmpDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponent];
    
    self.lunarLabel.text = [tmpDate dateOfChinese];
}
@end

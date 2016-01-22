//
//  NSDate+String.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/11.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "NSDate+String.h"

@implementation NSDate (String)
- (void)setCalendar:(NSCalendar *)calendar{
    
    self.calendar = [NSCalendar currentCalendar];
}

- (NSCalendar *)calendar{
    
    return [NSCalendar currentCalendar];
}
/**
 *  根据NSString获得NSDate
 *
 *  @param sDate  NSString
 *  @param format 默认为yyyy-MM-dd HH:mm:ss
 *
 *  @return NSDate
 */
+ (NSDate *)dateFromString:(NSString *)sDate format:(NSString *)format{

    if ([sDate isKindOfClass:[NSNull class]]) {
        
        return nil;
    }
    
    if ([format isEqualToString:@""] || !format) {
        
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:format];
    
    return [dateFormat dateFromString:sDate];
}

/**
 *  根据NSDate获得NSString
 *
 *  @param sDate  NSString
 *  @param format 默认为yyyy-MM-dd HH:mm:ss
 *
 *  @return NSDate
 */
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format{

    if (!date) {
        return @"";
    }
    if ([format isEqualToString:@""] || !format) {
        
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:format];
    
    return [dateFormat stringFromDate:date];
}

/**
 *  在key属性上的偏移value
 *
 *  @param value 偏移
 *  @param key   属性
 *
 *  @return 偏移后的时间
 */
- (NSDate *)dateByAddingValue:(NSInteger)value forKey:(NSString *)key{
    
    NSDateComponents *dateComponents = [NSDateComponents new];
    [dateComponents setValue:@(value) forKey:key];
    
    return [self.calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

/**
 *  获得date的某一单元的值
 *
 *  @param key 单元名
 *
 *  @return NSDate
 */
- (NSDate *)getValueForUnit:(NSCalendarUnit)unit{
    
    NSDateComponents *dateComponent = [NSDateComponents new];
    
    dateComponent = [self.calendar components:unit fromDate:self];
    
    return [self.calendar dateFromComponents:dateComponent];
}

/**
 *  当前月份的总天数
 *
 *  @return 天数
 */
- (NSInteger)numberOfDayInMonth{
    
    NSRange range = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    
    return range.length;
}

/**
 *  获得当前日期是周几
 *
 *  @return 1:星期日2:星期一3:星期二4:星期三5:星期四6:星期五7:星期六
 */
- (NSInteger)weekDay{
    
    NSDateComponents *dateComponents = [self.calendar components:NSCalendarUnitWeekday fromDate:self];
    
    return dateComponents.weekday;
}
@end

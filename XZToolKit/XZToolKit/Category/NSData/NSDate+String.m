//
//  NSDate+String.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/11.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "NSDate+String.h"

#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]

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
- (NSDate *)getDateForUnit:(NSCalendarUnit)unit{
    
    NSDateComponents *dateComponent = [NSDateComponents new];
    
    dateComponent = [self.calendar components:unit fromDate:self];
    
    return [self.calendar dateFromComponents:dateComponent];
}

/**
 *  获得date的某一单元的值
 *
 *  @param key 单元名
 *
 *  @return NSString
 */
- (NSInteger)getValueForUnit:(NSCalendarUnit)unit{
    
    NSDateComponents *dateComponent = [NSDateComponents new];
    
    dateComponent = [self.calendar components:unit fromDate:self];
    
    return [dateComponent valueForComponent:unit];
}


/**
 *  当前月份的总天数
 *
 *  @return 天数
 */
- (NSInteger)numberOfDayInCurrentMonth{
    
    NSRange range = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    
    return range.length;
}

/**
 *  当前月份的前一个月的总天数
 *
 *  @return 天数
 */
- (NSInteger)numberOfDayInPreviousMonth{
    
    NSDate *date = [self dateByAddingValue:-1 forKey:@"month"];
    
    return [date numberOfDayInCurrentMonth];
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

/**
 *  获得当前月的第一天是星期几
 *
 *  @return 1:星期日2:星期一3:星期二4:星期三5:星期四6:星期五7:星期六
 */
- (NSInteger)weekdayOfFirstDay{
    
    NSDateComponents *dateComponents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:self];
    
    [dateComponents setDay:1];
    
    NSDate *date = [self.calendar dateFromComponents:dateComponents];
    
    return [date weekDay];
}

/**
 *  获得当前月的最后一天是星期几
 *
 *  @return 1:星期日2:星期一3:星期二4:星期三5:星期四6:星期五7:星期六
 */
- (NSInteger)weekDayOfLastDay{

    NSDateComponents *dateComponents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:self];
    
    [dateComponents setDay:[self numberOfDayInCurrentMonth]];
    
    NSDate *date = [self.calendar dateFromComponents:dateComponents];
    
    return [date weekDay];
}

/**
 *  获得某一天的阴历
 *
 *  @return 阴历
 */
- (NSString *)dateOfChinese{

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    
    if (components.day == 1)
        return ChineseMonths[components.month - 1];
    else
        return ChineseDays[components.day - 1];
}
@end

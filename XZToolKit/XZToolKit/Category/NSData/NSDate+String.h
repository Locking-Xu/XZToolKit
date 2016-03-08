//
//  NSDate+String.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/11.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (String)

@property (nonatomic, strong) NSCalendar *calendar;

/**
 *  根据NSString获得NSDate
 *
 *  @param sDate  NSString
 *  @param format 默认为yyyy-MM-dd HH:mm:ss
 *
 *  @return NSDate
 */
+ (NSDate *)dateFromString:(NSString *)sDate format:(NSString *)format;

/**
 *  根据NSDate获得NSString
 *
 *  @param sDate  NSString
 *  @param format 默认为yyyy-MM-dd HH:mm:ss
 *
 *  @return NSDate
 */
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

/**
 *  在key属性上的偏移value
 *
 *  @param value 偏移
 *  @param key   属性
 *
 *  @return 偏移后的时间
 */
- (NSDate *)dateByAddingValue:(NSInteger)value forKey:(NSString *)key;

/**
 *  获得date的某一单元的值
 *
 *  @param key 单元名
 *
 *  @return NSDate
 */
- (NSDate *)getDateForUnit:(NSCalendarUnit)unit;

/**
 *  获得date的某一单元的值
 *
 *  @param key 单元名
 *
 *  @return NSString
 */
- (NSInteger)getValueForUnit:(NSCalendarUnit)unit;

/**
 *  当前月份的总天数
 *
 *  @return 天数
 */
- (NSInteger)numberOfDayInCurrentMonth;

/**
 *  当前月份的前一个月的总天数
 *
 *  @return 天数
 */
- (NSInteger)numberOfDayInPreviousMonth;

/**
 *  获得当前日期是周几
 *
 *  @return 1:星期日2:星期一3:星期二4:星期三5:星期四6:星期五7:星期六
 */
- (NSInteger)weekDay;

/**
 *  获得当前月的第一天是星期几
 *
 *  @return 1:星期日2:星期一3:星期二4:星期三5:星期四6:星期五7:星期六
 */
- (NSInteger)weekdayOfFirstDay;

/**
 *  获得当前月的最后一天是星期几
 *
 *  @return 1:星期日2:星期一3:星期二4:星期三5:星期四6:星期五7:星期六
 */
- (NSInteger)weekDayOfLastDay;

/**
 *  获得某一天的阴历
 *
 *  @return 阴历
 */
- (NSString *)dateOfChinese;
@end

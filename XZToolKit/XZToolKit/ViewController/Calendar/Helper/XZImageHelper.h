//
//  XZImageHelper.h
//  XZYearCalendar
//
//  Created by 徐章 on 16/1/16.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XZImageHelper : NSObject

+ (XZImageHelper *)shareInstance;

- (UIImage *)getMonthImageWithDate:(NSDate *)date size:(CGSize)size;

- (UIImage *)getDayImageWithDate:(NSDate *)date size:(CGSize)size;
@end

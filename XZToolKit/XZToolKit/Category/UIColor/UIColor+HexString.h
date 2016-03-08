//
//  UIColor+HexString.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/11.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

/**
 *  根据16进制获得色值
 *
 *  @param stringToConvert 16进制
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
@end

//
//  NSString+Format.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Format)

+ (NSString *)stringFromInt:(NSInteger)value;

+ (NSString *)stringFromFloat:(CGFloat)value format:(NSString *)format;
@end

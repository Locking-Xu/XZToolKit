//
//  NSString+Format.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "NSString+Format.h"

@implementation NSString (Format)

+ (NSString*)stringFromInt:(NSInteger)value
{
    return [NSString stringWithFormat: @"%ld", (long)value];
}

+ (NSString*)stringFromFloat:(CGFloat)value format: (NSString*)format
{
    if (format == nil) {
        return [NSString stringWithFormat: @"%.02f", value];
    }
    return [NSString stringWithFormat: format, value];
}


@end

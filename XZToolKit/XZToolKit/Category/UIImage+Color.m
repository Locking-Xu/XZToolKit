//
//  UIImage+Color.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/24.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

/**
 *  获得一张纯色的图片
 *
 *  @param color 图片颜色
 *
 *  @return UIImage
 */
+ (UIImage *)imageFromColor:(UIColor *)color{
    
    NSParameterAssert(color != nil);
    
    CGRect rect = CGRectMake(0, 0, 320, 44);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

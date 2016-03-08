//
//  UIImage+Color.h
//  XZToolKit
//
//  Created by 徐章 on 16/2/24.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *  获得一张纯色的图片
 *
 *  @param color 图片颜色
 *
 *  @return UIImage
 */
+ (UIImage *)imageFromColor:(UIColor *)color;
@end

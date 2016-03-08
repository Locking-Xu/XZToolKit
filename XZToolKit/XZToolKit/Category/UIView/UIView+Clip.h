//
//  UIView+Clip.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/3.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Clip)
/**
 *  截取Rect范围内的图片
 *
 *  @param rect 截取范围,如果范围为CGRectZero则截取全屏幕
 *
 *  @return UIImage
 */
- (UIImage *)imageWithRect:(CGRect)rect;
@end

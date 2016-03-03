//
//  UIView+Clip.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/3.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "UIView+Clip.h"

@implementation UIView (Clip)
/**
 *  截取Rect范围内的图片
 *
 *  @param rect 截取范围,如果范围为CGRectZero则截取全屏幕
 *
 *  @return UIImage
 */
- (UIImage *)imageWithRect:(CGRect)rect{

    UIGraphicsBeginImageContext(self.frame.size);
    if (CGRectEqualToRect(rect, CGRectZero)) {
        //截取全屏
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
        
    }else{
        //截取Rect
        UIRectClip(rect);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}
@end

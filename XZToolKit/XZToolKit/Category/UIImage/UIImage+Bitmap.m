//
//  UIImage+Bitmap.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "UIImage+Bitmap.h"

@implementation UIImage (Bitmap)
/**
 *  截取图片指定区域
 *
 *  @param rect 指定区域
 *
 *  @return 截取的图片
 */
- (UIImage *)imageAtRect:(CGRect)rect{

    CGImageRef imageRef = self.CGImage;
    CGImageRef newImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    
    return [UIImage imageWithCGImage:newImageRef];
}

/**
 *  将图片按一定的比例缩放
 *
 *  @param proportion 缩放的比例
 *
 *  @return 新的图片
 */
- (UIImage *)imageScaletoProportion:(CGFloat)proportion{
    
    CGSize size = CGSizeMake(self.size.width*proportion, self.size.height*proportion);
    
    UIGraphicsBeginImageContextWithOptions (size, NO, [[UIScreen mainScreen] scale]);
    [self drawInRect:CGRectMake (0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext ();
    
    return newImage;
}

/**
 *  保持图片比例,短边＝targerSize,另外一边可能超出
 *
 *  @param targetSize 目标尺寸
 *
 *  @return New Image
 */
- (UIImage *)imageByScalingAspectToMinSize:(CGSize)targetSize{

    if (CGSizeEqualToSize(self.size, targetSize))
        return self;
    
    //水平方向缩放因子
    CGFloat xFactor = targetSize.width/self.size.width;
    //竖直方向缩放因子
    CGFloat yFactor = targetSize.height/self.size.height;
    
    CGFloat scaleFactor = xFactor>yFactor ? xFactor : yFactor;
    
    CGFloat scaleWidth = self.size.width * scaleFactor;
    CGFloat scaleHeight = self.size.height * scaleFactor;
    
    //如果横向上缩放因子大,纵向上需要裁剪
    CGPoint anchorPoint = CGPointZero;//锚点
    
    if (xFactor > yFactor)
        anchorPoint.y = (targetSize.height - scaleHeight)/2.0;
    if (xFactor < yFactor)
        anchorPoint.x = (targetSize.width - scaleWidth)/2.0;
    
    //开始绘图
    UIGraphicsBeginImageContext(targetSize);
    CGRect anchorRect = CGRectZero;
    anchorRect.origin = anchorPoint;
    anchorRect.size.width = scaleWidth;
    anchorRect.size.height = scaleHeight;
    [self drawInRect:anchorRect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  保持图片比例,长边＝targerSize,另外一边可能小于targetSize
 *
 *  @param targetSize 目标尺寸
 *
 *  @return New Image
 */
- (UIImage *)imageByScalingAspectToMaxSize:(CGSize)targetSize{
    
    if (CGSizeEqualToSize(self.size, targetSize))
        return self;
    
    //水平方向缩放因子
    CGFloat xFactor = targetSize.width/self.size.width;
    //竖直方向缩放因子
    CGFloat yFactor = targetSize.height/self.size.height;
    
    CGFloat scaleFactor = xFactor<yFactor ? xFactor : yFactor;
    
    CGFloat scaleWidth = self.size.width * scaleFactor;
    CGFloat scaleHeight = self.size.height * scaleFactor;
    
    //如果横向上缩放因子大,纵向上需要裁剪
    CGPoint anchorPoint = CGPointZero;//锚点
    
    if (xFactor < yFactor)
        anchorPoint.y = (targetSize.height - scaleHeight)/2.0;
    if (xFactor > yFactor)
        anchorPoint.x = (targetSize.width - scaleWidth)/2.0;
    
    //开始绘图
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, [UIScreen mainScreen].scale);
    CGRect anchorRect = CGRectZero;
    anchorRect.origin = anchorPoint;
    anchorRect.size.width = scaleWidth;
    anchorRect.size.height = scaleHeight;
    [self drawInRect:anchorRect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  图片不保持比例缩放
 *
 *  @param targetSize 目标size
 *
 *  @return UIImage
 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize{

    //开始绘图
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;

}

/**
 *  图片旋转指定的弧度
 *
 *  @param radius 旋转的弧度
 *
 *  @return UIImage
 */
- (UIImage *)imageRotateByRadius:(CGFloat)radius{

    CGAffineTransform t = CGAffineTransformMakeRotation(radius);
    //对原始区域进行旋转
    CGRect rect = CGRectApplyAffineTransform(CGRectMake(0, 0, self.size.width, self.size.height), t);
    //开始绘图
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定坐标转换,将图片中心平移到图片中心
    CGContextTranslateCTM(context, rect.size.width/2.0, rect.size.height/2.0);
    CGContextRotateCTM(context, radius);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(-self.size.width/2.0, -self.size.height/2.0, self.size.width, self.size.height), self.CGImage);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  图片旋转指定的角度
 *
 *  @param degrees 旋转的角度
 *
 *  @return UIImage
 */
- (UIImage *)imageRotateByDegrees:(CGFloat)degrees{

    return [self imageRotateByRadius:degrees * M_PI / 180.0];
}
@end

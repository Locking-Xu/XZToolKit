//
//  UIImage+Bitmap.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Bitmap)
/**
 *  截取图片指定区域
 *
 *  @param rect 指定区域
 *
 *  @return 截取的图片
 */
- (UIImage *)imageAtRect:(CGRect)rect;

/**
 *  将图片按一定的比例缩放
 *
 *  @param proportion 缩放的比例
 *
 *  @return 新的图片
 */
- (UIImage *)imageScaletoProportion:(CGFloat)proportion;

/**
 *  保持图片比例,短边＝targerSize,另外一边可能超出
 *
 *  @param targetSize 目标尺寸
 *
 *  @return New Image
 */
- (UIImage *)imageByScalingAspectToMinSize:(CGSize)targetSize;

/**
 *  保持图片比例,长边＝targerSize,另外一边可能小于targetSize
 *
 *  @param targetSize 目标尺寸
 *
 *  @return New Image
 */
- (UIImage *)imageByScalingAspectToMaxSize:(CGSize)targetSize;

/**
 *  图片不保持比例缩放
 *
 *  @param targetSize 目标size
 *
 *  @return UIImage
 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

/**
 *  图片旋转指定的弧度
 *
 *  @param radius 旋转的弧度
 *
 *  @return UIImage
 */
- (UIImage *)imageRotateByRadius:(CGFloat)radius;

/**
 *  图片旋转指定的角度
 *
 *  @param degrees 旋转的角度
 *
 *  @return UIImage
 */
- (UIImage *)imageRotateByDegrees:(CGFloat)degrees;
@end

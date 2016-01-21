//
//  XZImageTest.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/21.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZImageTest.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

static XZImageTest *imageHelper = nil;
@implementation XZImageTest

+ (XZImageTest *)shareInstance{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        imageHelper = [[XZImageTest alloc] init];
    });
    return imageHelper;
}

/**
 *  单例使用的安全
 */
+ (id)alloc{
    
    @synchronized([XZImageTest class]) {
        
        NSAssert(imageHelper == nil, @"这是一个单例，不能再被alloc了");
        
        imageHelper = [super alloc];
        
        return imageHelper;
    }
}

#pragma mark CGContexrRef & CGImageRef
/**
 *  创建CGContextRef
 *
 *  @param size CGContext的size
 *
 *  @return CGContextRef
 */
CG_INLINE CGContextRef CGContextCreate(CGSize size){
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width * scale, size.height * scale, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextScaleCTM(context, scale, scale);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, YES);
    CGContextSetAllowsAntialiasing(context, YES);
    
    //处理context颠倒问题
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,size.height);
    transform = CGAffineTransformScale(transform, 1.0, -1.0);
    CGContextSetTextMatrix(context, transform);
    
    CGColorSpaceRelease(colorSpace);
    
    return context;
    
}

CG_INLINE UIImage* UIGraphicsGetImageFromContext(CGContextRef context){
    
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:cgImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationDownMirrored];
    CGImageRelease(cgImage);
    
    return image;
}

#pragma mark Private_Methods

- (UIImage *)getMonthImageWithDate:(NSDate *)date size:(CGSize)size{
    
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        
        CGContextRef context = CGContextCreate(size);
        
//        [self drawMonthInContext:context date:date size:size];
        [self drawTitleOfMonthInContext:context rect:CGRectMake(0, 0, size.width, size.height) title:@"三十"];
        
        UIImage *image = UIGraphicsGetImageFromContext(context);
        
        CGContextRelease(context);
        
        return image;
    }
    return nil;
}

/**
 *  绘制月份Title
 *
 *  @param context CGContextRef
 *  @param rect    绘制的区域
 *  @param title   标题
 */
- (void)drawTitleOfMonthInContext:(CGContextRef)context rect:(CGRect)rect title:(NSString *)title{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    
    NSDictionary *dic = @{
                          (id)kCTForegroundColorAttributeName:(id)[UIColor redColor].CGColor,
                          NSFontAttributeName:[UIFont systemFontOfSize:12.0f]
                          };
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:dic];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attString.length), path,NULL);
    
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
}


@end

//
//  XZQuartz2DTextView.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/24.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DTextView.h"

@implementation XZQuartz2DTextView
- (id)initWithFrame:(CGRect)frame{

    self =[super initWithFrame:frame];
    if (self) {
        
        self.scale = 1;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置字符间距
    CGContextSetCharacterSpacing(context, 4);
    //设置线条颜色
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
    //设置填充颜色
    CGContextSetRGBFillColor(context, 1, 0, 1, 1);
    //设置填充模式
    CGContextSetTextDrawingMode(context, kCGTextFill);
    
    //绘制文本
    NSString *string = @"徐章";
    [string drawAtPoint:CGPointMake(10.0, 20.0)
         withAttributes:@{
                          NSFontAttributeName:[UIFont fontWithName:@"Arial Rounded MT Bold" size:45],
                          NSForegroundColorAttributeName:[UIColor magentaColor]
                          }];
    //设置填充模式
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    [string drawAtPoint:CGPointMake(10.0, 80.0)
         withAttributes:@{
                          NSFontAttributeName:[UIFont fontWithName:@"Heiti SC" size:40],
                          NSForegroundColorAttributeName:[UIColor blueColor]
                          }];
    
    CGContextSetTextDrawingMode(context, kCGTextFillStroke);
    [string drawAtPoint:CGPointMake(10.0, 130.0)
         withAttributes:@{
                          NSFontAttributeName:[UIFont fontWithName:@"Heiti SC" size:40],
                          NSForegroundColorAttributeName:[UIColor blueColor]
                          }];
    
    //定义一个垂直镜像的变换矩阵
    CGAffineTransform yRevert = CGAffineTransformMake(1, 0, 0, -1, 0, 0);
//    CGAffineTransform yRevert = CGAffineTransformIdentity;
    CGAffineTransform scale = CGAffineTransformScale(yRevert, self.scale, self.scale);
    CGAffineTransform rotate = CGAffineTransformRotate(scale, M_PI * self.rotate/180);
    
    CGContextSetTextMatrix(context, rotate);

#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGContextSelectFont(context, "Courier New", 40, kCGEncodingMacRoman);
    CGContextShowTextAtPoint(context, 50, 300, "suzhou", 6);
}

- (void)setScale:(CGFloat)scale{

    _scale = scale;
    [self setNeedsDisplay];
}

- (void)setRotate:(CGFloat)rotate{

    _rotate = rotate;
    [self setNeedsDisplay];
}


@end

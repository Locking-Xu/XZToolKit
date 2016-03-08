//
//  XZQuartz2DShadowView.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/25.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DShadowView.h"

@implementation XZQuartz2DShadowView


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置阴影
    CGContextSetShadow(context, CGSizeMake(8, -6), 5);
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
    
    CGContextSetShadowWithColor(context, CGSizeMake(8, -6), 5, [UIColor redColor].CGColor);
    CGContextFillRect(context, CGRectMake(20, 150, 180, 80));
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(30, 260, 180, 80));

}


@end

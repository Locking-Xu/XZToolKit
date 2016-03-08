//
//  XZQuartz2DBasicView.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/23.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DBasicView.h"

@implementation XZQuartz2DBasicView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线宽
    CGContextSetLineWidth(context, 10.0f);
    //设置线条颜色
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    
    //－－－－－－－－－－绘制线条
    CGPoint points1[] = {CGPointMake(10, 40),CGPointMake(100,40),CGPointMake(100, 40),CGPointMake(20, 70)};
    CGContextStrokeLineSegments(context, points1, 4);
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    CGPoint points2[] = {CGPointMake(130, 40),CGPointMake(230,40),CGPointMake(230, 40),CGPointMake(140, 70)};
    CGContextStrokeLineSegments(context, points2, 4);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGPoint points3[] = {CGPointMake(250, 40),CGPointMake(350,40),CGPointMake(350, 40),CGPointMake(260, 70)};
    CGContextStrokeLineSegments(context, points3, 4);
    CGContextSetLineCap(context, kCGLineCapButt);
    
    //－－－－－－－－－绘制点线样式
    CGFloat patterns1[] = {6,15};
    //设置点线模式,实现宽度为6,间隔为10
    CGContextSetLineDash(context, 0, patterns1, 2);
    CGPoint points4[] = {CGPointMake(40, 85),CGPointMake(280, 85)};
    CGContextStrokeLineSegments(context, points4, 2);
    //设置点线模式,实现宽度为6,间隔为10,第一条实线间隔为3
    CGContextSetLineDash(context, 3, patterns1, 2);
    CGPoint points5[] = {CGPointMake(40, 105),CGPointMake(280, 105)};
    CGContextStrokeLineSegments(context, points5, 2);
    
    CGFloat patterns2[] = {6,1,3,6,7,5,3,1,1,9,14,8,3,5,4,5};
    //设置点线模式,实现宽度为6,间隔为10
    CGContextSetLineDash(context, 0, patterns2, 18);
    CGPoint points6[] = {CGPointMake(40, 125),CGPointMake(280, 125)};
    CGContextStrokeLineSegments(context, points6, 2);
    
    //－－－－－－－－－绘制填充矩形
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, CGRectMake(30, 140, 120, 60));
    
    //－－－－－－－－－绘制举行边框
    //取消点线模式
    CGContextSetLineDash(context, 0, 0, 0);
    CGContextStrokeRect(context, CGRectMake(30, 250, 120, 60));
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    //－－－－－－－－－绘制内切圆
    CGContextStrokeEllipseInRect(context, CGRectMake(30, 400, 120, 60));
    
    //－－－－－－－－－绘制填充内切圆
    CGContextFillEllipseInRect(context, CGRectMake(180, 400, 120, 60));
    
}


@end

//
//  XZQuartz2DDashView.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/23.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DDashView.h"

@implementation XZQuartz2DDashView

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        //每次清空上一次绘制的内容
        self.clearsContextBeforeDrawing = YES;
        self.opaque = YES;
        _dashPase = 0.0;
        _dashCount = 0;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect{

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineDash(context, _dashPase, _dashPattern, _dashCount);
    
    CGPoint line1[] = {CGPointMake(10.0, 20.0),CGPointMake(360.0, 20.0)};
    CGContextStrokeLineSegments(context, line1, 2);
    CGPoint line2[] = {CGPointMake(185.0, 30.0f),CGPointMake(185.0, 250.0)};
    CGContextStrokeLineSegments(context, line2, 2);
    //绘制一个矩形
    CGContextStrokeRect(context, CGRectMake(10.0, 30.0, 120.0, 120.0));
    //绘制一个椭圆
    CGContextStrokeEllipseInRect(context, CGRectMake(230.0, 50.0, 120.0, 120.0));
    
    
}

- (void)setDashPase:(CGFloat)dashPase{

    _dashPase = dashPase;
    [self setNeedsDisplay];
}

- (void)setDashPattern:(CGFloat *)pattern count:(size_t)count{

    //count不等于dashCount或者dashPattern和pattern内容不相等
    if (count != _dashCount || (memcmp(_dashPattern, pattern, sizeof(CGFloat)*count)) != 0) {
        //将pattern复制到dashPattern
        memcpy(_dashPattern, pattern, sizeof(CGFloat)*count);
        _dashCount = count;
        [self setNeedsDisplay];
    }
}

@end

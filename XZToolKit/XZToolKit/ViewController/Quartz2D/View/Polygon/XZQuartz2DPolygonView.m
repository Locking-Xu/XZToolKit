//
//  XZQuartz2DPolygonView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/3.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DPolygonView.h"

@implementation XZQuartz2DPolygonView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddRoundRect(context, 20, 20, 100, 50, 10);
    CGContextAddStar(context, 3, 150, 60, 30);
    CGContextAddStar(context, 5, 150, 120, 30);
    CGContextAddStar(context, 7, 150, 180, 30);
    CGContextAddStar(context, 9, 150, 240, 30);
    CGContextAddFlower(context, 6, 200, 200, 20, 30);
    CGContextStrokePath(context);
    
}

/**
 *  绘制圆角矩形
 *
 *  @param context 上下文
 *  @param x       左上角x
 *  @param y       左上角y
 *  @param width   宽度
 *  @param height  高度
 *  @param radius  半径
 */
void CGContextAddRoundRect(CGContextRef context,CGFloat x,CGFloat y,CGFloat width,CGFloat height,CGFloat radius){

    CGContextMoveToPoint(context, x + radius, y);
    CGContextAddLineToPoint(context, x + width-radius, y);
    CGContextAddArcToPoint(context, x+width, y, x+width, y+radius, radius);
    CGContextAddLineToPoint(context, x+width, y+height-radius);
    CGContextAddArcToPoint(context, x+width, y+height, x+width-radius, y+height, radius);
    CGContextAddLineToPoint(context, x+radius, y+height);
    CGContextAddArcToPoint(context, x, y+height, x, y+height-radius, radius);
    CGContextAddLineToPoint(context, x, y+radius);
    CGContextAddArcToPoint(context, x, y, x+radius, y, radius);
}

/**
 *  绘制五角星
 *
 *  @param context 上下文
 *  @param n       n角星
 *  @param dx      n角星的中心x
 *  @param dy      n角星的中心y
 *  @param size    n角星大小
 */
void CGContextAddStar(CGContextRef context,NSInteger n,CGFloat dx,CGFloat dy,NSInteger size){

    CGFloat dig = 4*M_PI/n;
    CGContextMoveToPoint(context, dx, dy+size);
    for (int i = 0; i<=n; i++) {
        CGFloat x = sin(i*dig);
        CGFloat y = cos(i*dig);
        CGContextAddLineToPoint(context, x*size +dx, y*size + dy);
    }
}

/**
 *  绘制花瓣
 *
 *  @param context 上下文
 *  @param n       n花瓣
 *  @param dx      中心位置x
 *  @param dy      中心位置y
 *  @param size    大小
 *  @param lenght  长度
 */
void CGContextAddFlower(CGContextRef context,NSInteger n,CGFloat dx,CGFloat dy,NSInteger size,NSInteger length){

    CGContextMoveToPoint(context, dx, dy+size);
    CGFloat dig = 2*M_PI/n;
    for (int i = 0; i<=n; i++) {
        //计算控制点
        CGFloat ctr1x = sin((i-0.5) * dig) *length + dx;
        CGFloat ctr1y = cos((i-0.5) * dig) *length + dx;
        //结束点
        CGFloat x = sin(i*dig) * size + dx;
        CGFloat y = cos(i*dig) * size + dy;
        
        CGContextAddQuadCurveToPoint(context, ctr1x, ctr1y, x, y);
    }
    
}
@end

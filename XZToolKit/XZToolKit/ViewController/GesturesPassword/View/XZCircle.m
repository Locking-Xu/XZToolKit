//
//  XZCircle.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCircle.h"
#import "XZGesturesPasswordConfig.h"
@interface XZCircle()
/**外环的颜色 */
@property (nonatomic, strong) UIColor *outCircleColor;
/** 实心圆的颜色*/
@property (nonatomic, strong) UIColor *inCircleColor;
/** 三角形箭头的颜色*/
@property (nonatomic, strong) UIColor *trangleColor;
@end

@implementation XZCircle

- (id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat translateXY = rect.size.width * .5f;
    //平移
    CGContextTranslateCTM(context, translateXY, translateXY);
    CGContextRotateCTM(context, self.angle);
    //再平移回来
    CGContextTranslateCTM(context, -translateXY, -translateXY);
    
    [self drawEmptyCircleWithContext:context rect:CGRectMake(CircleLineWidth, CircleLineWidth, rect.size.width - 2*CircleLineWidth, rect.size.height - 2*CircleLineWidth)];
    
    CGFloat proportation = self.kind == CircleLockView ? 0.4f : 1.0f;
    
    [self drawSolidCircleWithContext:context proportion:proportation rect:rect];
    [self drawTrangleWithContext:context rect:rect];
}

#pragma mark - Setter && Getter 
/**
 *  外圆环的绘制颜色
 *
 *  @return UIColor
 */
- (UIColor *)outCircleColor{
    
    switch (self.state) {
        case CircleStateNormal:
            return CircleStateNormalOutSideColor;
        case CircleStateSelected:
            return CircleStateSelectedOutSideColor;
        case CircleStateError:
            return CircleStateErrorOutSideColor;
        case CircleStateLastSelected:
            return CircleStateSelectedInSideColor;
        case CircleStateLastError:
            return CircleStateErrorOutSideColor;
        default:
            return [UIColor clearColor];
            break;
    }
}

/**
 *  内圆实心圆的绘制颜色
 *
 *  @return UIColor
 */
- (UIColor *)inCircleColor{
    
    switch (self.state) {
        case CircleStateNormal:
            return CircleStateNormalInSideColor;
        case CircleStateSelected:
            return CircleStateSelectedInSideColor;
        case CircleStateError:
            return CircleStateErrorInSideColor;
        case CircleStateLastSelected:
            return CircleStateSelectedInSideColor;
        case CircleStateLastError:
            return CircleStateErrorInSideColor;
        default:
            return [UIColor clearColor];
            break;
    }
}
/**
 *  三角形箭头的绘制颜色
 *
 *  @return UIColor
 */
- (UIColor *)trangleColor{
    
    switch (self.state) {
        case CircleStateNormal:
            return CircleStateNormalInSideColor;
        case CircleStateSelected:
            return CircleStateSelectedInSideColor;
        case CircleStateError:
            return CircleStateErrorInSideColor;
        case CircleStateLastSelected:
            return CircleStateNormalInSideColor;
        case CircleStateLastError:
            return CircleStateNormalInSideColor;
        default:
            return [UIColor clearColor];
            break;
    }
}


- (void)setState:(State)state{
    _state = state;
    [self setNeedsDisplay];
}

- (void)setAngle:(CGFloat)angle{
    _angle = angle;
    
    [self setNeedsDisplay];
}

#pragma mark - Private_Methods
/**
 *  绘制空心外圆环
 *
 *  @param context 上下文
 *  @param rect       绘制区域
 */
- (void)drawEmptyCircleWithContext:(CGContextRef)context rect:(CGRect)rect{
    
    CGContextSetLineWidth(context, CircleLineWidth);
    CGContextSetStrokeColorWithColor(context, self.outCircleColor.CGColor);
    CGContextStrokeEllipseInRect(context, rect);
}

/**
 *  绘制选中状态下的实心圆
 *
 *  @param context    上下文
 *  @param proportion 实心圆的比例
 *  @param rect       绘制区域
 */
- (void)drawSolidCircleWithContext:(CGContextRef)context proportion:(CGFloat)proportion rect:(CGRect)rect{

    CGContextSetFillColorWithColor(context, self.inCircleColor.CGColor);
    CGFloat width = rect.size.width * proportion;
    CGFloat height = rect.size.height *proportion;
    CGFloat x = (rect.size.width - width)/2.0f;
    CGFloat y = (rect.size.height - height)/2.0f;
    CGContextFillEllipseInRect(context,CGRectMake(x, y, width, height));
}

/**
 *  画三角形
 *
 *  @param context  上下文
 *  @param topPoint 顶点
 *  @param length   边长
 */
- (void)drawTrangleWithContext:(CGContextRef)context rect:(CGRect)rect{
    
    CGPoint point = CGPointMake(self.frame.size.width/2.0f, 10);
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x - CircleArrowLength/2.0f, point.y + CircleArrowLength/2.0f);
    CGContextAddLineToPoint(context, point.x + CircleArrowLength/2.0f, point.y + CircleArrowLength/2.0f);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, self.trangleColor.CGColor);
    CGContextFillPath(context);

}

@end

//
//  CALayer+Animation.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "CALayer+Animation.h"

@implementation CALayer (Animation)
/**
 *  抖动动画
 *
 *  @param direction 方向
 */
- (void)shakeWithDirection:(Direction)direction{
    
    CAKeyframeAnimation *animation;
    
    switch (direction) {
        case Horizontal:
        {
            animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        }
            break;
        case Vertical:
        {
            animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        }
            break;
        default:
            break;
    }
    CGFloat value = 5.0f;
    animation.values = @[@(-value),@(0),@(value),@(0),@(-value),@(0),@(value),@(0)];
    animation.duration = 0.3f;
    animation.repeatCount = 2;
    animation.removedOnCompletion = YES;
    [self addAnimation:animation forKey:@"shake"];
}
/**
 *  位移
 *
 *  @param value1    其实位置
 *  @param value2    终点为之
 *  @param direction 持续时间
 */
- (void)positionFrom:(CGFloat)value1 to:(CGFloat)value2 direction:(CGFloat)direction{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.fromValue = [NSNumber numberWithFloat:value1];
    animation.toValue = [NSNumber numberWithFloat:value2];
    animation.duration = direction;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self addAnimation:animation forKey:@"position"];
}

@end

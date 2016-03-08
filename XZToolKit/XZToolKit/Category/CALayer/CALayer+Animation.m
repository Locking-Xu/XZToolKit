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
@end

//
//  CALayer+Animation.h
//  XZToolKit
//
//  Created by 徐章 on 16/3/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSUInteger, Direction){
    
    Horizontal,//水平
    Vertical//竖直
};

@interface CALayer (Animation)
/**
 *  抖动动画
 *
 *  @param direction 方向
 */
- (void)shakeWithDirection:(Direction)direction;
/**
 *  位移
 *
 *  @param value1    其实位置
 *  @param value2    终点为之
 *  @param direction 持续时间
 */
- (void)positionFrom:(CGFloat)value1 to:(CGFloat)value2 direction:(CGFloat)direction;
@end

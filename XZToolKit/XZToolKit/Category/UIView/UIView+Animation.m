//
//  UIView+Animation.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/13.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

- (void)transformToValues:(NSArray *)valuesArray duration:(CGFloat)duration{

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = valuesArray;
    
    animation.duration = duration;
    
    [self.layer addAnimation:animation forKey:@"scale"];
    
}

@end
